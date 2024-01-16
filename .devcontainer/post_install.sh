#!/bin/bash
set -ex

# Install basic Python packages
pip install -U pip poetry

# Set up poetry
poetry config cache-dir /workspaces/lab/.cache
poetry config virtualenvs.in-project true

# Intall dependencies
poetry install
