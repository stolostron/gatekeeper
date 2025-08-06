FROM golang:1.24-bookworm@sha256:ef8c5c733079ac219c77edab604c425d748c740d8699530ea6aced9de79aea40

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.29.3

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
