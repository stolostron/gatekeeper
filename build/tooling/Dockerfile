FROM golang:1.24-bookworm@sha256:2679c15c940573aded505b2f2fbbd4e718b5172327aae3ab9f43a10a5c700dfc

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
