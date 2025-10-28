FROM --platform=$BUILDPLATFORM golang:1.24-bookworm@sha256:e400aebe4e96e1d52b510fb7a82c417d9377f595f0160eb1bd979d441711d20c AS builder

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

WORKDIR /go/src/github.com/open-policy-agent/gatekeeper/test/export/fake-subscriber

COPY . .

RUN go mod init && go mod tidy && go mod vendor

RUN go build -o main

FROM gcr.io/distroless/static-debian12@sha256:8dd8d3ca2cf283383304fd45a5c9c74d5f2cd9da8d3b077d720e264880077c65

WORKDIR /

COPY --from=builder /go/src/github.com/open-policy-agent/gatekeeper/test/export/fake-subscriber/main .

USER 65532:65532

ENTRYPOINT ["/main"]
