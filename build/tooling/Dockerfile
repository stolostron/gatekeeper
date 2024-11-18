FROM golang:1.22-bookworm@sha256:475ff60e52faaf037be2e7a1bc2ea5ea4aaa3396274af3def6545124a18b99b4

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
