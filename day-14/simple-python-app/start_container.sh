#!/bin/bash
set -e

IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"

# Log in to ECR
echo "Logging into ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Stop and remove the container with the specific name
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "No container named $CONTAINER_NAME is running."
fi

# Stop and remove any container using port 5000 (not just by name)
PORT_CONTAINER_ID=$(docker ps -q --filter "publish=5000")

if [ ! -z "$PORT_CONTAINER_ID" ]; then
    echo "Port 5000 is in use. Stopping container ID: $PORT_CONTAINER_ID"
    docker stop $PORT_CONTAINER_ID
    docker rm $PORT_CONTAINER_ID
else
    echo "No container is using port 5000."
fi

# Pull the latest image
echo "Pulling the latest image..."
docker pull $IMAGE

# Run the container
echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE

echo "Container started successfully."
