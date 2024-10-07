#!/bin/bash

# Documentation:
# This script creates a new project version for the provided <BUILD_TARGET> and <GIT_BRANCH>.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: This script requires exactly two arguments"
    echo "Usage: $0 <BUILD_TARGET> <GIT_BRANCH>"
    exit 1
fi

# Create local argument variables.
BUILD_TARGET="$1"
GIT_BRANCH="$2"

# Use the script folder to refer to the platform script.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VALIDATE_GIT="$FOLDER/version_validate_git.sh"
VALIDATE_PROJECT="$FOLDER/version_validate_project.sh"
VERSION_BUMP="$FOLDER/version_number_bump.sh"

# A function that run a certain script and checks for errors
run_script() {
    local script="$1"
    shift # Remove the first argument (the script path)

    if [ ! -f "$script" ]; then
        echo "Error: Script not found: $script"
        exit 1
    fi

    chmod +x "$script"
    if ! "$script" "$@"; then
        echo "Error: Script $script failed"
        exit 1
    fi
}


# Execute the pipeline steps
echo "Starting pipeline for BUILD_TARGET: $BUILD_TARGET, GIT_BRANCH: $GIT_BRANCH"

echo "Validating Git..."
run_script "$VALIDATE_GIT" "$GIT_BRANCH"

echo "Validating Project..."
run_script "$VALIDATE_PROJECT" "$BUILD_TARGET"

echo "Bumping version..."
run_script "$VERSION_BUMP"

echo ""
echo "Version created successfully!"
echo ""
