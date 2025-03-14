FROM golang:1.24-bullseye@sha256:aa106963247f64275bd459b6b713978f1633160da53f58115922964ab0b9eae7

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.25.4

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
