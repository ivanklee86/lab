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

# Template helm
helm template --namespace infrastructure ../applications/infrastructure/connect > manifests.yaml
kubectl apply -f manifests.yaml
