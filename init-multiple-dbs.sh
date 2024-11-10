#!/bin/bash
set -e

# Parse the comma-separated database list into an array
IFS=',' read -r -a database_list <<< "$POSTGRES_MULTIPLE_DATABASES"

# Log the parsed database names for debugging
echo "Databases to create: ${database_list[*]}"

# Loop through each database and create it
for database_name in "${database_list[@]}"; do
  echo "Creating database: $database_name"
  if psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<EOSQL
    CREATE DATABASE "$database_name";
EOSQL
  then
    echo "Successfully created database: $database_name"
  else
    echo "Failed to create database: $database_name"
  fi
done

echo "All databases have been created successfully."
