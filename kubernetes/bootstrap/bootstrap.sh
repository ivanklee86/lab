#!/bin/bash

# Cleanup
rm onepassword-token.yaml op-credentials.yaml

# Set up infrastructure namespace
kubectl apply -f namespace.yaml

# Create 1PW secrets
op inject -i onepassword-token.yaml.tmpl -o onepassword-token.yaml
kubectl apply -f onepassword-token.yaml
op inject -i op-credentials.yaml.tmpl -o op-credentials.yaml
kubectl apply -f op-credentials.yaml

# Template 1PW operator
helm template --namespace infrastructure --include-crds ../applications/infrastructure/connect > manifests.yaml
kubectl apply -f manifests.yaml

# Template ArgoCD
helm template --release-name argocd --namespace infrastructure ../applications/infrastructure/argocd > manifests.yaml
kubectl apply -f manifests.yaml

# Bootstrap applications
kubectl apply -f application.yaml
