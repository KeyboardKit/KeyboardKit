#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_usage() {
    echo
    echo "This script builds an XCFramework for a <TARGET> and certain <PLATFORMS>."

    echo
    echo "Usage: $0 [TARGET] [-p|--platforms <PLATFORM1> <PLATFORM2> ...] [-d|--dSyms <0|1>]"
    echo "  [TARGET]              Optional. The target to build framework for (defaults to package name)"
    echo "  -p, --platforms       Optional. List of platforms (default: iOS macOS tvOS watchOS xrOS)"
    echo "  -d, --dsyms           Optional. Include dSYMs (0 or 1, default: 0)"
    echo "  -z, --zip             Optional. Generate zip files (0 or 1, default: 0)"

    echo
    echo "Important: This script doesn't work on packages, only on .xcproj projects that generate a framework."

    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 MyTarget"
    echo "  $0 -p iOS macOS"
    echo "  $0 MyTarget -p iOS macOS"
    echo "  $0 MyTarget --platforms iOS macOS tvOS watchOS xrOS"
    echo "  $0 MyTarget --dsyms 1 --zip 1"
    echo "  $0 MyTarget -p iOS macOS -d 1 -z 1"
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

# Define argument variables
TARGET=""
PLATFORMS="iOS macOS tvOS watchOS xrOS"  # Default platforms
INCLUDE_DSYMS=0  # Default to not including dSYMs
GENERATE_ZIPS=0   # Default to not generating zip files

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
                show_error_and_exit "--platforms requires at least one platform"
            fi
            ;;
        -d|--dsyms)
            shift
            if [[ "$1" == "0" || "$1" == "1" ]]; then
                INCLUDE_DSYMS="$1"
                shift
            else
                show_error_and_exit "--dsyms requires 0 or 1"
            fi
            ;;
        -z|--zip)
            shift
            if [[ "$1" == "0" || "$1" == "1" ]]; then
                GENERATE_ZIPS="$1"
                shift
            else
                show_error_and_exit "--zip requires 0 or 1"
            fi
            ;;
        -h|--help)
            show_usage; exit 0 ;;
        -*)
            show_error_and_exit "Unknown option $1" ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            else
                show_error_and_exit "Unexpected argument '$1'"
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
            read -p "Failed to get package name. Please enter the target to build framework for: " TARGET
            if [ -z "$TARGET" ]; then
                show_error_and_exit "TARGET is required"
            fi
        fi
    else
        echo ""
        read -p "Please enter the target to build framework for: " TARGET
        if [ -z "$TARGET" ]; then
            show_error_and_exit "TARGET is required"
        fi
    fi
fi

# Define local variables
BUILD_FOLDER=.build
BUILD_FOLDER_ARCHIVES=.build/framework_archives
BUILD_FILE=$BUILD_FOLDER/$TARGET.xcframework
BUILD_ZIP=$BUILD_FOLDER/$TARGET.zip
DSYM_FOLDER=$BUILD_FOLDER/dSYMs
DSYM_ZIP=$BUILD_FOLDER/$TARGET-dSYMs.zip

# Get absolute path for reliable dSYM referencing
ABSOLUTE_BUILD_PATH="$(pwd)/$BUILD_FOLDER_ARCHIVES"

# Start script
echo
echo "Building $TARGET XCFramework for [$PLATFORMS]..."
if [ "$INCLUDE_DSYMS" == "1" ]; then
    echo "dSYMs will be packaged separately (note: dSYMs cannot be embedded in XCFramework with simulator variants)"
fi

# Delete old builds
echo "Cleaning old builds..."
rm -rf $BUILD_ZIP
rm -rf $BUILD_FILE
rm -rf $BUILD_FOLDER_ARCHIVES
rm -rf $DSYM_FOLDER
rm -rf $DSYM_ZIP

# Generate XCArchive files for all platforms
echo "Generating XCArchives..."

# Initialize the xcframework command
XCFRAMEWORK_CMD="xcodebuild -create-xcframework"

