#!/bin/bash

# Documentation:
# This script builds a <TARGET> for all provided <PLATFORMS>.

# Usage:
# build.sh <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]
# e.g. `bash scripts/build.sh MyTarget iOS macOS`

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires at least one argument"
    echo "Usage: $0 <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
    echo "For instance: $0 MyTarget iOS macOS"
    exit 1
fi

# Define argument variables
TARGET=$1

# Remove TARGET from arguments list
shift

# Define platforms variable
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi
PLATFORMS=$@

# A function that builds $TARGET for a specific platform
build_platform() {

    # Define a local $PLATFORM variable
    local PLATFORM=$1

    # Build $TARGET for the $PLATFORM
    echo "Building $TARGET for $PLATFORM..."
    if ! xcodebuild -scheme $TARGET -derivedDataPath .build -destination generic/platform=$PLATFORM; then
        echo "Failed to build $TARGET for $PLATFORM"
        return 1
    fi

    # Complete successfully
    echo "Successfully built $TARGET for $PLATFORM"
}

# Start script
echo ""
echo "Building $TARGET for [$PLATFORMS]..."
echo ""

# Loop through all platforms and call the build function
for PLATFORM in $PLATFORMS; do
    if ! build_platform "$PLATFORM"; then
        exit 1
    fi
done

# Complete successfully
echo ""
echo "Building $TARGET completed successfully!"
echo ""