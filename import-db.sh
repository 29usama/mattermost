#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_sql_file> <database_name>"
    exit 1
fi

SQL_FILE=$1
DB_NAME=$2

# Check if the SQL file exists
if [ ! -f "$SQL_FILE" ]; then
    echo "SQL file not found: $SQL_FILE"
    exit 1
fi

# PostgreSQL username
PG_USER="singhera"

# Create a new PostgreSQL database owned by 'singhera'
echo "Creating database '$DB_NAME' owned by '$PG_USER'..."
createdb -O $PG_USER $DB_NAME

# Import the SQL file into the new database
echo "Importing $SQL_FILE into $DB_NAME..."
psql -d $DB_NAME -U $PG_USER -f $SQL_FILE

echo "Import completed successfully."
