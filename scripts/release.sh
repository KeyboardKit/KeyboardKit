#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script creates a new release for the provided <TARGET> and <BRANCH>."

    echo
    echo "Usage: $0 [TARGET] [BRANCH] [-p|--platforms <PLATFORM1> <PLATFORM2> ...]"
    echo "  [TARGET]              Optional. The target to release (defaults to package name)"
    echo "  [BRANCH]              Optional. The branch to validate (auto-detects main/master if not specified)"
    echo "  -p, --platforms       Optional. List of platforms (default: iOS macOS tvOS watchOS xrOS)"
    
    echo
    echo "This script will:"
    echo "  * Call validate_release.sh to run tests, swiftlint, git validation, etc."
    echo "  * Call version_bump.sh if all validation steps above passed"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 MyTarget"
    echo "  $0 MyTarget master"
    echo "  $0 -p iOS macOS"
    echo "  $0 MyTarget master -p iOS macOS"
    echo "  $0 MyTarget master --platforms iOS macOS tvOS watchOS xrOS"
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
BRANCH=""
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
                show_usage_error_and_exit "--platforms requires at least one platform"
            fi
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_usage_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            elif [ -z "$BRANCH" ]; then
                BRANCH="$1"
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
            read -p "Failed to get package name. Please enter the target to release: " TARGET
            if [ -z "$TARGET" ]; then
                show_usage_error_and_exit "TARGET is required"
            fi
        fi
    else
        echo ""
        read -p "Please enter the target to release: " TARGET
        if [ -z "$TARGET" ]; then
            show_usage_error_and_exit "TARGET is required"
        fi
    fi
fi

# Set default branch if none provided
if [ -z "$BRANCH" ]; then
    # Check if main or master branch exists and set default accordingly
    if git show-ref --verify --quiet refs/heads/main; then
        BRANCH="main"
    elif git show-ref --verify --quiet refs/heads/master; then
        BRANCH="master"
    else
        BRANCH="main"  # Default to main if neither exists
    fi
fi

# Use the script folder to refer to other scripts
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_VALIDATE="$FOLDER/validate_release.sh"
SCRIPT_VERSION_BUMP="$FOLDER/version_bump.sh"

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
echo "Creating a new release for $TARGET on the $BRANCH branch with platforms [$PLATFORMS]..."

# Validate git and project
echo "Validating project..."
run_script "$SCRIPT_VALIDATE" "$TARGET" -p $PLATFORMS

# Bump version
echo "Bumping version..."
run_script "$SCRIPT_VERSION_BUMP"

# Complete successfully
echo
echo "Release created successfully!"
echo
