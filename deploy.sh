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

# Function to set permissions for all directories in /home/data
set_permissions() {
  local dir=$1
  echo "🔒 Setting permissions for all subdirectories in: $dir"

  # Set permissions for NPM
  create_directory "$dir/npm/mysql"
  create_directory "$dir/npm/data"
  create_directory "$dir/npm/letsencrypt"

  # Set permissions for GitLab
  create_directory "$dir/gitlab/database"
  create_directory "$dir/gitlab/redis"

  # Set permissions for JIRA
  create_directory "$dir/jira/mysql"
  create_directory "$dir/jira/home_data"

  # Apply ownership and permissions
  chown -R 999:999 "$dir"
  chmod -R 777 "$dir"
}

# Create main data directory
create_directory "$DATA_DIR"

# Set permissions for all subdirectories within /home/data
set_permissions "$DATA_DIR"

echo "✅ All necessary directories have been created and permissions set."

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

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "🎉 Internal services have been deployed successfully."
else
  echo "❌ Error: Failed to deploy internal services." >&2
  exit 1
fi
