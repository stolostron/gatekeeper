ARG BUILDPLATFORM="linux/amd64"
ARG BUILDERIMAGE="golang:1.21-bullseye"
# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
ARG BASEIMAGE="gcr.io/distroless/static:nonroot"

FROM --platform=$BUILDPLATFORM $BUILDERIMAGE as builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT="" 
ARG LDFLAGS
ARG BUILDKIT_SBOM_SCAN_STAGE=true
ARG TARGETCGO=1

ENV GO111MODULE=on \
    CGO_ENABLED=${TARGETCGO} \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT} \
    CC=aarch64-linux-gnu-gcc \
    CROSS_COMPILE=aarch64-linux-gnu-

RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        apt -y update && apt -y install gcc-aarch64-linux-gnu && apt -y clean all; \
    elif [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then \
        apt -y update && apt -y install gcc-arm-none-eabi && apt -y clean all; \
    fi

WORKDIR /go/src/github.com/open-policy-agent/gatekeeper
COPY . .

RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        export CC=aarch64-linux-gnu-gcc; \
    elif [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then \
        export CC=arm-linux-gnueabihf-gcc; \
    fi; \
    go build -mod vendor -a -ldflags "${LDFLAGS}" -o manager

FROM $BASEIMAGE

WORKDIR /
COPY --from=builder /go/src/github.com/open-policy-agent/gatekeeper/manager .
USER 65532:65532
ENTRYPOINT ["/manager"]
