#!/bin/bash

# Documentation:
# This script echos the default git branch name.

# Usage:
# git_default_branch.sh
# e.g. `bash scripts/git_default_branch.sh`

BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
echo $BRANCH
