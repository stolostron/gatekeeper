FROM golang:1.22-bookworm@sha256:500f7d97a7e7f7cf783205f1c17177702933dad301442a04666b274fd5b6d24a

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
