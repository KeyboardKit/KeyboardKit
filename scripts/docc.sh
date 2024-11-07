#!/bin/bash

# Documentation:
# This script build DocC for a <TARGET>.
# The documentation ends up in to .build/docs.

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires exactly one argument"
    echo "Usage: $0 <TARGET>"
    exit 1
fi

TARGET=$1
TARGET_LOWERCASED=$(echo "$1" | tr '[:upper:]' '[:lower:]')

swift package resolve;

xcodebuild docbuild -scheme $1 -derivedDataPath /tmp/docbuild -destination 'generic/platform=iOS';

$(xcrun --find docc) process-archive \
  transform-for-static-hosting /tmp/docbuild/Build/Products/Debug-iphoneos/$1.doccarchive \
  --output-path .build/docs \
  --hosting-base-path "$TARGET";

echo "<script>window.location.href += \"/documentation/$TARGET_LOWERCASED\"</script>" > .build/docs/index.html;
