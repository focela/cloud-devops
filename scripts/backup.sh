#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Automatically export all variables
set -a

# Determine the actual script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the .env file located in the project's root directory
ENV_FILE="$SCRIPT_DIR/../.env"

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

  echo -e "$icon${color}$(date '+%Y-%m-%d %H:%M:%S') $message\e[0m"
}

# Load environment variables from .env file, or exit if not found
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
  log_message "Environment variables loaded from $ENV_FILE" info
else
  log_message "The .env file does not exist at $ENV_FILE. Exiting." error
  exit 1
fi

# Disable automatic export of variables
set +a

# Environment variables used in the script
BUCKET_NAME=$S3_BUCKET
S3_PREFIX="collab-platform-snapshots"
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# List of directories to back up in the format "source_dir:backup_prefix"
BACKUP_DIRS=(
  "/data/apps/atlassian_db:atlassian-db"
  "/data/apps/gitlab_db:gitlab-db"
  "/data/apps/gitlab_redis:redis"
  "/data/apps/proxy_db:proxy-db"
  "/data/logs:logs"
)

# Passphrase for encrypting backups
PASSPHRASE=$BACKUP_PASSPHRASE

# Function to perform backup for a single directory
backup_directory() {
  local dir=$1
  local prefix=$2

  if [ -d "$dir" ]; then
    local archive_file="/tmp/${prefix}_${CURRENT_DATE}.tar.gz"
    local encrypted_file="/tmp/${prefix}_${CURRENT_DATE}.tar.gz.gpg"

    log_message "Creating archive for $dir" info
    tar -czf "$archive_file" -C "$(dirname "$dir")" "$(basename "$dir")"
    if [ $? -ne 0 ]; then
      log_message "Error while creating archive for $dir. Skipping." error
      return 1
    fi

    log_message "Encrypting archive $archive_file" info
    echo "$PASSPHRASE" | gpg --batch --yes --passphrase-fd 0 --pinentry-mode loopback -c --output "$encrypted_file" "$archive_file"
    if [ $? -ne 0 ]; then
      log_message "Error while encrypting $archive_file. Skipping." error
      rm -f "$archive_file"
      return 1
    fi

    log_message "Uploading $encrypted_file to S3 bucket $BUCKET_NAME under $S3_PREFIX/$prefix/" info
    aws s3 cp "$encrypted_file" "s3://$BUCKET_NAME/$S3_PREFIX/$prefix/${prefix}_${CURRENT_DATE}.tar.gz.gpg"
    if [ $? -ne 0 ]; then
      log_message "Error while uploading $encrypted_file to S3. Skipping." error
      rm -f "$archive_file" "$encrypted_file"
      return 1
    fi

    # Clean up temporary files after successful upload
    rm -f "$archive_file" "$encrypted_file"
    log_message "Backup for $dir completed successfully" success
  else
    log_message "Directory $dir does not exist, skipping..." warning
  fi
}

# Start the backup process
log_message "Starting backup process" info
for item in "${BACKUP_DIRS[@]}"; do
  IFS=":" read -r dir prefix <<< "$item"
  backup_directory "$dir" "$prefix"
done

# Completion message
log_message "Backup process completed successfully" success
