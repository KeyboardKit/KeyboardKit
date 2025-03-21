#!/bin/bash

# Documentation:
# This script validates the Git repository for release.
# You can pass in a <BRANCH> to validate any non-main branch.

# Usage:
# version_validate_git.sh <BRANCH default:main>"
# e.g. `bash scripts/version_validate_git.sh master`

# This script will:
# * Validate that the script is run within a git repository.
# * Validate that the git repository doesn't have any uncommitted changes.
# * Validate that the current git branch matches the provided one.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires exactly one argument"
    echo "Usage: $0 <BRANCH>"
    exit 1
fi

# Create local argument variables.
BRANCH=$1

# Start script
echo ""
echo "Validating git repository..."
echo ""

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository"
    exit 1
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: Git repository is dirty. There are uncommitted changes."
    exit 1
fi

# Verify that we're on the correct branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "$BRANCH" ]; then
    echo "Error: Not on the specified branch. Current branch is $current_branch, expected $1."
    exit 1
fi

# The Git repository validation succeeded.
echo ""
echo "Git repository validated successfully!"
echo ""
