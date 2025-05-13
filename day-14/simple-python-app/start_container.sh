#!/bin/bash
set -e

IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
CONTAINER_NAME="admin-container"

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Pull latest image
docker pull $IMAGE

# Start container
docker run -d --name $CONTAINER_NAME -p 5000:5000 $IMAGE
