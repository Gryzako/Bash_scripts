#!/bin/bash

# Define backup directory and timestamp
BACKUP_DIR="/backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Create a temporary working directory
TMP_DIR=$(mktemp -d)

echo "Starting backup at $TIMESTAMP..."

# Loop through each user in /home/ and copy their public_html to the temp directory
for user in /home/*; do
    if [ -d "$user/public_html" ]; then  # Ensure public_html exists
        username=$(basename "$user")  # Extract username
        mkdir -p "$TMP_DIR/$username"  # Create user directory in temp location
        cp -r "$user/public_html" "$TMP_DIR/$username/"  # Copy their public_html
    fi
done

# Compress the backup into a tar.gz file
tar -czf "$BACKUP_FILE" -C "$TMP_DIR" .

# Remove the temporary directory
rm -rf "$TMP_DIR"

echo "Backup completed successfully: $BACKUP_FILE"
