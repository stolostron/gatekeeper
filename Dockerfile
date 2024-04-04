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

RUN apt -y update && apt -y install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu g++-x86-64-linux-gnu libc6-dev-amd64-cross libjpeg-dev:amd64 && apt -y clean all
     
WORKDIR /go/src/github.com/open-policy-agent/gatekeeper
COPY . .

RUN go build -mod vendor -a -ldflags "${LDFLAGS}" -o manager

FROM $BASEIMAGE

WORKDIR /
COPY --from=builder /go/src/github.com/open-policy-agent/gatekeeper/manager .
USER 65532:65532
ENTRYPOINT ["/manager"]
