#!/bin/bash
set -e

# Define variables
IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"

# Login to ECR (make sure EC2 has permission)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Remove the previous container if it exists
echo "Stopping and removing previous container (if any)..."
docker stop $CONTAINER_NAME || true  # Stop the container if it's running
docker rm $CONTAINER_NAME || true    # Remove the container if it exists

# Pull the latest image from ECR
echo "Pulling Docker image from ECR..."
docker pull $IMAGE

# Run the Docker image as a new container
echo "Starting container..."
docker run -d --name $CONTAINER_NAME -p 80:5000 $IMAGE
