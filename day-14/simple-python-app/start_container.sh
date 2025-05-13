#!/bin/bash
set -e

# Define variables
IMAGE="abhishekf5/simple-python-flask-app:latest"
CONTAINER_NAME="myapp-container"
NEW_PORT="8080"  # New port to bind to

# Stop and remove any previously running container (if any)
echo "Stopping and removing the previous container (if any)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Pull the image from Docker Hub
echo "Pulling Docker image from Docker Hub..."
docker pull $IMAGE

# Run the Docker container on the new port
echo "Starting the container on port $NEW_PORT..."
docker run -d --name $CONTAINER_NAME -p $NEW_PORT:5000 $IMAGE

echo "Container started on port $NEW_PORT."

