#!/bin/bash

# Documentation:
# This script tests a <TARGET> for all provided <PLATFORMS>.

# Usage:
# test.sh <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]
# e.g. `bash scripts/test.sh MyTarget iOS macOS`

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

# Start script
echo ""
echo "Testing $TARGET for [$PLATFORMS]..."
echo ""

# A function that tests $TARGET for a specific platform
test_platform() {

    # Define a local $PLATFORM variable
    local PLATFORM="${1//_/ }"

    # Define the destination, based on the $PLATFORM
    case $PLATFORM in
        "iOS")
            DESTINATION="platform=iOS Simulator,name=iPhone 16"
            ;;
        "macOS")
            DESTINATION="platform=macOS"
            ;;
        "tvOS")
            DESTINATION="platform=tvOS Simulator,name=Apple TV"
            ;;
        "watchOS")
            DESTINATION="platform=watchOS Simulator,name=Apple Watch"
            ;;
        "xrOS")
            DESTINATION="platform=xrOS Simulator,name=Apple Vision Pro"
            ;;
        *)
            echo "Error: Unsupported platform '$PLATFORM'"
            exit 1
            ;;
    esac

    # Test $TARGET for the $DESTINATION
    echo "Testing $TARGET for $PLATFORM..."
    xcodebuild test -scheme $TARGET -derivedDataPath .build -destination "$DESTINATION" -enableCodeCoverage YES;

    # Complete successfully
    echo "Successfully tested $TARGET for $PLATFORM"
}

# Loop through all platforms and call the test function
for PLATFORM in $PLATFORMS; do
    if ! test_platform "$PLATFORM"; then
        exit 1
    fi
done

# Complete successfully
echo ""
echo "Testing $TARGET completed successfully!"
echo ""