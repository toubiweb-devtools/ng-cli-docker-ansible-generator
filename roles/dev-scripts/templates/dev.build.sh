#!/bin/bash

SCRIPTS_DEV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE_NAME={{ app_image_name }}

DOCKER_TAG={{ app.frontend.docker.node_version }}-npm{{ app.frontend.docker.npm_version }}

echo ""
echo "###########################################"
echo ""
echo "# BUILD:"
echo ""
docker pull node:{{ app.frontend.docker.node_version }}
docker build -t=$IMAGE_NAME -f /$SCRIPTS_DEV_DIR/dev.dockerfile /$SCRIPTS_DEV_DIR
docker tag $IMAGE_NAME $IMAGE_NAME:$DOCKER_TAG

echo "###########################################"
echo ""
echo ""
echo "# DOCKER PUBLISH ALL:"
echo ""
echo "To publish, run:"
echo ""
echo "docker push $IMAGE_NAME"
echo ""
echo "###########################################"
echo ""
