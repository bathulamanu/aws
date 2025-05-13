#!/bin/bash
set -e

PORT=5000

echo "Looking for containers using port $PORT..."
CONTAINER_ID=$(docker ps --filter "publish=0.0.0.0:$PORT" --format "{{.ID}}")

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping container using port $PORT: $CONTAINER_ID"
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
else
    echo "No container is using port $PORT"
fi
