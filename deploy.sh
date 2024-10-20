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

# Directory path for mounting data
DATA_DIR="/home/data/npm"

# Create the necessary directories if they do not exist
if [ ! -d "$DATA_DIR/mysql" ]; then
  echo "📁 Creating directory: $DATA_DIR/mysql"
  mkdir -p "$DATA_DIR/mysql"
fi

if [ ! -d "$DATA_DIR/data" ]; then
  echo "📁 Creating directory: $DATA_DIR/data"
  mkdir -p "$DATA_DIR/data"
fi

if [ ! -d "$DATA_DIR/letsencrypt" ]; then
  echo "📁 Creating directory: $DATA_DIR/letsencrypt"
  mkdir -p "$DATA_DIR/letsencrypt"
fi

echo "✅ All necessary directories have been created."

# Path to the directory containing the docker-compose.yml file
COMPOSE_DIR="/var/www/cloud-devops"

# Check if the Docker Compose directory exists
if [ ! -d "$COMPOSE_DIR" ]; then
  echo "❌ Error: Directory $COMPOSE_DIR does not exist." >&2
  exit 1
fi

# Change to the directory containing docker-compose.yml
cd "$COMPOSE_DIR"

# Run Docker Compose to deploy Nginx Proxy Manager
echo "🚀 Deploying Nginx Proxy Manager with Docker Compose from $COMPOSE_DIR..."
docker-compose up -d

echo "🎉 Nginx Proxy Manager has been deployed successfully."
