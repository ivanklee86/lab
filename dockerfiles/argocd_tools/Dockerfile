FROM golang:1.24 as go_builder

RUN go install github.com/yannh/kubeconform/cmd/kubeconform@v0.4.13

FROM ubuntu:noble-20241015

# Update ca-certs
RUN apt-get update && apt-get install --no-install-recommends ca-certificates -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create working folder
RUN mkdir /argocd_diff
WORKDIR /argocd_diff

# Install tools
COPY --from=quay.io/argoproj/argocd:v2.14.13  /usr/local/bin/argocd /usr/local/bin
COPY --from=cloudposse/github-commenter:0.28.0 /usr/bin/github-commenter /usr/local/bin
COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate
COPY --from=go_builder /go/bin/kubeconform /usr/local/bin
COPY --from=mikefarah/yq:latest /usr/bin/yq /usr/local/bin

COPY *.md.tmpl .
