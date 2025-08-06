FROM --platform=$TARGETPLATFORM registry.k8s.io/kubectl:v1.33.3@sha256:aee0d617a26c05f79f566f710fee7afa9f72336fb4499f6f5f7b9ca00c6cde0c AS builder

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

FROM scratch AS build
USER 65532:65532
COPY --chown=65532:65532 * /crds/
COPY --from=builder /bin/kubectl /kubectl
ENTRYPOINT ["/kubectl"]
