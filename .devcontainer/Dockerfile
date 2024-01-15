# Build - tfswitcher (https://github.com/ASleepyCat/tfswitcher)
FROM rust:1-bookworm as rust-builder
RUN cargo install tfswitcher

# Runtime
# - Arguments

FROM mcr.microsoft.com/devcontainers/base:ubuntu

# - Setup
ENV HOME="/home/vscode"
WORKDIR /home/vscode

# - Install standard packages
RUN apt-get update && \
    apt-get install -y curl git \
        software-properties-common \
        gnupg2 apt-transport-https;


COPY --from=rust-builder /usr/local/cargo/bin/tfswitcher /usr/local/bin

# - Instorm OpenTofu version
ARG TERRAFORM_VERSION="1.6.0"
RUN tfswitcher -o ${TERRAFORM_VERSION}

# - Install tfgrunt
RUN curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | bash
ARG TERRAGRUNT_VERSION="0.54.17"
RUN tgswitch ${TERRAGRUNT_VERSION}

# - Install task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# - Install pyenv
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="/home/vscode/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:${HOME}/.local/bin:${PATH}"
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

RUN pyenv install 3.11 3.12
ARG PYTHON_VERSION="3.12"
RUN pyenv global ${PYTHON_VERSION}

# -- Modify dotfile
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
RUN echo 'export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
