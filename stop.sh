#!/usr/bin/env bash
set -o errexit
set -o nounset

CONTAINER_NAME="refuel-run"

docker stop $CONTAINER_NAME
