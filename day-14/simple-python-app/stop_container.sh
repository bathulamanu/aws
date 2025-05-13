#!/bin/bash
set -e

CONTAINER_NAME="admin-container"

# Find container using the port (5000)
EXISTING_CONTAINER_ID=$(docker ps -q --filter "publish=5000")

if [ -n "$EXISTING_CONTAINER_ID" ]; then
    echo "Stopping container using port 5000 (ID: $EXISTING_CONTAINER_ID)..."
    docker stop $EXISTING_CONTAINER_ID
    docker rm $EXISTING_CONTAINER_ID
else
    echo "No container found using port 5000."
fi
