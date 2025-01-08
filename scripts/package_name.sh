#!/bin/bash

if [ ! -f "Package.swift" ]; then
    echo "Error: Package.swift not found in current directory"
    exit 1
fi

# Using grep and sed to extract the package name
# 1. grep finds the line containing "name:"
# 2. sed extracts the text between quotes
package_name=$(grep -m 1 'name:.*"' Package.swift | sed -n 's/.*name:[[:space:]]*"\([^"]*\)".*/\1/p')

if [ -z "$package_name" ]; then
    echo "Error: Could not find package name in Package.swift"
    exit 1
else
    echo "$package_name"
fi
