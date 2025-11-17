#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script syncs Swift Package Scripts from a <SOURCE_FOLDER>."

    echo
    echo "Usage: $0 <SOURCE_FOLDER>"
    echo "  <SOURCE_FOLDER>       Required. The full path to a Swift Package Scripts root"
    
    echo
    echo "This script will overwrite the existing 'scripts' folder."
    echo "Only pass in the full path to a Swift Package Scripts root."
    
    echo
    echo "Examples:"
    echo "  $0 ../SwiftPackageScripts"
    echo "  $0 /path/to/SwiftPackageScripts"
    echo
}

# Function to display error message, show usage, and exit
show_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    show_usage
    exit 1
}

# Define argument variables
SOURCE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$SOURCE" ]; then
                SOURCE="$1"
            else
                show_error_and_exit "Unexpected argument '$1'"
            fi
            shift
            ;;
    esac
done

# Verify SOURCE was provided
if [ -z "$SOURCE" ]; then
    echo ""
    read -p "Please enter the source folder path: " SOURCE
    if [ -z "$SOURCE" ]; then
        show_error_and_exit "SOURCE_FOLDER is required"
    fi
fi

# Define variables
FOLDER="scripts/"
SOURCE_FOLDER="$SOURCE/$FOLDER"

# Verify source folder exists
if [ ! -d "$SOURCE_FOLDER" ]; then
    show_error_and_exit "Source folder '$SOURCE_FOLDER' does not exist"
fi

# Start script
echo
echo "Syncing scripts from $SOURCE_FOLDER..."

# Remove existing folder
echo "Removing existing scripts folder..."
rm -rf $FOLDER

# Copy folder
echo "Copying scripts from source..."
if ! cp -r "$SOURCE_FOLDER/" "$FOLDER/"; then
    echo "Failed to copy scripts from $SOURCE_FOLDER"
    exit 1
fi

# Complete successfully
echo
echo "Script syncing from $SOURCE_FOLDER completed successfully!"
echo