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
PASSPHRASE=$BACKUP_PASSPHRASE

# List of directories to restore in the format "source_dir:backup_prefix"
RESTORE_DIRS=(
  "/data/apps/atlassian_db:atlassian-db"
  "/data/apps/gitlab_db:gitlab-db"
  "/data/apps/gitlab_redis:redis"
  "/data/apps/proxy_db:proxy-db"
  "/data/logs:logs"
)

# Function to restore a single directory
restore_directory() {
  local dir=$1
  local prefix=$2

  # Find the latest backup file in the S3 bucket
  log_message "Finding the latest backup file for $prefix in S3..." info
  latest_file=$(aws s3 ls "s3://$BUCKET_NAME/$S3_PREFIX/$prefix/" | sort | tail -n 1 | awk '{print $4}')
  if [ -z "$latest_file" ]; then
    log_message "No backup found for $prefix in S3. Skipping." warning
    return 1
  fi

  log_message "Latest backup file for $prefix: $latest_file" info

  # Download the latest backup file from S3
  encrypted_file="/tmp/$latest_file"
  decrypted_file="${encrypted_file%.gpg}"  # Remove .gpg extension for the decrypted file

  log_message "Downloading $latest_file from S3 to $encrypted_file..." info
  aws s3 cp "s3://$BUCKET_NAME/$S3_PREFIX/$prefix/$latest_file" "$encrypted_file"
  if [ $? -ne 0 ]; then
    log_message "Failed to download $latest_file from S3. Skipping." error
    return 1
  fi

  # Decrypt the file
  log_message "Decrypting $encrypted_file..." info
  echo "$PASSPHRASE" | gpg --batch --yes --passphrase-fd 0 --pinentry-mode loopback -o "$decrypted_file" -d "$encrypted_file"
  if [ $? -ne 0 ]; then
    log_message "Failed to decrypt $encrypted_file. Skipping." error
    rm -f "$encrypted_file"
    return 1
  fi

  # Extract the tar.gz file to the target directory (overwrite existing files)
  log_message "Restoring $decrypted_file into $dir..." info
  tar -xzf "$decrypted_file" -C "$(dirname "$dir")"
  if [ $? -ne 0 ]; then
    log_message "Failed to extract $decrypted_file. Skipping." error
    rm -f "$encrypted_file" "$decrypted_file"
    return 1
  fi

  # Clean up temporary files
  rm -f "$encrypted_file" "$decrypted_file"
  log_message "Restore for $prefix completed successfully" success
}

# Start the restore process
log_message "Starting restore process" info
for item in "${RESTORE_DIRS[@]}"; do
  IFS=":" read -r dir prefix <<< "$item"
  restore_directory "$dir" "$prefix"
done

# Completion message
log_message "Restore process completed successfully" success
