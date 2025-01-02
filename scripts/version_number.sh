#!/bin/bash

# Documentation:
# This script returns the latest project version.

# Usage:
# version_number.sh
# e.g. `bash scripts/version_number.sh`

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository"
    exit 1
fi

# Fetch all tags
git fetch --tags > /dev/null 2>&1

# Get the latest semver tag
latest_version=$(git tag -l --sort=-v:refname | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)

# Check if we found a version tag
if [ -z "$latest_version" ]; then
    echo "Error: No semver tags found in this repository" >&2
    exit 1
fi

# Print the latest version
echo "$latest_version"
