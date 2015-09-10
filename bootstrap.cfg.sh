#!/bin/bash

ARCHITECTURE=$(uname -m)

# Installation root
LFS=/mnt/lfs

# Path used as prefix for temporary tools
TOOLS=/tools

# Installation root
ROOT="/"

# Allow overwriting files in installation root
FORCE=1

# Use cached version if available
USE_CACHED=1

# Locale
LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu

# Prefer newly built binaries under /tools/bin over host system binaries
PATH=$TOOLS/bin:/bin:/usr/bin

echo "ARCHITECTURE: $ARCHITECTURE"
echo "LFS: $LFS"
echo "TOOLS: $TOOLS"
echo "ROOT: $ROOT"
echo "FORCE: $FORCE"
echo "USE_CACHED: $USE_CACHED"
echo "LC_ALL: $LC_ALL"
echo "LFS_TGT: $LFS_TGT"
echo "PATH: $PATH"
