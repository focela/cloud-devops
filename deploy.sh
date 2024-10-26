#!/bin/bash

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo '❌ Error: Docker is not installed.' >&2
  exit 1
fi

# Check if Docker Compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo '❌ Error: Docker Compose is not installed.' >&2
  exit 1
fi

# Stop any existing containers and deploy new services
echo "🚀 Stopping any existing containers and deploying new services..."
docker-compose down
docker-compose up -d

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "🎉 Internal services have been deployed successfully."
else
  echo "❌ Error: Failed to deploy internal services." >&2
  echo "📋 Showing Docker Compose logs for troubleshooting:"
  docker-compose logs --tail=50
  exit 1
fi

# Show status of the containers
echo "🔍 Checking the status of containers..."
docker-compose ps
