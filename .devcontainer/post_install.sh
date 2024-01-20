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
