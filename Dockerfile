FROM --platform=$BUILDPLATFORM golang:1.24-bookworm@sha256:fa1a01d362a7b9df68b021d59a124d28cae6d99ebd1a876e3557c4dd092f1b1d AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""
ARG LDFLAGS
ARG BUILDKIT_SBOM_SCAN_STAGE=true

ENV GO111MODULE=on \
    CGO_ENABLED=1 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT}

RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        apt -y update && apt -y install gcc-aarch64-linux-gnu && apt -y clean all; \
    elif [ "${TARGETPLATFORM}" = "linux/arm/v8" ]; then \
        apt -y update && apt -y install gcc-arm-linux-gnueabihf && apt -y clean all; \
    fi

WORKDIR /go/src/github.com/open-policy-agent/gatekeeper

# Copy the Go module manifests and dependencies
COPY go.mod go.mod
COPY go.sum go.sum
COPY vendor/ vendor/

# Copy the source code
COPY main.go main.go
COPY apis/ apis/
COPY pkg/ pkg/

# Build the controller
RUN  if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        export CC=aarch64-linux-gnu-gcc; \
    elif [ "${TARGETPLATFORM}" = "linux/arm/v8" ]; then \
        export CC=arm-linux-gnueabihf-gcc; \
    fi; \
    go build -mod vendor -a -ldflags "${LDFLAGS}" -o manager

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
# 
# CGO_ENABLED requires the 'base' image: 
# - https://github.com/GoogleContainerTools/distroless/blob/main/base/README.md
FROM gcr.io/distroless/base-debian12:nonroot

WORKDIR /
COPY --from=builder /go/src/github.com/open-policy-agent/gatekeeper/manager .
USER 65532:65532
ENTRYPOINT ["/manager"]
