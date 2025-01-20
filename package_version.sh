#!/bin/bash

# Documentation:
# This script creates a new project version for the package.
# You can pass in a BRANCH to not use the default git branch.

DEFAULT_BRANCH="master"
BRANCH=${1:-$DEFAULT_BRANCH}
SCRIPT="scripts/package_version.sh"
chmod +x $SCRIPT && bash $SCRIPT $BRANCH
