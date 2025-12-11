FROM golang:1.24-bookworm@sha256:fc58bb98c4b7ebc8211c94df9dee40489e48363c69071bceca91aa59023b0dee

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
