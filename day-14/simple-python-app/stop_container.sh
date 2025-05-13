#!/bin/bash
set -e

# Define variables
IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"
PORT=5000

echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

echo "Stopping any existing container using port $PORT..."
EXISTING_CONTAINER=$(docker ps -q --filter "publish=$PORT")
if [ ! -z "$EXISTING_CONTAINER" ]; then
  docker stop $EXISTING_CONTAINER
  docker rm $EXISTING_CONTAINER
fi

echo "Stopping and removing existing container named $CONTAINER_NAME (if exists)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Pulling latest image from ECR..."
docker pull $IMAGE

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p 80:$PORT $IMAGE
