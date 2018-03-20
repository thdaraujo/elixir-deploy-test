#!/usr/bin/env bash
set -o errexit
set -o nounset

APP_NAME=$(grep app: mix.exs | sed 's/^.*app: ://' | sed 's/,//')
RELEASE_DIR="export"

mkdir -p "${RELEASE_DIR}"

# Remove old releases
rm -rf _build/prod/rel/*
rm -rf "${RELEASE_DIR}/*"

echo "Building release..."

# Build the image
docker build -t refuel:latest .

# Copy release to host
# Run the image as a container
# in order to be able to copy the file to the host.

echo "Exporting release..."

ID=$(docker create refuel:latest)
docker cp "${ID}:/opt/app/${APP_NAME}.tar.gz" "${RELEASE_DIR}/${APP_NAME}.tar.gz"
docker rm -v "${ID}"

echo "Done -> ${RELEASE_DIR}/${APP_NAME}.tar.gz"
