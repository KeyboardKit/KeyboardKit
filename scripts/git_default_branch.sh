#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script outputs the default git branch name."

    echo
    echo "Usage: $0 [OPTIONS]"
    echo "  -h, --help           Show this help message"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  bash scripts/git_default_branch.sh"
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

# Get the default git branch name
if ! BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'); then
    echo "Failed to get default git branch"
    exit 1
fi

# Output the branch name
echo $BRANCH