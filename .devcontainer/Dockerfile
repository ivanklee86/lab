# Build - tfswitcher (https://github.com/ASleepyCat/tfswitcher)
FROM rust:1-bookworm as rust-builder
RUN cargo install tfswitcher

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
        libncurses-dev libsqlite3-dev libbz2-dev libreadline-dev liblzma-dev tzdata tk-dev graphviz;

USER vscode

RUN sudo chown -R vscode /usr/local/bin

# - Install tfswitcher and OpenTofu
COPY --from=rust-builder /usr/local/cargo/bin/tfswitcher /usr/local/bin
ARG OPENTOFU_VERSION="1.6.1"
RUN tfswitcher -o ${OPENTOFU_VERSION}

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
