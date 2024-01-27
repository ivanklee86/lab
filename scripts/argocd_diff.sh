#!/bin/bash
argocd app diff --grpc-web --server argocd.aoach.tech --auth-token $ARGOCD_JWT --local=$2 $1 --exit-code=false
