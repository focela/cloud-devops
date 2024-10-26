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

# Function to create user and group if they don't exist
create_user_and_group() {
  local user=$1
  local group=$2
  if ! id -u "$user" &>/dev/null; then
    echo "👤 Creating user: $user and group: $group"
    sudo groupadd "$group"
    sudo useradd -g "$group" "$user"
  fi
}

# Ensure jira and git users and groups exist
create_user_and_group "jira" "jira"
create_user_and_group "git" "git"

# Create main data directory and subdirectories for services
create_directory "$DATA_DIR/npm/mysql"
create_directory "$DATA_DIR/npm/data"
create_directory "$DATA_DIR/npm/letsencrypt"
create_directory "$DATA_DIR/gitlab/database"
create_directory "$DATA_DIR/gitlab/redis"
create_directory "$DATA_DIR/jira/mysql"
create_directory "$DATA_DIR/jira/data"

echo "✅ All necessary directories have been created."

# Set ownership and permissions for Jira and GitLab directories
chown -R jira:jira "$DATA_DIR/jira"
chown -R git:git "$DATA_DIR/gitlab"
chmod -R 775 "$DATA_DIR/jira" "$DATA_DIR/gitlab"  # Set permissions to 775 for Jira and GitLab directories

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
