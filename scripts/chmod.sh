#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script makes all .sh files in the current directory executable."

    echo
    echo "Usage: $0 [OPTIONS]"
    echo "  -h, --help           Show this help message"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  bash scripts/chmod.sh"
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

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            show_error_and_exit "Unexpected argument '$1'" ;;
    esac
done

# Use the script folder to refer to other scripts
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Function to make scripts executable
make_executable() {
    local script="$1"
    local filename=$(basename "$script")
    
    echo "Making $filename executable..."
    if ! chmod +x "$script"; then
        echo "Failed to make $filename executable" ; return 1
    fi
    
    echo "Successfully made $filename executable"
}

# Start script
echo
echo "Making all .sh files in $(basename "$FOLDER") executable..."

# Find all .sh files in the FOLDER except chmod.sh and make them executable
SCRIPT_COUNT=0
while read -r script; do
    if ! make_executable "$script"; then
        exit 1
    fi
    ((SCRIPT_COUNT++))
done < <(find "$FOLDER" -name "*.sh" ! -name "chmod.sh" -type f)

# Complete successfully
if [ $SCRIPT_COUNT -eq 0 ]; then
    echo
    echo "No .sh files found to make executable (excluding chmod.sh)"
else
    echo
    echo "Successfully made $SCRIPT_COUNT script(s) executable!"
fi

echo