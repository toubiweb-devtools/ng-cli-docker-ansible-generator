#!/bin/bash

CONTAINER_NAME={{ app_container_name }}

SCRIPTS_DEV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$( cd "$( dirname "${SCRIPTS_DEV_DIR}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${SCRIPTS_DIR}" )" && pwd )"

export DEV_WORKING_DIR="$BASE_DIR/{{ app.frontend.directory }}"

echo "Start $CONTAINER_NAME container..."

# ensure container exists and runs
docker-compose --file $SCRIPTS_DEV_DIR/dev.front.docker-compose.yml up -d
