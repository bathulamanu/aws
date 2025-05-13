#!/bin/bash
set -e

IMAGE="495599757751.dkr.ecr.us-east-1.amazonaws.com/admin:latest"
OLD_CONTAINER="admin-container"
NEW_CONTAINER="admin-container-new"
PORT_OLD=80
PORT_NEW=81

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 495599757751.dkr.ecr.us-east-1.amazonaws.com

# Pull the latest image
echo "Pulling latest Docker image..."
docker pull $IMAGE

# Run new container on different port
echo "Starting new container on port $PORT_NEW..."
docker run -d --name $NEW_CONTAINER -p $PORT_NEW:5000 $IMAGE

# Optional: Wait until the new container is healthy
echo "Waiting for new container to be ready..."
sleep 10  # Or check health with curl or docker inspect

# Switch traffic: remove old container, restart new one on main port
echo "Switching containers..."
docker stop $OLD_CONTAINER || true
docker rm $OLD_CONTAINER || true

docker stop $NEW_CONTAINER
docker rm $NEW_CONTAINER

# Start new container on the original port
docker run -d --name $OLD_CONTAINER -p $PORT_OLD:5000 $IMAGE

echo "Deployment complete with zero-downtime!"

