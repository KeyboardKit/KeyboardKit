#!/bin/bash

# Documentation:
# This script builds DocC documentation for `Package.swift`.
# This script targets iOS by default, but you can pass in custom <PLATFORMS>.

# Usage:
# package_docc.sh [<PLATFORMS> default:iOS]
# e.g. `bash scripts/package_docc.sh iOS macOS`

# Exit immediately if a command exits with non-zero status
set -e

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_PACKAGE_NAME="$FOLDER/package_name.sh"
SCRIPT_DOCC="$FOLDER/docc.sh"

# Define platforms variable
if [ $# -eq 0 ]; then
    set -- iOS
fi
PLATFORMS=$@

# Get package name
PACKAGE_NAME=$("$SCRIPT_PACKAGE_NAME") || { echo "Failed to get package name"; exit 1; }

# Build package documentation
bash $SCRIPT_DOCC $PACKAGE_NAME $PLATFORMS || { echo "DocC script failed"; exit 1; }
