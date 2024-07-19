#!/bin/bash

# Ensure the .env file exists
if [ ! -f .env ]; then
  echo ".env file not found!"
  exit 1
fi

# Export all environment variables prefixed with TF_VAR_ from the .env file
set -a
. ./.env
set +a

echo "Environment variables loaded from .env file."