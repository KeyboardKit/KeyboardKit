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

# A function that gets the latest simulator for a certain OS.
get_latest_simulator() {
    local PLATFORM=$1
    local SIMULATOR_TYPE
    
    case $PLATFORM in
        "iOS")
            SIMULATOR_TYPE="iPhone"
            ;;
        "tvOS")
            SIMULATOR_TYPE="Apple TV"
            ;;
        "watchOS")
            SIMULATOR_TYPE="Apple Watch"
            ;;
        "xrOS")
            SIMULATOR_TYPE="Apple Vision"
            ;;
        *)
            echo "Error: Unsupported platform for simulator '$PLATFORM'"
            return 1
            ;;
    esac
    
    # Get the latest simulator for the platform
    xcrun simctl list devices available | grep "$SIMULATOR_TYPE" | tail -1 | sed -E 's/.*\(([A-F0-9-]+)\).*/\1/'
}

# A function that tests $TARGET for a specific platform
test_platform() {

    # Define a local $PLATFORM variable
    local PLATFORM="${1//_/ }"
    
    # Define the destination, based on the $PLATFORM
    case $PLATFORM in
        "iOS"|"tvOS"|"watchOS"|"xrOS")
            local SIMULATOR_UDID=$(get_latest_simulator "$PLATFORM")
            if [ -z "$SIMULATOR_UDID" ]; then
                echo "Error: No simulator found for $PLATFORM"
                return 1
            fi
            DESTINATION="id=$SIMULATOR_UDID"
            ;;
        "macOS")
            DESTINATION="platform=macOS"
            ;;
        *)
            echo "Error: Unsupported platform '$PLATFORM'"
            return 1
            ;;
    esac

    # Test $TARGET for the $DESTINATION
    echo "Testing $TARGET for $PLATFORM..."
    xcodebuild test -scheme $TARGET -derivedDataPath .build -destination "$DESTINATION" -enableCodeCoverage YES
    local TEST_RESULT=$?
    
    if [[ $TEST_RESULT -ne 0 ]]; then
        return $TEST_RESULT
    fi

    # Complete successfully
    echo "Successfully tested $TARGET for $PLATFORM"
    return 0
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
