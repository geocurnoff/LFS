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

prepare-root $LFS

prepare-host-tools $LFS

mkdir $LFS/$TOOLS_PREFIX
mkdir $LFS/$SOURCES_PREFIX
cp -rv $LFS_SRC/* $LFS/$SOURCES_PREFIX

# -i
chroot "$LFS" /usr/bin/env        \
    HOME=/root                    \
    TERM="$TERM"                  \
    PS1='\u:\w\$ '                \
    PATH=/tools/bin:/bin:/usr/bin \
    /usr/bin/bash --login +h -c "/$SOURCES_PREFIX/tools-build.sh"

# mkdir -p $LFS/{usr,bin,lib,lib64}
# mount --bind /usr $LFS/usr
# mount --bind /bin $LFS/bin
# mount --bind /lib $LFS/lib
# mount --bind /lib64 $LFS/lib64


echo "post-chroot"

# teardown-root $LFS




# mkdir -p $LFS/{usr,bin,lib,lib64}
# mount --bind /usr $LFS/usr
# mount --bind /bin $LFS/bin
# mount --bind /lib $LFS/lib
# mount --bind /lib64 $LFS/lib64

# mkdir -p $LFS/usr/src



