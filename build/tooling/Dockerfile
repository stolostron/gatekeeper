FROM golang:1.24-bookworm@sha256:3ce988c30fa67dc966ca716ee0ce7ad08d7330573e808cb68ada7e419bdf23de

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
