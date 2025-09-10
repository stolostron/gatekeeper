# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

## Project Overview

This is a fork of the Open Policy Agent (OPA) Gatekeeper project, customized for Red Hat Advanced
Cluster Management (stolostron). Gatekeeper is a Kubernetes admission controller that enforces
policies using Open Policy Agent and manages Custom Resource Definitions (CRDs) for constraint
templates and constraints.

## Key Commands

### Building and Development

- `make all` - Build, lint, and test the project
- `make manager` - Build the manager binary
- `make docker-buildx` - Build the container image using buildx
- `make docker-buildx-crds` - Build the CRDs container image
- `make manifests` - Generate manifests (CRDs, RBAC, etc.)

### Testing

- `make test` - Run tests in Docker container (calls native-test)
- `make native-test` - Run unit tests with coverage
- `make test-e2e` - Run end-to-end tests using bats
- `make test-gator` - Run gator CLI tests
- `make benchmark-test` - Run performance benchmarks

### Quality and Linting

- `make lint` - Run golangci-lint in Docker container
- `make generate` - Generate code using controller-gen and conversion-gen

### Deployment

- `make deploy` - Deploy to configured Kubernetes cluster
- `make install` - Install CRDs into cluster
- `make uninstall` - Remove deployment from cluster

### Gator CLI

- `make gator` - Build the gator CLI tool
- `make test-gator-verify` - Test policy verification
- `make test-gator-test` - Test gator functionality
- `make test-gator-expand` - Test template expansion

## Architecture

This is a Go-based Kubernetes controller project with the following key components:

### Core Structure

- `cmd/` - CLI tools and main entry points
- `pkg/` - Core application logic
- `apis/` - Kubernetes API definitions and CRDs
- `config/` - Kustomize configurations and manifests
- `test/` - Test suites and test data

### Key Components

- **Manager**: Main controller that runs admission and audit webhooks
- **Gator**: CLI tool for policy testing and verification
- **CRDs**: Custom Resource Definitions for constraint templates and constraints
- **Webhooks**: Admission and mutation webhooks for policy enforcement

### Build System

- Uses Go modules with vendored dependencies (`go mod vendor`)
- Multi-stage Docker builds with buildx for cross-platform images
- Kustomize for manifest generation and overlays
- Controller-gen for generating CRDs and RBAC

### Testing Framework

- Unit tests using Go's testing package with envtest
- E2E tests using bats (Bash Automated Testing System)
- Integration tests for gator CLI
- Docker-based testing environment

## Fork-Specific Information

This fork is maintained by the stolostron organization and includes customizations for:

- Image repository changes (quay.io/gatekeeper/gatekeeper instead of openpolicyagent/gatekeeper)
- Release process specific to stolostron
- Version management and tagging for ACM releases

The release process documentation is in `docs/README.md` and involves rebasing stolostron
customizations onto upstream releases.

## Development Notes

- Uses Go 1.21+ with module-based dependency management
- All code generation and building should be done through Make targets
- Docker-based tooling ensures consistent build environment
- Pre-commit hooks may be configured (check for failures on commit)
