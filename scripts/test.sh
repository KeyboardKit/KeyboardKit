#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script tests a <TARGET> for all provided <PLATFORMS>."

    echo
    echo "Usage: $0 [TARGET] [-p|--platforms <PLATFORM1> <PLATFORM2> ...]"
    echo "  [TARGET]              Optional. The target to test (defaults to package name)"
    echo "  -p, --platforms       Optional. List of platforms (default: iOS macOS tvOS watchOS xrOS)"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 MyTarget"
    echo "  $0 -p iOS macOS"
    echo "  $0 MyTarget -p iOS macOS"
    echo "  $0 MyTarget --platforms iOS macOS tvOS watchOS xrOS"
    echo
}

# Function to display error message, show usage, and exit
show_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    show_usage
    exit 1
}

# Define argument variables
TARGET=""
PLATFORMS="iOS macOS tvOS watchOS xrOS"  # Default platforms

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--platforms)
            shift  # Remove --platforms from arguments
            PLATFORMS=""  # Clear default platforms
            
            # Collect all platform arguments until we hit another flag or run out of args
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                PLATFORMS="$PLATFORMS $1"
                shift
            done
            
            # Remove leading space and check if we got any platforms
            PLATFORMS=$(echo "$PLATFORMS" | sed 's/^ *//')
            if [ -z "$PLATFORMS" ]; then
                show_error_and_exit "--platforms requires at least one platform"
            fi
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            else
                show_error_and_exit "Unexpected argument '$1'"
            fi
            shift
            ;;
    esac
done

# If no TARGET was provided, try to get package name
if [ -z "$TARGET" ]; then
    # Use the script folder to refer to other scripts
    FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    SCRIPT_PACKAGE_NAME="$FOLDER/package_name.sh"
    
    # Check if package_name.sh exists
    if [ -f "$SCRIPT_PACKAGE_NAME" ]; then
        echo "No target provided, attempting to get package name..."
        if TARGET=$("$SCRIPT_PACKAGE_NAME"); then
            echo "Using package name: $TARGET"
        else
            echo ""
            read -p "Failed to get package name. Please enter the target to test: " TARGET
            if [ -z "$TARGET" ]; then
                show_error_and_exit "TARGET is required"
            fi
        fi
    else
        echo ""
        read -p "Please enter the target to test: " TARGET
        if [ -z "$TARGET" ]; then
            show_error_and_exit "TARGET is required"
        fi
    fi
fi

# A function that gets the latest simulator for a certain OS
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
    if ! xcodebuild test -scheme $TARGET -derivedDataPath .build -destination "$DESTINATION" -enableCodeCoverage YES; then
        echo "Failed to test $TARGET for $PLATFORM"
        return 1
    fi

    # Complete successfully
    echo "Successfully tested $TARGET for $PLATFORM"
}

# Start script
echo
echo "Testing $TARGET for [$PLATFORMS]..."

# Loop through all platforms and call the test function
for PLATFORM in $PLATFORMS; do
    if ! test_platform "$PLATFORM"; then
        exit 1
    fi
done

# Complete successfully
echo
echo "Testing $TARGET completed successfully!"
echo