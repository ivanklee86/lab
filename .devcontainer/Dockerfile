# Build - jsonnet (https://github.com/google/go-jsonnet)
FROM golang:1.24 as jsonnet-builder
RUN go install github.com/google/go-jsonnet/cmd/jsonnet@latest
RUN go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest
RUN go install github.com/google/go-jsonnet/cmd/jsonnetfmt@latest

# Runtime
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# - Setup
ENV HOME="/home/vscode"
WORKDIR /home/vscode

# - Install standard packages
RUN apt-get update && \
        # General purpose tools
    apt-get install -y curl git \
        software-properties-common \
        gnupg2 apt-transport-https openssh-client vim \
        # Python
        libsasl2-dev libldap2-dev libssl-dev libsnmp-dev libffi-dev \
        libncurses-dev libsqlite3-dev libbz2-dev libreadline-dev liblzma-dev tzdata tk-dev graphviz \
        # Tools
        ripgrep;

USER vscode

RUN sudo chown -R vscode /usr/local/bin

# - Install tenv
RUN TENV_URL=`curl -s https://api.github.com/repos/tofuutils/tenv/releases/latest | grep '"browser_download_url":' | grep 'amd64.deb' | grep -vE '(\.pem|\.sig|\.gpgsig)' | grep -o 'https://[^"]*'` && \
    curl -O -L $TENV_URL && \
    sudo dpkg -i "${TENV_URL##*/}"

# - Install jsonnet tools
COPY --from=jsonnet-builder /go/bin/jsonnet /usr/local/bin
COPY --from=jsonnet-builder /go/bin/jsonnet-lint /usr/local/bin
COPY --from=jsonnet-builder /go/bin/jsonnetfmt /usr/local/bin

# - Install tools with scripts
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
RUN curl -sL https://civo.com/get | sh

# - Install tools from Docker
COPY --from=ghcr.io/spacelift-io/spacectl /usr/local/bin/spacectl /usr/local/bin
COPY --from=1password/op:2 /usr/local/bin/op /usr/local/bin/op
COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin
COPY --from=alpine/helm /usr/bin/helm /usr/local/bin
COPY --from=derailed/k9s /bin/k9s /usr/local/bin
COPY --from=hadolint/hadolint:latest-debian /bin/hadolint /usr/local/bin
COPY --from=quay.io/argoproj/argocd /usr/local/bin/argocd /usr/local/bin
COPY --from=hairyhenderson/gomplate:stable /gomplate /usr/local/bin
COPY --from=grafana/tanka:latest /usr/local/bin/jb /usr/local/bin
COPY --from=grafana/tanka:latest /usr/local/bin/tk /usr/local/bin
COPY --from=mikefarah/yq:latest /usr/bin/yq /usr/local/bin

# - Install Argo Rollouts
RUN curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64 && \
    chmod +x ./kubectl-argo-rollouts-linux-amd64 && \
    mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

# - Install pyenv
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="/home/vscode/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:${HOME}/.local/bin:${PATH}"
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

ARG PYTHON_VERSION="3.12"
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}

# -- Modify dotfile
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
RUN echo 'export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

# - Set up Git
RUN git config --global user.name "Ivan Lee"
RUN git config --global user.email "ivanklee86@gmail.com"
RUN git config --global push.autoSetupRemote true
