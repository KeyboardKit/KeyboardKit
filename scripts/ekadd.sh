#!/bin/bash

SOURCE="../../opensource/emojikit/Sources/EmojiKit/"
TARGET="Sources/KeyboardKit/_Dependencies/EmojiKit/"

cp -r "$SOURCE" "$TARGET"
rm -rf "$TARGET/Bundle"
rm -rf "$TARGET/EmojiKit.docc"
rm -rf "$TARGET/Extensions/GeometryProxy+Grid.swift"
rm -rf "$TARGET/Resources"
rm -rf "$TARGET/Views"