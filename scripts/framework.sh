#!/bin/bash

# Documentation:
# This script builds DocC for a <TARGET> and certain <PLATFORMS>.
# This script targets iOS, macOS, tvOS, watchOS, and xrOS by default.
# You can pass in a list of <PLATFORMS> if you want to customize the build.

# Important:
# This script doesn't work on packages, only on .xcproj projects that generate a framework.

# Usage:
# framework.sh <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]
# e.g. `bash scripts/framework.sh MyTarget iOS macOS`

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires exactly one argument"
    echo "Usage: $0 <TARGET>"
    exit 1
fi

# Define argument variables
TARGET=$1

# Remove TARGET from arguments list
shift

# Define platforms variable
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi
PLATFORMS=$@

# Define local variables
BUILD_FOLDER=.build
BUILD_FOLDER_ARCHIVES=.build/framework_archives
BUILD_FILE=$BUILD_FOLDER/$TARGET.xcframework
BUILD_ZIP=$BUILD_FOLDER/$TARGET.zip

# Start script
echo ""
echo "Building $TARGET XCFramework for [$PLATFORMS]..."
echo ""

# Delete old builds
echo "Cleaning old builds..."
rm -rf $BUILD_ZIP
rm -rf $BUILD_FILE
rm -rf $BUILD_FOLDER_ARCHIVES


# Generate XCArchive files for all platforms
echo "Generating XCArchives..."

# Initialize the xcframework command
XCFRAMEWORK_CMD="xcodebuild -create-xcframework"

# Build iOS archives and append to the xcframework command
if [[ " ${PLATFORMS[@]} " =~ " iOS " ]]; then
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=iOS"               -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-iOS         SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=iOS Simulator"     -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-iOS-Sim     SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-iOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-iOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build iOS archive and append to the xcframework command
if [[ " ${PLATFORMS[@]} " =~ " macOS " ]]; then
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=macOS"             -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-macOS       SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-macOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build tvOS archives and append to the xcframework command
if [[ " ${PLATFORMS[@]} " =~ " tvOS " ]]; then
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=tvOS"              -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS        SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=tvOS Simulator"    -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS-Sim    SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build watchOS archives and append to the xcframework command
if [[ " ${PLATFORMS[@]} " =~ " watchOS " ]]; then
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=watchOS"           -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS     SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=watchOS Simulator" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS-Sim SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build xrOS archives and append to the xcframework command
if [[ " ${PLATFORMS[@]} " =~ " xrOS " ]]; then
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=xrOS"              -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS        SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=xrOS Simulator"    -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS-Sim    SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Genererate XCFramework
echo "Generating XCFramework..."
XCFRAMEWORK_CMD+=" -output $BUILD_FILE"
eval "$XCFRAMEWORK_CMD"

# Genererate iOS XCFramework zip
echo "Generating XCFramework zip..."
zip -r $BUILD_ZIP $BUILD_FILE
echo ""
echo "***** CHECKSUM *****"
swift package compute-checksum $BUILD_ZIP
echo "********************"
echo ""

# Complete successfully
echo ""
echo "$TARGET XCFramework created successfully!"
echo ""
