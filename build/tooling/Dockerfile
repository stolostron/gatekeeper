FROM golang:1.24-bookworm@sha256:e400aebe4e96e1d52b510fb7a82c417d9377f595f0160eb1bd979d441711d20c

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
