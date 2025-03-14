FROM golang:1.23-bookworm@sha256:558c9ecc3418f90a89919a9ce440a42eb130314c92401a9de19f5566a6eb275e

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
