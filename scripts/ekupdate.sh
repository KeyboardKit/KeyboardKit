#!/bin/bash

# Use the script folder to refer to other scripts
SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ADD="$SCRIPT/ekadd.sh"
REMOVE="$SCRIPT/ekremove.sh"
UPDATE="$SCRIPT/ekupdate.sh"

# Remove any existing files, then re-add the depenceny
chmod +x "$UPDATE"
chmod +x "$REMOVE" && bash "$REMOVE"
chmod +x "$ADD" && bash "$ADD"

# Commit the changes
git add .
git commit -am "Update EmojiKit"