#!/bin/bash

# Documentation:
# This script validates the project for a <TARGET>.
# The script will fail if swiftlint fails, or if any build and test runner fails.

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
BUILD="$FOLDER/build.sh"
TEST="$FOLDER/test.sh"

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

echo "Running SwiftLint"
if ! swiftlint; then
    echo "Error: SwiftLint failed."
    exit 1
fi

echo "Building..."
run_script "$BUILD" "$TARGET"

echo "Testing..."
run_script "$TEST" "$TARGET"

echo ""
echo "Project successfully validated!"
echo ""