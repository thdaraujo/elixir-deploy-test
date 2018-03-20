#!/usr/bin/env bash
set -o errexit
set -o nounset

USER="ubuntu"
SERVER="18.222.90.201"
HOST="${USER}@${SERVER}"

VERSION=$(grep version mix.exs | sed 's/^.*version: "//' | sed 's/",//')
APP_NAME=$(grep app: mix.exs | sed 's/^.*app: ://' | sed 's/,//')
RELEASE_DIR="export"
LOCAL_FILENAME="${APP_NAME}.tar.gz"
ARTIFACT="${RELEASE_DIR}/${LOCAL_FILENAME}"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
REMOTE_FILENAME="${TIMESTAMP}-${LOCAL_FILENAME}"
REMOTE_FILE_PATH="/home/${USER}/deploy/${APP_NAME}/${REMOTE_FILENAME}"

# remote folders:
# deploy/$APP_NAME  -> to store the tarballs
# opt/app/$APP_NAME -> to store the current version of the project

{
if [ ! -f "${ARTIFACT}" ]; then
    echo "Error: release file not found! (${ARTIFACT})"
    exit 1
fi
}

ssh-keyscan "${SERVER}" >> ~/.ssh/known_hosts

echo "Deploying ${APP_NAME} ${VERSION} to ${HOST}"

scp "${ARTIFACT}" "${HOST}:${REMOTE_FILE_PATH}"

echo "File ${HOST}:${REMOTE_FILE_PATH} created."

ssh -T "${HOST}" << EOSSH
  cd /home/${USER}/opt/app/${APP_NAME} && \
  ./bin/${APP_NAME} stop || true  && \
  rm -rf bin && rm -rf erts-9.3 && rm -rf lib && rm -rf releases && rm -rf var  && \
  cd /home/${USER}/opt/app/ && tar -xf ${REMOTE_FILE_PATH} -C ${APP_NAME}/ && \
  cd /home/${USER}/opt/app/${APP_NAME} && ./bin/${APP_NAME} start && sleep 10 && ./bin/${APP_NAME} ping && \
  exit 0
EOSSH

if [[ $? = 1 ]]; then
   echo "Remote call failed. Try again."
   exit 1
fi

echo "Deployed!"
