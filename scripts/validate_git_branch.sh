#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script validates the Git repository for release."

    echo
    echo "Usage: $0 [BRANCH] [-b|--branch <BRANCH>]"
    echo "  [BRANCH]              Optional. The branch to validate (auto-detects main/master if not specified)"
    echo "  -b, --branch          Optional. The branch to validate"
    
    echo
    echo "This script will:"
    echo "  * Validate that the script is run within a git repository"
    echo "  * Validate that the git repository doesn't have any uncommitted changes"
    echo "  * Validate that the current git branch matches the specified one"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 master"
    echo "  $0 develop"
    echo "  $0 -b main"
    echo "  $0 --branch develop"
    echo
}

# Function to display error message, show usage, and exit
show_usage_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    show_usage
    exit 1
}

# Function to display error message, and exit
show_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    echo
    exit 1
}

# Define argument variables
BRANCH=""  # Will be set to default after parsing

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--branch)
            shift  # Remove --branch from arguments
            if [[ $# -eq 0 || "$1" =~ ^- ]]; then
                show_usage_error_and_exit "--branch requires a branch name"
            fi
            BRANCH="$1"
            shift
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_usage_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$BRANCH" ]; then
                BRANCH="$1"
            else
                show_usage_error_and_exit "Unexpected argument '$1'"
            fi
            shift
            ;;
    esac
done

# Set default branch if none provided
if [ -z "$BRANCH" ]; then
    # Check if main or master branch exists and set default accordingly
    if git show-ref --verify --quiet refs/heads/main; then
        BRANCH="main"
    elif git show-ref --verify --quiet refs/heads/master; then
        BRANCH="master"
    else
        BRANCH="main"  # Default to main if neither exists
    fi
fi

# Start script
echo
echo "Validating git repository for branch '$BRANCH'..."

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    show_error_and_exit "Not a Git repository"
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    show_error_and_exit "Git repository is dirty. There are uncommitted changes"
fi

# Verify that we're on the correct branch
if ! current_branch=$(git rev-parse --abbrev-ref HEAD); then
    show_error_and_exit "Failed to get current branch name"
fi

if [ "$current_branch" != "$BRANCH" ]; then
    show_error_and_exit "Not on the specified branch. Current branch is '$current_branch', expected '$BRANCH'"
fi

# Complete successfully
echo
echo "Git repository validated successfully!"
echo
