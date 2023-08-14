#!/bin/bash

# Path: make_backup.sh
# Execute this script as root
# For executing run: sudo ./make_backup.sh

# make sure the script is running as root

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

DIR_ARRAY=( "/etc" "/home" "/var/www" "/var/lib/mysql" )
BACKUP_DIR="/home/backup"

# create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p $BACKUP_DIR
fi

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR doesn't exist and couldn't be created."
    exit 1
fi

# create backup file
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# create tar.gz archive
tar -cpzf $BACKUP_FILE ${DIR_ARRAY[*]}

