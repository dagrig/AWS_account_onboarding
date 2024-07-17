#!/bin/bash

# Ensure the .env file exists
if [ ! -f .env ]; then
  echo ".env file not found!"
  exit 1
fi

# Export all environment variables prefixed with TF_VAR_ from the .env file
export $(grep -v '^#' .env | xargs)

echo "Environment variables loaded from .env file."