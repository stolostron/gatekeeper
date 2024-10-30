FROM golang:1.22-bookworm@sha256:3f0457a0a56a926d93c2baf4cf0057a645e8ff69ff31314080fcc62389643b8e

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
