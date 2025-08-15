FROM --platform=$BUILDPLATFORM golang:1.25-bookworm@sha256:74908ad827a5849c557eeca81d46263acf788ead606102d83466f499f83e35b1 AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""
ARG LDFLAGS

ENV GO111MODULE=on \
    CGO_ENABLED=1 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT}

COPY . /go/src/github.com/open-policy-agent/gatekeeper
WORKDIR /go/src/github.com/open-policy-agent/gatekeeper/cmd/gator

RUN go build -mod vendor -a -ldflags "${LDFLAGS}" -o /gator

FROM --platform=$BUILDPLATFORM gcr.io/distroless/static-debian12@sha256:2e114d20aa6371fd271f854aa3d6b2b7d2e70e797bb3ea44fb677afec60db22c AS build
USER 65532:65532
COPY --from=builder --chown=65532:65532 /gator /gator
ENTRYPOINT ["/gator"]
