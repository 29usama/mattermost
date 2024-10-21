#!/bin/bash

# Directory where the media files are stored
MEDIA_DIR="/root/docker-projects/mattermost/volumes/app/mattermost/data"

# Directory to exclude from the search
EXCLUDE_DIR="${MEDIA_DIR}/users"

# Number of days after which files should be considered old and deleted
DAYS_OLD=30

# Safety check to prevent accidental deletion from the wrong directory
if [ -z "$MEDIA_DIR" ] || [ "$MEDIA_DIR" = "/" ]; then
    echo "Invalid MEDIA_DIR. Please check the script."
    exit 1
fi

# Deleting .mp4 and .jpg files older than DAYS_OLD, only in the specified directory (not in subdirectories)
# and excluding the users directory
find "$MEDIA_DIR" -maxdepth 1 -type f -not -path "$EXCLUDE_DIR/*" \( -name "*.mp4" -o -name "*.jpg" \) -mtime +$DAYS_OLD -exec rm {} \;

echo "Deletion complete."