#!/bin/bash
set -ex

# Configure poetry
pip install poetry
WORKSPACE_DIR=$(pwd)
poetry config cache-dir ${WORKSPACE_DIR}/.cache
poetry config virtualenvs.in-project true
