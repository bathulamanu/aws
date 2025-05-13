#!/bin/bash
set -e

# Name of the container we want to stop
CONTAINER_NAME="admin-container"

echo "Looking for running container: $CONTAINER_NAME"

# Stop and remove container by name (if running)
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "No running container named $CONTAINER_NAME"
fi

# Free up port 5000 if any container is still using it
PORT_CONTAINER_ID=$(docker ps -q --filter "publish=5000")

if [ ! -z "$PORT_CONTAINER_ID" ]; then
    echo "Port 5000 is still in use by container $PORT_CONTAINER_ID. Stopping it..."
    docker stop $PORT_CONTAINER_ID
    docker rm $PORT_CONTAINER_ID
else
    echo "No container is using port 5000"
fi
