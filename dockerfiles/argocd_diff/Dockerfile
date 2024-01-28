FROM ubuntu:24.04

# Update ca-certs
RUN apt-get update && apt-get install ca-certificates -y

# Install tools
COPY --from=quay.io/argoproj/argocd:v2.9.5  /usr/local/bin/argocd /usr/local/bin
COPY --from=cloudposse/github-commenter:0.19.0 /usr/bin/github-commenter /usr/local/bin
