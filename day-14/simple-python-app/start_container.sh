#!/bin/bash
set -e

# Define variables
IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"

# Ensure Docker is installed and running
echo "Checking Docker status..."
if ! systemctl is-active --quiet docker; then
    echo "Docker is not running. Starting Docker..."
    sudo systemctl start docker
else
    echo "Docker is running."
fi

# Login to ECR (make sure EC2 has permission)
echo "Logging in to ECR..."
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Stop and remove the existing container if it exists
echo "Stopping and removing any existing container named $CONTAINER_NAME..."
sudo docker stop $CONTAINER_NAME || true
sudo docker rm $CONTAINER_NAME || true

# Pull the image from ECR
echo "Pulling Docker image from ECR..."
sudo docker pull $IMAGE

# Run the Docker image as a container
echo "Starting container..."
sudo docker run -d --name $CONTAINER_NAME -p 80:5000 $IMAGE

echo "Container started successfully."
