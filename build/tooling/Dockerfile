FROM golang:1.22-bookworm@sha256:f3706474de837d10a34ca80dfaf085f9b6c2fd2503f9b43add5929aa46abfa18

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
