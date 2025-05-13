#!/bin/bash
set -e

echo "Checking for any container using port 5000..."

CONTAINER_ID=$(docker ps --filter "publish=5000" --format "{{.ID}}")

if [ -n "$CONTAINER_ID" ]; then
    echo "Stopping and removing container ID: $CONTAINER_ID"
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID
else
    echo "No container using port 5000 found."
fi
