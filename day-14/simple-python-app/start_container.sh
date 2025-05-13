#!/bin/bash
set -e

# Define variables
IMAGE="abhishekf5/simple-python-flask-app:latest"
CONTAINER_NAME="flask-app"
HOST_PORT=5000
CONTAINER_PORT=5000

# Stop and remove previous container if running
echo "Checking if container exists..."
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME || true
    docker rm $CONTAINER_NAME || true
fi

# Free up port if something is stuck (rare case)
echo "Checking if port $HOST_PORT is still used..."
fuser -k ${HOST_PORT}/tcp || true

# Pull latest image
echo "Pulling latest image: $IMAGE"
docker pull $IMAGE

# Run the container
echo "Running container on port $HOST_PORT..."
docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $IMAGE

echo "Container $CONTAINER_NAME is now running on port $HOST_PORT."
