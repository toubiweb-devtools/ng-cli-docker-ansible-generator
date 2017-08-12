#!/bin/bash

CONTAINER_NAME={{ app_container_name }}
CONTAINER_USER=node

SCRIPTS_DEV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$( cd "$( dirname "${SCRIPTS_DEV_DIR}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${SCRIPTS_DIR}" )" && pwd )"

$SCRIPTS_DEV_DIR/dev.front.start.sh

echo "Enter to $CONTAINER_NAME container..."

# enter interactively to container
docker exec -it --user=$CONTAINER_USER $CONTAINER_NAME /bin/bash
