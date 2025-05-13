#!/bin/bash
set -e

# Define variables
IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"
PORT=5000

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Stop and remove any container using the same name
echo "Stopping and removing container named $CONTAINER_NAME (if exists)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Find and kill any container using the port
CONTAINER_USING_PORT=$(docker ps -q --filter "publish=$PORT")
if [ ! -z "$CONTAINER_USING_PORT" ]; then
    echo "Stopping container using port $PORT..."
    docker stop $CONTAINER_USING_PORT
    docker rm $CONTAINER_USING_PORT
fi

# Pull the latest image
echo "Pulling image $IMAGE..."
docker pull $IMAGE

# Run the container
echo "Running new container..."
docker run -d --name $CONTAINER_NAME -p 80:$PORT $IMAGE
