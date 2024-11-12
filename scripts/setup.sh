#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# List of directories to create and set permissions for
DIRECTORIES=(
  "/data/apps/atlassian_db"
  "/data/apps/confluence"
  "/data/apps/crowd"
  "/data/apps/gitlab"
  "/data/apps/gitlab_db"
  "/data/apps/gitlab_redis"
  "/data/apps/jira"
  "/data/apps/proxy"
  "/data/apps/proxy_db"
  "/data/logs/confluence"
  "/data/logs/crowd"
  "/data/logs/gitlab"
  "/data/logs/jira"
  "/data/ssl"
)

# User and group for directory ownership
BACKUP_USER="ubuntu"
BACKUP_GROUP="collab_platform"

# Log directory and file
LOG_DIR="/var/log/collab_platform"
LOG_FILE="$LOG_DIR/setup.log"

# Function to log messages with icons and timestamps
log_message() {
  local message=$1
  local type=$2

  case $type in
    info) icon="ℹ️ "; color="\e[34m";;
    success) icon="✅ "; color="\e[32m";;
    warning) icon="⚠️ "; color="\e[33m";;
    error) icon="❌ "; color="\e[31m";;
    *) icon=""; color="";;
  esac

  echo -e "$icon${color}$(date '+%Y-%m-%d %H:%M:%S') $message\e[0m" | tee -a "$LOG_FILE"
}

# Function to ensure a directory exists with the correct permissions
# Arguments: $1 - directory path
create_directory() {
  local dir=$1

  if [ ! -d "$dir" ]; then
    log_message "Creating directory: $dir" info
    sudo mkdir -p "$dir" || { log_message "Unable to create directory $dir" error; return 1; }
  fi

  # Set ownership and permissions
  log_message "Setting permissions for $dir" info
  sudo chgrp -R "$BACKUP_GROUP" "$dir" || { log_message "Unable to change group for $dir" error; return 1; }
  sudo chmod -R g+rwX "$dir" || { log_message "Unable to set permissions for $dir" error; return 1; }
}

# Function to ensure the log directory and file exist
initialize_logging() {
  if [ ! -d "$LOG_DIR" ]; then
    log_message "Log directory does not exist, creating it..." info
    sudo mkdir -p "$LOG_DIR" || { log_message "Unable to create log directory $LOG_DIR" error; exit 1; }
    sudo chown "$BACKUP_USER:$BACKUP_GROUP" "$LOG_DIR"
    sudo chmod 775 "$LOG_DIR"
  fi

  if [ ! -f "$LOG_FILE" ]; then
    log_message "Log file does not exist, creating it..." info
    sudo touch "$LOG_FILE" || { log_message "Unable to create log file $LOG_FILE" error; exit 1; }
  fi
  sudo chown "$BACKUP_USER:$BACKUP_GROUP" "$LOG_FILE"
  sudo chmod 664 "$LOG_FILE"
}

# Function to ensure the group exists and the user is added to it
ensure_group_and_user() {
  if ! getent group "$BACKUP_GROUP" > /dev/null; then
    log_message "Group $BACKUP_GROUP does not exist, creating it..." info
    sudo groupadd "$BACKUP_GROUP" || { log_message "Unable to create group $BACKUP_GROUP" error; exit 1; }
  fi

  log_message "Adding user $BACKUP_USER to group $BACKUP_GROUP..." info
  sudo usermod -aG "$BACKUP_GROUP" "$BACKUP_USER" || { log_message "Unable to add user $BACKUP_USER to group $BACKUP_GROUP" error; exit 1; }
}

# Main script execution starts here
log_message "Starting directory setup process..." info

# Initialize logging system
initialize_logging

# Ensure the group and user are properly configured
ensure_group_and_user

# Iterate over the directory list and create each directory
for dir in "${DIRECTORIES[@]}"; do
  create_directory "$dir"
done

# Completion log
log_message "All directories have been successfully created and permissions set!" success
log_message "User $BACKUP_USER can now access the directories for backup." success
