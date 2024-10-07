#!/bin/bash

# Documentation:
# This script tests a <TARGET> for all supported platforms.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires exactly one argument"
    echo "Usage: $0 <TARGET>"
    exit 1
fi

# Create local argument variables.
TARGET=$1

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT="$FOLDER/test_platform.sh"

# Make the script executable
chmod +x $SCRIPT

# A function that tests a specific platform
test_platform() {
    local platform=$1
    echo "Testing for $platform..."
    if ! bash $SCRIPT $TARGET $platform; then
        echo "Failed to test $platform"
        return 1
    fi
    echo "Successfully tested $platform"
}

# Array of platforms to test
platforms=("platform=iOS_Simulator,name=iPhone_16")

# Loop through platforms and build
for platform in "${platforms[@]}"; do
    if ! test_platform "$platform"; then
        exit 1
    fi
done

echo "All platforms tested successfully!"
