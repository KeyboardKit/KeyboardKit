#!/bin/bash

# Documentation:
# This script bumps the project version number.

# Exit immediately if a command exits with a non-zero status
set -e

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT="$FOLDER/version_number.sh"

# Get the latest version
VERSION=$($SCRIPT)

if [ $? -ne 0 ]; then
    echo "Failed to get the latest version"
    exit 1
fi

# Print the current version
echo "The current version is: $VERSION"

# Function to validate semver format, including optional -rc.<INT> suffix
validate_semver() {
    if [[ $1 =~ ^v?[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)?$ ]]; then
        return 0
    else
        return 1
    fi
}

# Prompt user for new version
while true; do
    read -p "Enter the new version number: " NEW_VERSION

    if validate_semver "$NEW_VERSION"; then
        break
    else
        echo "Invalid version format. Please use semver format (e.g., 1.2.3, v1.2.3, 1.2.3-rc.1, etc.)."
        exit 1
    fi
done

git push -u origin HEAD
git tag $NEW_VERSION
git push --tags