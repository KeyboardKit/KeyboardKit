#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script finds the main target name in Package.swift."

    echo
    echo "Usage: $0 [OPTIONS]"
    echo "  -h, --help           Show this help message"
    
    echo
    echo "Examples:"
    echo "  $0"
    echo "  bash scripts/package_name.sh"
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

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            show_error_and_exit "Unexpected argument '$1'" ;;
    esac
    shift
done

# Check that a Package.swift file exists
if [ ! -f "Package.swift" ]; then
    show_error_and_exit "Package.swift not found in current directory"
fi

# Using grep and sed to extract the package name
# 1. grep finds the line containing "name:"
# 2. sed extracts the text between quotes
if ! package_name=$(grep -m 1 'name:.*"' Package.swift | sed -n 's/.*name:[[:space:]]*"\([^"]*\)".*/\1/p'); then
    show_error_and_exit "Could not find package name in Package.swift"
fi

if [ -z "$package_name" ]; then
    show_error_and_exit "Could not find package name in Package.swift"
fi

# Output the package name
echo "$package_name"