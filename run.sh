#!/usr/bin/env bash
set -o errexit
set -o nounset

CONTAINER_NAME="refuel-run"

# Remove container if exists?
docker stop "${CONTAINER_NAME}" || true && docker rm "${CONTAINER_NAME}" || true

# Run container on port 4000
docker run --name "${CONTAINER_NAME}" -t -p 4000:4000 refuel:latest
