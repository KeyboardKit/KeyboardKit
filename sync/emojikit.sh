#!/bin/bash

# This script syncs the EmojiKit dependency

# Variables
NAME="EmojiKit"
SOURCE="../../sdks/$NAME/Sources/$NAME/"
TARGET="Sources/KeyboardKit/_Dependencies/$NAME/"

# Remove
rm -rf "$TARGET"

# Add dependency and remove documentation
cp -r "$SOURCE" "$TARGET"
rm -rf "$TARGET/$NAME.docc"

# Remove other things not used in this library
rm -rf "$TARGET/Bundle"
rm -rf "$TARGET/Extensions/GeometryProxy+Grid.swift"
rm -rf "$TARGET/Localization/Localizable+Module.swift"
rm -rf "$TARGET/Resources"
rm -rf "$TARGET/Views"

# Commit the changes
git add .
git commit -am "Update $NAME"
