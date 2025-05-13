#!/bin/bash
set -e

CONTAINER_NAME="admin-container"

# Stop and remove the named container (if running)
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "No container named $CONTAINER_NAME is running."
fi

# Stop and remove any container using port 5000
PORT_CONTAINER_ID=$(docker ps -q --filter "publish=5000")

if [ ! -z "$PORT_CONTAINER_ID" ]; then
    echo "Port 5000 is in use. Stopping container ID: $PORT_CONTAINER_ID"
    docker stop $PORT_CONTAINER_ID
    docker rm $PORT_CONTAINER_ID
else
    echo "No container is using port 5000."
fi
