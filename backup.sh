#!/bin/bash

# Docker and PostgreSQL settings
CONTAINER_NAME="mattermost_db_1"  # Replace with your actual container name
DB_NAME="mattermost"
DB_USER="mmuser"
DB_PASSWORD="mmuser_password"

# Backup settings
BACKUP_DIR="backups"  # Ensure this is correct and accessible
BACKUP_FILENAME="backup_$(date +%Y%m%d_%H%M%S).sql"

# Check if the backup directory exists, create if not
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Run pg_dump within the Docker container
docker exec $CONTAINER_NAME pg_dump -U $DB_USER $DB_NAME > $BACKUP_DIR/$BACKUP_FILENAME

# Remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;
