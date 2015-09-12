#!/usr/bin/bash

# Constructs a temporary toolchain

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/tools.cfg.sh

# Recreate install paths
# umount $TOOLS
# rm -rf $LFS
#rm -rf $TOOLS/*
# mkdir -vp $LFS$TOOLS
# mkdir -vp $TOOLS
#mount --bind $LFS$TOOLS $TOOLS


INITSYS_PACKAGES="\
binutils-2.25.1/initsys/1 \
gcc-5.2.0/initsys/1 \
linux-api-4.2 \
glibc-2.22/initsys \
gcc-5.2.0/initsys/libstd++ \
binutils-2.25.1/initsys/2 \
gcc-5.2.0/initsys/2 \
tcl-8.6.4/initsys"

# INITSYS_PACKAGES="\
# gcc-5.2.0/initsys/libstd++ \
# binutils-2.25.1/initsys/2 \
# gcc-5.2.0/initsys/2"


INITSYS_PACKAGES="\
gcc-5.2.0/initsys/1 \
linux-api-4.2 \
glibc-2.22/initsys \
gcc-5.2.0/initsys/libstd++ \
binutils-2.25.1/initsys/2 \
gcc-5.2.0/initsys/2"


for pkg in $INITSYS_PACKAGES; do
    NAME=$(parse-name $pkg)
    echo $NAME
    [ -d $LFS_SRC/packages/$NAME ] || die "Package doesn't exist"
    env -i \
    HOME=$HOME \
    TERM=$TERM PS1='\u:\w\$ ' \
    ARCHITECTURE=$ARCHITECTURE \
    LFS=$LFS \
    TOOLS=$TOOLS \
    ROOT=$ROOT \
    FORCE=$FORCE \
    LC_ALL=$LC_ALL \
    LFS_TGT=$LFS_TGT \
    PATH=$PATH \
    USE_CACHED=$USE_CACHED \
    /bin/bash -c "$LFS_SRC/pkg.sh fetch prepare build install $pkg" || die "Building $NAME failed"
done



