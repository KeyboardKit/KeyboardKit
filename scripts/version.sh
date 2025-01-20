#!/bin/bash

# Documentation:
# This script creates a new version for the provided <TARGET> and <BRANCH>.
# This script targets iOS, macOS, tvOS, watchOS, and xrOS by default.
# You can pass in a list of <PLATFORMS> if you want to customize the build.

# Usage:
# version.sh <TARGET> <BRANCH default:main> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
# e.g. `scripts/version.sh MyTarget master iOS macOS`

# This script will:
# * Call version_validate_git.sh to validate the git repo.
# * Call version_validate_target to run tests, swiftlint, etc.
# * Call version_bump.sh if all validation steps above passed.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: This script requires at least two arguments"
    echo "Usage: $0 <TARGET> <BRANCH> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
    echo "For instance: $0 MyTarget master iOS macOS"
    exit 1
fi

# Define argument variables
TARGET=$1
BRANCH=${2:-main}

# Remove TARGET and BRANCH from arguments list
shift
shift

# Read platform arguments or use default value
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_VALIDATE_GIT="$FOLDER/version_validate_git.sh"
SCRIPT_VALIDATE_TARGET="$FOLDER/version_validate_target.sh"
SCRIPT_VERSION_BUMP="$FOLDER/version_bump.sh"

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

# Start script
echo ""
echo "Creating a new version for $TARGET on the $BRANCH branch..."
echo ""

# Validate git and project
echo "Validating..."
run_script "$SCRIPT_VALIDATE_GIT" "$BRANCH"
run_script "$SCRIPT_VALIDATE_TARGET" "$TARGET"

# Bump version
echo "Bumping version..."
run_script "$SCRIPT_VERSION_BUMP"

# Complete successfully
echo ""
echo "Version created successfully!"
echo ""
