FROM ubuntu:24.04

COPY --from=quay.io/argoproj/argocd:v2.9.5  /usr/local/bin/argocd /usr/local/bin
COPY --from=cloudposse/github-commenter:0.19.0 /usr/bin/github-commenter /usr/local/bin
