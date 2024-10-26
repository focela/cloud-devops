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
DATA_DIR="/home/data"

# Function to create necessary directories if they do not exist
create_directory() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    echo "📁 Creating directory: $dir"
    mkdir -p "$dir"
  fi
}

# Create main data directory and subdirectories for services
create_directory "$DATA_DIR/npm/mysql"
create_directory "$DATA_DIR/npm/data"
create_directory "$DATA_DIR/npm/letsencrypt"
create_directory "$DATA_DIR/gitlab/database"
create_directory "$DATA_DIR/gitlab/redis"
create_directory "$DATA_DIR/jira/mysql"
create_directory "$DATA_DIR/jira/home_data"

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

# Run Docker Compose to deploy services
echo "🚀 Deploying internal services with Docker Compose from $COMPOSE_DIR..."
docker-compose up -d

# Wait for services to start and then set permissions
echo "⏳ Waiting for services to initialize..."
sleep 120

# Apply permissions after Docker Compose has created files
echo "🔒 Setting permissions for all directories in: $DATA_DIR"
chmod -R 777 "$DATA_DIR"

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "🎉 Internal services have been deployed successfully."
else
  echo "❌ Error: Failed to deploy internal services." >&2
  exit 1
fi
