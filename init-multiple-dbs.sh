#!/bin/bash
set -e

if [ -n "$MULTIPLE_DATABASES" ]; then
    echo "Multiple database creation requested: $MULTIPLE_DATABASES"
    for db in $(echo $MULTIPLE_DATABASES | tr ',' ' '); do
        echo "Creating database '$db'"
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
            CREATE DATABASE $db;
EOSQL
    done
    echo "Multiple databases created"
fi
