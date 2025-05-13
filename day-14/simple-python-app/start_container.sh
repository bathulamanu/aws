#!/bin/bash
set -e

IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"

echo "Pulling latest image from ECR..."
docker pull $IMAGE

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE
