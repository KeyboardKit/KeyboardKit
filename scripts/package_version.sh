#!/bin/bash

# Documentation:
# This script creates a new version for `Package.swift`.
# You can pass in a <BRANCH> to validate any non-main branch.

# Usage:
# package_version.sh <BRANCH default:main>
# e.g. `bash scripts/package_version.sh master`

# Exit immediately if a command exits with non-zero status
set -e

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_BRANCH_NAME="$FOLDER/git_default_branch.sh"
SCRIPT_PACKAGE_NAME="$FOLDER/package_name.sh"
SCRIPT_VERSION="$FOLDER/version.sh"

# Get branch name
DEFAULT_BRANCH=$("$SCRIPT_BRANCH_NAME") || { echo "Failed to get branch name"; exit 1; }
BRANCH_NAME=${1:-$DEFAULT_BRANCH}

# Get package name
PACKAGE_NAME=$("$SCRIPT_PACKAGE_NAME") || { echo "Failed to get package name"; exit 1; }

# Build package version
bash $SCRIPT_VERSION $PACKAGE_NAME $BRANCH_NAME
