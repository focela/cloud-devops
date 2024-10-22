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

# Directory paths for mounting data
DATA_DIR_NPM="/home/data/npm"
DATA_DIR_GITLAB="/home/data/gitlab"
DATA_DIR_JIRA="/home/data/jira"

# Function to create necessary directories if they do not exist
create_directory() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    echo "📁 Creating directory: $dir"
    mkdir -p "$dir"
  fi
}

# Create directories for NPM (Nginx Proxy Manager)
create_directory "$DATA_DIR_NPM/mysql"
create_directory "$DATA_DIR_NPM/data"
create_directory "$DATA_DIR_NPM/letsencrypt"

# Create directories for GitLab
create_directory "$DATA_DIR_GITLAB/database"
create_directory "$DATA_DIR_GITLAB/redis"
create_directory "$DATA_DIR_GITLAB"

# Create directories for Jira
create_directory "$DATA_DIR_JIRA/mysql"
create_directory "$DATA_DIR_JIRA/home_data"

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

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "🎉 Internal services have been deployed successfully."
else
  echo "❌ Error: Failed to deploy internal services." >&2
  exit 1
fi
