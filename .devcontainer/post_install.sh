#!/bin/bash
set -ex

# Install basic Python packages
pip install -U pip poetry

# Set up poetry
WORKSPACE_DIR=$(pwd)
poetry config cache-dir ${WORKSPACE_DIR}/.cache
poetry config virtualenvs.in-project true

# Intall dependencies
poetry install --no-root

# pre-commit
poetry run pre-commit install

# Set up GPG if not codespaces
if [ "$CODESPACES" != "true" ]; then
    echo "Running locally, configure gpg."

    git config --global gpg.program gpg2
    git config --global user.signingkey ivanklee86@gmail.com
    git config --global commit.gpgsign true
    git config --global push.autoSetupRemote true
else
    echo "Running in codespaces."
fi
