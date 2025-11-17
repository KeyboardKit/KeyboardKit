#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script returns the latest project version."

    echo
    echo "Usage: $0 [OPTIONS]"
    echo "  -h, --help           Show this help message"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  bash scripts/version_number.sh"
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
    shift
done

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    show_error_and_exit "Not a Git repository"
fi

# Fetch all tags
if ! git fetch --tags > /dev/null 2>&1; then
    show_error_and_exit "Failed to fetch tags from remote"
fi

# Get the latest semver tag
if ! latest_version=$(git tag -l --sort=-v:refname | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1); then
    show_error_and_exit "Failed to retrieve version tags"
fi

# Check if we found a version tag
if [ -z "$latest_version" ]; then
    show_error_and_exit "No semver tags found in this repository"
fi

# Print the latest version
echo "$latest_version"