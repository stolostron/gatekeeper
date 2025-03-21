FROM --platform=$BUILDPLATFORM golang:1.23-bookworm@sha256:462f68e1109cc0415f58ba591f11e650b38e193fddc4a683a3b77d29be8bfb2c AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT=""
ARG LDFLAGS

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    GOARM=${TARGETVARIANT}

WORKDIR /go/src/github.com/open-policy-agent/gatekeeper/test/pubsub/fake-subscriber

COPY . .

RUN go mod init && go mod tidy && go mod vendor

RUN go build -o main

FROM gcr.io/distroless/static-debian12@sha256:95ea148e8e9edd11cc7f639dc11825f38af86a14e5c7361753c741ceadef2167

WORKDIR /

COPY --from=builder /go/src/github.com/open-policy-agent/gatekeeper/test/pubsub/fake-subscriber/main .

USER 65532:65532

ENTRYPOINT ["/main"]
