#!/bin/bash

# Use the script folder to refer to other scripts
SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ADD="$SCRIPT/gbadd.sh"
REMOVE="$SCRIPT/gbremove.sh"
UPDATE="$SCRIPT/gbupdate.sh"

# Remove any existing files, then re-add the depenceny
chmod +x "$UPDATE"
chmod +x "$REMOVE" && bash "$REMOVE"
chmod +x "$ADD" && bash "$ADD"

# Commit the changes
git add .
git commit -am "Update GestureButton"