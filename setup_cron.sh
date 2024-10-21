#!/bin/bash

# Cron schedule: e.g., "0 2 * * *" for 2 AM every day
CRON_SCHEDULE="$1"

# Full path to the backup script
BACKUP_SCRIPT="backup.sh"

# Check if the cron schedule argument is provided
if [ -z "$CRON_SCHEDULE" ]; then
    echo "Usage: setup_cron.sh '<cron_schedule>'"
    echo "Example: setup_cron.sh '0 2 * * *'"
    exit 1
fi

# Add or update the cron job
(crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $BACKUP_SCRIPT") | crontab -

# Confirm the cron job is set
echo "Cron job set: $CRON_SCHEDULE $BACKUP_SCRIPT"
crontab -l
