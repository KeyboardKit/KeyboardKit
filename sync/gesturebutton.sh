#!/bin/bash

# This script syncs the GestureButton dependency

# Variables
NAME="GestureButton"
SOURCE="../../opensource/$NAME/Sources/$NAME/"
TARGET="Sources/KeyboardKit/_Dependencies/$NAME/"

# Remove
rm -rf "$TARGET"

# Add dependency and remove documentation
cp -r "$SOURCE" "$TARGET"
rm -rf "$TARGET/$NAME.docc"

# Commit the changes
git add .
git commit -am "Update $NAME"