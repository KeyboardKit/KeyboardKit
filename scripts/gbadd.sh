#!/bin/bash

SOURCE="../../opensource/gesturebutton/Sources/GestureButton/"
TARGET="Sources/KeyboardKit/_GestureButton/"

cp -r "$SOURCE" "$TARGET"
rm -rf "$TARGET/GestureButton.docc"