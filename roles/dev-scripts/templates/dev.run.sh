#!/bin/bash

CONTAINER_USER=node

SCRIPTS_DEV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$( cd "$( dirname "${SCRIPTS_DEV_DIR}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${SCRIPTS_DIR}" )" && pwd )"

echo "Run into temporary container..."

# run into container
docker run --rm --user=$CONTAINER_USER \
  --volume $BASE_DIR:/app \
  --volume $HOME/.ssh:/home/node/.ssh \
  --volume $HOME/.gitconfig:/home/node/.gitconfig \
  --volume $HOME/.npmrc:/home/node/.npmrc \
  -w="/app" {{ app_image_name }} sh -c "$*"