# Build iOS archives and append to the xcframework command
if [[ " ${PLATFORMS} " =~ " iOS " ]]; then
    echo "Building iOS archives..."
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=iOS" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-iOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build iOS archive"
        exit 1
    fi
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=iOS Simulator" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-iOS-Sim SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build iOS Simulator archive"
        exit 1
    fi
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-iOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-iOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build macOS archive and append to the xcframework command
if [[ " ${PLATFORMS} " =~ " macOS " ]]; then
    echo "Building macOS archive..."
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=macOS" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-macOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build macOS archive"
        exit 1
    fi
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-macOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build tvOS archives and append to the xcframework command
if [[ " ${PLATFORMS} " =~ " tvOS " ]]; then
    echo "Building tvOS archives..."
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=tvOS" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build tvOS archive"
        exit 1
    fi
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=tvOS Simulator" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS-Sim SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build tvOS Simulator archive"
        exit 1
    fi
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-tvOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build watchOS archives and append to the xcframework command
if [[ " ${PLATFORMS} " =~ " watchOS " ]]; then
    echo "Building watchOS archives..."
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=watchOS" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build watchOS archive"
        exit 1
    fi
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=watchOS Simulator" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS-Sim SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build watchOS Simulator archive"
        exit 1
    fi
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-watchOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Build xrOS archives and append to the xcframework command
if [[ " ${PLATFORMS} " =~ " xrOS " ]]; then
    echo "Building xrOS archives..."
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=xrOS" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build xrOS archive"
        exit 1
    fi
    if ! xcodebuild archive -scheme $TARGET -configuration Release -destination "generic/platform=xrOS Simulator" -archivePath $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS-Sim SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES DEBUG_INFORMATION_FORMAT=dwarf-with-dsym; then
        echo "Failed to build xrOS Simulator archive"
        exit 1
    fi
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS.xcarchive/Products/Library/Frameworks/$TARGET.framework"
    XCFRAMEWORK_CMD+=" -framework $BUILD_FOLDER_ARCHIVES/$TARGET-xrOS-Sim.xcarchive/Products/Library/Frameworks/$TARGET.framework"
fi

# Generate XCFramework
echo "Generating XCFramework..."
XCFRAMEWORK_CMD+=" -output $BUILD_FILE"
if ! eval "$XCFRAMEWORK_CMD"; then
    echo "Failed to generate XCFramework"
    exit 1
fi

# Generate XCFramework zip and checksum if requested
if [ "$GENERATE_ZIPS" == "1" ]; then
    echo "Generating XCFramework zip..."
    if ! (cd $BUILD_FOLDER && zip -r $(basename $BUILD_ZIP) $(basename $BUILD_FILE)); then
        echo "Failed to generate XCFramework zip"
        exit 1
    fi

    echo
    echo "***** FRAMEWORK CHECKSUM *****"
    swift package compute-checksum $BUILD_ZIP
    echo "******************************"
fi

# Package dSYMs separately if requested
if [ "$INCLUDE_DSYMS" == "1" ]; then
    echo
    echo "Packaging dSYMs separately..."
    mkdir -p $DSYM_FOLDER

    # Copy all dSYMs from archives with unique naming
    for archive in $BUILD_FOLDER_ARCHIVES/*.xcarchive; do
        if [ -d "$archive/dSYMs" ]; then
            archive_name=$(basename "$archive" .xcarchive)
            for dsym in "$archive/dSYMs"/*.dSYM; do
                if [ -e "$dsym" ]; then
                    dsym_name=$(basename "$dsym")
                    # Create platform-specific folder to avoid name conflicts
                    platform_folder="$DSYM_FOLDER/$archive_name"
                    mkdir -p "$platform_folder"
                    cp -R "$dsym" "$platform_folder/" 2>/dev/null || true
                fi
            done
        fi
    done

    # Create dSYMs zip only if zip generation is enabled
    if [ "$GENERATE_ZIPS" == "1" ] && [ -d "$DSYM_FOLDER" ] && [ "$(ls -A $DSYM_FOLDER)" ]; then
        echo "Generating dSYMs zip..."
        if ! (cd $BUILD_FOLDER && zip -r $(basename $DSYM_ZIP) $(basename $DSYM_FOLDER)); then
            echo "Failed to generate dSYMs zip"
            exit 1
        fi
    elif [ "$GENERATE_ZIPS" == "0" ] && [ -d "$DSYM_FOLDER" ] && [ "$(ls -A $DSYM_FOLDER)" ]; then
        echo "dSYMs collected but not zipped (--zip not enabled)"
    else
        echo "Warning: No dSYMs found to package"
    fi
fi

# Complete successfully
echo
echo "$TARGET XCFramework created successfully!"
if [ "$INCLUDE_DSYMS" == "1" ]; then
    echo "dSYMs package created successfully!"
fi
echo
