#!/bin/bash

# Documentation:
# This script version validates the Git repository for a <BRANCH>.
# The script will fail if there are uncommitted changes, or if the branch is incorrect.

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

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
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
echo "Git repository successfully validated for branch ($1)."
exit 0
