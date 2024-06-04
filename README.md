# Bridge to Kubernetes Sample

This repository provides the sample artifacts to get started with debugging and testing with Bridge for Kubernetes.

## Getting Started

```bash
# Provision the local cluster
kind create cluster

# Build Docker images of the .NET application
make build

# Upload Docker images to Kubernetes nodes
make upload

# Apply Kustomize overlays and apply Kubernetes manifests
make apply

# List namespaced Kubernetes resources and watch
make list
```

Follow the [Use Bridge to Kubernetes (VS Code)](https://learn.microsoft.com/en-us/visualstudio/bridge/bridge-to-kubernetes-vs-code) guide to get started.

## Tools

- [Bridge to Kubernetes](https://learn.microsoft.com/en-us/visualstudio/bridge/)

## Debugging

```bash
# HTTP
curl -k -L http://localhost:5062/basket

# HTTPS
curl -k https://localhost:7295/basket
```
