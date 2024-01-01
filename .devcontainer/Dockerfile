FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && \
# Prep tools also for asdf (last 2)
    apt-get install -y curl git \
        software-properties-common \
        gnupg2 apt-transport-https \
# Prep deps for non-root user
        sudo;

ENV HOME="/home/vscode"

# Install asdf
RUN \
    # Configure git to get rid of detached head warnings
    git config --global advice.detachedHead false; \
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch  v0.13.1; \
    /bin/bash -c 'echo -e "\n\n## Configure ASDF \n. $HOME/.asdf/asdf.sh" >> ~/.bashrc'; \
    /bin/bash -c 'echo -e "\n\n## ASDF Bash Completion: \n. $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc'; \
    exec bash; 
