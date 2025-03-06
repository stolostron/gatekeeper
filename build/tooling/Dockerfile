FROM golang:1.23-bullseye@sha256:b7575efc7b1ca22e9ce7510979d4c1b5564c970279a66aea44e8b57ed133bfc7

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.25.4

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
