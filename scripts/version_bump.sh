#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script bumps the current version number and pushes a new tag."

    echo
    echo "Usage: $0 [OPTIONS]"
    echo "  -t, --type TYPE      Bump type: patch, minor, or major"
    echo "  -v, --version VER    Set explicit version number"
    echo "  --no-semver          Disable semantic version validation"
    echo "  -h, --help           Show this help message"

    echo
    echo "Examples:"
    echo "  $0 -t patch"
    echo "  $0 --type minor"
    echo "  $0 --type major"
    echo "  $0 -v 2.5.1"
    echo "  $0 --version 3.0.0"
    echo "  $0                   (prompts for version)"
    echo "  $0 --no-semver"
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

# Function to parse version components
parse_version() {
    local version=$1
    # Remove 'v' prefix if present
    version=${version#v}

    IFS='.' read -r -a parts <<< "$version"
    MAJOR="${parts[0]}"
    MINOR="${parts[1]}"
    PATCH="${parts[2]}"
}

# Function to bump version
bump_version() {
    local bump_type=$1
    local current_version=$2

    parse_version "$current_version"

    case $bump_type in
        patch)
            PATCH=$((PATCH + 1))
            echo "$MAJOR.$MINOR.$PATCH"
            ;;
        minor)
            MINOR=$((MINOR + 1))
            echo "$MAJOR.$MINOR.0"
            ;;
        major)
            MAJOR=$((MAJOR + 1))
            echo "$MAJOR.0.0"
            ;;
        *)
            show_error_and_exit "Invalid bump type: $bump_type. Use patch, minor, or major."
            ;;
    esac
}

# Define argument variables
VALIDATE_SEMVER=true
BUMP_TYPE=""
EXPLICIT_VERSION=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--type)
            BUMP_TYPE="$2"
            shift 2
            ;;
        -v|--version)
            EXPLICIT_VERSION="$2"
            shift 2
            ;;
        --no-semver)
            VALIDATE_SEMVER=false
            shift
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            show_error_and_exit "Unexpected argument '$1'" ;;
    esac
done

# Check for conflicting options
if [ -n "$BUMP_TYPE" ] && [ -n "$EXPLICIT_VERSION" ]; then
    show_error_and_exit "Cannot specify both --type and --version"
fi

# Use the script folder to refer to other scripts
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_VERSION_NUMBER="$FOLDER/version_number.sh"

# Check if version_number.sh exists
if [ ! -f "$SCRIPT_VERSION_NUMBER" ]; then
    show_error_and_exit "version_number.sh script not found at $SCRIPT_VERSION_NUMBER"
fi

# Function to validate semver format, including optional -rc.<INT> suffix
validate_semver() {
    if [ "$VALIDATE_SEMVER" = false ]; then
        return 0
    fi

    if [[ $1 =~ ^v?[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)?$ ]]; then
        return 0
    else
        return 1
    fi
}

# Start script
echo
echo "Bumping version number..."

# Get the latest version
echo "Getting current version..."
if ! VERSION=$($SCRIPT_VERSION_NUMBER); then
    echo "Failed to get the latest version"
    exit 1
fi

# Print the current version
echo "The current version is: $VERSION"

# Determine new version
if [ -n "$EXPLICIT_VERSION" ]; then
    # Explicit version provided
    NEW_VERSION="$EXPLICIT_VERSION"
    if ! validate_semver "$NEW_VERSION"; then
        if [ "$VALIDATE_SEMVER" = true ]; then
            show_error_and_exit "Invalid version format: $NEW_VERSION. Use semver format or --no-semver to disable validation."
        fi
    fi
    echo "New version will be: $NEW_VERSION"
elif [ -n "$BUMP_TYPE" ]; then
    # Bump type provided, calculate new version
    NEW_VERSION=$(bump_version "$BUMP_TYPE" "$VERSION")
    echo "New version will be: $NEW_VERSION"
else
    # Prompt user for new version
    while true; do
        echo ""
        read -p "Enter the new version number: " NEW_VERSION

        # Validate the version number to ensure that it's a semver version
        if validate_semver "$NEW_VERSION"; then
            break
        else
            if [ "$VALIDATE_SEMVER" = true ]; then
                echo "Invalid version format. Please use semver format (e.g., 1.2.3, v1.2.3, 1.2.3-rc.1, etc.)."
                echo "Use --no-semver to disable validation."
            else
                break
            fi
        fi
    done
fi

# Push the current branch and create tag
echo "Pushing current branch..."
if ! git push -u origin HEAD; then
    echo "Failed to push current branch"
    exit 1
fi

echo "Creating and pushing tag $NEW_VERSION..."
if ! git tag $NEW_VERSION; then
    echo "Failed to create tag $NEW_VERSION"
    exit 1
fi

if ! git push --tags; then
    echo "Failed to push tags"
    exit 1
fi

# Complete successfully
echo
echo "Version tag $NEW_VERSION pushed successfully!"
echo
