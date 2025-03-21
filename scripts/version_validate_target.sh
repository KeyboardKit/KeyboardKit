#!/bin/bash

# Documentation:
# This script validates a <TARGET> for release.
# This script targets iOS, macOS, tvOS, watchOS, and xrOS by default.
# You can pass in a list of <PLATFORMS> if you want to customize the build.

# Usage:
# version_validate_target.sh <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
# e.g. `bash scripts/version_validate_target.sh iOS macOS`

# This script will:
# * Validate that swiftlint passes.
# * Validate that all unit tests passes for all <PLATFORMS>.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all requires at least one argument"
if [ $# -eq 0 ]; then
    echo "Error: This script requires at least one argument"
    echo "Usage: $0 <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
    exit 1
fi

# Create local argument variables.
TARGET=$1

# Remove TARGET from arguments list
shift

# Define platforms variable
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi
PLATFORMS=$@

# Use the script folder to refer to other scripts.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_TEST="$FOLDER/test.sh"

# A function that run a certain script and checks for errors
run_script() {
    local script="$1"
    shift  # Remove the first argument (script path) from the argument list

    if [ ! -f "$script" ]; then
        echo "Error: Script not found: $script"
        exit 1
    fi

    chmod +x "$script"
    if ! "$script" "$@"; then
        echo "Error: Script $script failed"
        exit 1
    fi
}

# Start script
echo ""
echo "Validating project..."
echo ""

# Run SwiftLint
echo "Running SwiftLint"
if ! swiftlint --strict; then
    echo "Error: SwiftLint failed"
    exit 1
fi

# Run unit tests
echo "Testing..."
run_script "$SCRIPT_TEST" "$TARGET" "$PLATFORMS"

# Complete successfully
echo ""
echo "Project successfully validated!"
echo ""
