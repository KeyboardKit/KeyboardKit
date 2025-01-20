#!/bin/bash

# Documentation:
# This script syncs Swift Package Scripts from a <FOLDER>.
# This script will overwrite the existing "scripts" folder.
# Only pass in the full path to a Swift Package Scripts root.

# Usage:
# package_name.sh <FOLDER>
# e.g. `bash sync_from.sh ../SwiftPackageScripts`

# Define argument variables
SOURCE=$1

# Define variables
FOLDER="scripts/"
SOURCE_FOLDER="$SOURCE/$FOLDER"

# Start script
echo ""
echo "Syncing scripts from $SOURCE_FOLDER..."
echo ""

# Remove existing folder
rm -rf $FOLDER

# Copy folder
cp -r "$SOURCE_FOLDER/" "$FOLDER/" 

# Complete successfully
echo ""
echo "Script syncing from $SOURCE_FOLDER completed successfully!"
echo ""
