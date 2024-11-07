#!/bin/bash

# Documentation:
# This script builds a <TARGET> for all supported platforms.

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
SCRIPT="$FOLDER/build_platform.sh"

# Make the script executable
chmod +x $SCRIPT

# A function that builds a specific platform
build_platform() {
    local platform=$1
    echo "Building for $platform..."
    if ! bash $SCRIPT $TARGET $platform; then
        echo "Failed to build $platform"
        return 1
    fi
    echo "Successfully built $platform"
}

# Array of platforms to build
platforms=("iOS" "macOS" "tvOS" "watchOS" "xrOS")

# Loop through platforms and build
for platform in "${platforms[@]}"; do
    if ! build_platform "$platform"; then
        exit 1
    fi
done

echo "All platforms built successfully!"
