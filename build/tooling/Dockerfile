FROM golang:1.22-bookworm@sha256:0d22c0d84536a5bb9bdd5b65b71fad5df32e648b2dfd10cb3fd87e4063da0f9c

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
