#!/bin/bash

# Documentation:
# This script tests a <TARGET> for a specific platform.
# Use _ instead of spaces when passing in the <PLATFORM>.

# Verify that all required arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: This script requires exactly two arguments"
    echo "Usage: $0 <TARGET> <PLATFORM>"
    exit 1
fi

TARGET=$1
PLATFORM="${2//_/ }"

xcodebuild test -scheme $TARGET -derivedDataPath .build -destination "$PLATFORM" -enableCodeCoverage YES;
