#!/usr/bin/bash

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

. $LFS_SRC/lib/prompting.sh

. $LFS_SRC/lib/root-environment.sh

# Configuration
. $LFS_SRC/lfs.cfg.sh

[ "$#" -lt 1 ] && die "\
USAGE: lfs-build.sh <target directory>"

LFS=$1

# Build tools
if [ -e /$TOOLS_PREFIX ]; then
	die "File already exists /$TOOLS_PREFIX!"
fi

mkdir $LFS/$SOURCES_PREFIX && \
ln -s $LFS/$TOOLS_PREFIX /$TOOLS_PREFIX && \
$LFS_SRC/tools-build.sh || die "Building tools failed!"

prepare-root $LFS

# Bind source directory
mkdir $LFS/source
mount --bind /source $LFS/source


# chroot "$LFS" /usr/bin/env   -i   \
#     HOME=/root                    \
#     TERM="$TERM"                  \
#     PS1='\u:\w\$ '                \
#     TEST='abcd'                   \
#     PATH='/tools/bin:/bin:/usr/bin:/usr/local/bin' \
#     /usr/bin/bash +h

# -i
chroot "$LFS" /usr/bin/env        \
    HOME=/root                    \
    TERM="$TERM"                  \
    PS1='\u:\w\$ '                \
    PATH='/tools/bin:/bin:/usr/bin:/usr/local/bin' \
    /usr/bin/bash +h -c "/$SOURCES_PREFIX/base-build.sh"

teardown-root $LFS
