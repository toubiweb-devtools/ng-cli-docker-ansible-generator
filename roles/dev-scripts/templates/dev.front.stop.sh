#!/bin/bash

CONTAINER_NAME={{ app_container_name }}

SCRIPTS_DEV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$( cd "$( dirname "${SCRIPTS_DEV_DIR}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${SCRIPTS_DIR}" )" && pwd )"

echo "Stop $CONTAINER_NAME container..."

docker stop $CONTAINER_NAME
