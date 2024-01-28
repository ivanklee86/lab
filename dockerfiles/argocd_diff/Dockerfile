FROM ubuntu:24.04

# Update ca-certs
RUN apt-get update && apt-get install ca-certificates -y

# Create working folder
RUN mkdir /argocd_diff
WORKDIR /argocd_diff

# Install tools
COPY --from=quay.io/argoproj/argocd:v2.9.5  /usr/local/bin/argocd /usr/local/bin
COPY --from=cloudposse/github-commenter:0.19.0 /usr/bin/github-commenter /usr/local/bin
COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate

COPY *.md.tmpl .
