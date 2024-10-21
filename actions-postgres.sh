#!/bin/bash

PG_USER="singhera"  # PostgreSQL username

# Function to create a new database
create_database() {
    read -p "Enter new database name: " new_db
    echo "Creating database '$new_db'..."
    PGPASSWORD=$PGPASSWORD createdb -U $PG_USER $new_db
    echo "Database '$new_db' created successfully."
}

# Function to list all databases
list_databases() {
    echo "Listing all databases..."
    PGPASSWORD=$PGPASSWORD psql -U $PG_USER -l
}

# Function to truncate all tables in a PostgreSQL database
empty_tables() {
    read -p "Enter database name to empty its tables: " db_name
    echo "Emptying all tables in database '$db_name'..."
    SQL="SELECT 'TRUNCATE TABLE ' || tablename || ' CASCADE;' FROM pg_tables WHERE schemaname = 'public';"
    PGPASSWORD=$PGPASSWORD psql -d $db_name -U $PG_USER -c "$SQL" | grep TRUNCATE | PGPASSWORD=$PGPASSWORD psql -d $db_name -U $PG_USER
    echo "All tables in '$db_name' have been emptied."
}

# Function to delete a database
delete_database() {
    read -p "Enter database name to delete: " del_db
    echo "Deleting database '$del_db'..."
    PGPASSWORD=$PGPASSWORD dropdb -U $PG_USER $del_db
    echo "Database '$del_db' deleted successfully."
}

# Prompt for PostgreSQL password
read -sp "Enter password for $PG_USER: " PGPASSWORD
echo

# Menu for selecting the operation
echo "Select an operation:"
echo "1. Create a new database"
echo "2. List all databases"
echo "3. Empty all tables in a database"
echo "4. Delete a database"
read -p "Enter your choice (1/2/3/4): " choice

case $choice in
    1) create_database ;;
    2) list_databases ;;
    3) empty_tables ;;
    4) delete_database ;;
    *) echo "Invalid choice"; exit 1 ;;
esac
