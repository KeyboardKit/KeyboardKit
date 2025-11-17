#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script validates a <TARGET> for release by checking the git repo, then running lint and unit tests for all platforms."

    echo
    echo "Usage: $0 [TARGET] [-p|--platforms <PLATFORM1> <PLATFORM2> ...]"
    echo "  [TARGET]              Optional. The target to validate (defaults to package name)"
    echo "  -p, --platforms       Optional. List of platforms (default: iOS macOS tvOS watchOS xrOS)"
    echo "  --swiftlint           Optional. Run SwiftLint (1) or skip it (0) (default: 1)"

    echo
    echo "This script will:"
    echo "  * Validate that swiftlint passes"
    echo "  * Validate that all unit tests pass for all platforms"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 MyTarget"
    echo "  $0 -p iOS macOS"
    echo "  $0 MyTarget -p iOS macOS --swiftlint 0"
    echo "  $0 MyTarget --platforms iOS macOS tvOS watchOS xrOS"
    echo
}

# Function to display error message, show usage, and exit
show_usage_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    show_usage
    exit 1
}

# Function to display error message, and exit
show_error_and_exit() {
    echo
    local error_message="$1"
    echo "Error: $error_message"
    echo
    exit 1
}

# Define argument variables
TARGET=""
PLATFORMS="iOS macOS tvOS watchOS xrOS"  # Default platforms
SWIFTLINT=1  # Default to running SwiftLint

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
                show_usage_error_and_exit "--platforms requires at least one platform"
            fi
            ;;
        --swiftlint)
            shift
            if [[ "$1" != "0" && "$1" != "1" ]]; then
                show_usage_error_and_exit "--swiftlint requires 0 or 1"
            fi
            SWIFTLINT="$1"
            shift
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_usage_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            else
                show_usage_error_and_exit "Unexpected argument '$1'"
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
            read -p "Failed to get package name. Please enter the target to validate: " TARGET
            if [ -z "$TARGET" ]; then
                show_usage_error_and_exit "TARGET is required"
            fi
        fi
    else
        echo ""
        read -p "Please enter the target to validate: " TARGET
        if [ -z "$TARGET" ]; then
            show_usage_error_and_exit "TARGET is required"
        fi
    fi
fi

# Use the script folder to refer to other scripts
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_VALIDATE_GIT="$FOLDER/validate_git_branch.sh"
SCRIPT_TEST="$FOLDER/test.sh"

# A function that runs a certain script and checks for errors
run_script() {
    local script="$1"
    shift  # Remove the first argument (script path) from the argument list

    if [ ! -f "$script" ]; then
        show_error_and_exit "Script not found: $script"
    fi

    chmod +x "$script"
    if ! "$script" "$@"; then
        exit 1
    fi
}

# Start script
echo
echo "Validating project for target '$TARGET' with platforms [$PLATFORMS]..."

# Run SwiftLint
if [ "$SWIFTLINT" = "1" ]; then
    echo "Running SwiftLint..."
    if ! swiftlint --strict; then
        show_error_and_exit "SwiftLint failed"
    fi
    echo "SwiftLint passed"
else
    echo "Skipping SwiftLint (disabled)"
fi

# Validate git
echo "Validating git..."
run_script "$SCRIPT_VALIDATE_GIT"

# Run unit tests
echo "Running unit tests..."
run_script $SCRIPT_TEST $TARGET -p $PLATFORMS

# Complete successfully
echo
echo "Project successfully validated!"
echo
