#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "Running from $(pwd) "

echo "Checking if Poetry is installed "

if ! command -v poetry &> /dev/null; then
  echo "Installing Poetry "
  curl -sSL https://install.python-poetry.org | python3 -
  export PATH="$HOME/.local/bin:$PATH"
else
  echo "Poetry is already installed. "
fi

echo "Installing dependencies "
poetry install

echo "Running DataHub CLI "
poetry run datahub version

echo "dbt-postgres version: "
poetry run dbt --version
