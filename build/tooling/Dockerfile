FROM golang:1.23-bullseye@sha256:8731dcb40a7b879ccb493fa4fa38e83d9f33ca24ab60bec02e98d5af7e962cac

RUN GO111MODULE=on go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.14.0
RUN GO111MODULE=on go install k8s.io/code-generator/cmd/conversion-gen@v0.25.4

RUN mkdir /gatekeeper
WORKDIR /gatekeeper
