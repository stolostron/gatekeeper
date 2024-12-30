FROM golang:1.22-bookworm@sha256:40d4065ea501aca565ab48cd00fe42623d216aeefda105b1ba8defbac832b3ef

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
