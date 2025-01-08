#!/bin/bash

# Documentation:
# This script makes all scripts in this folder executable.

# Usage:
# scripts_chmod.sh
# e.g. `bash scripts/chmod.sh`

# Exit immediately if a command exits with a non-zero status
set -e

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Find all .sh files in the FOLDER except chmod.sh
find "$FOLDER" -name "*.sh" ! -name "chmod.sh" -type f | while read -r script; do
    chmod +x "$script"
done
