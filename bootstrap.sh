#!/usr/bin/bash

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/bootstrap.cfg.sh

# Recreate install paths
# umount $TOOLS
# rm -rf $LFS
# rm -rf $TOOLS
# mkdir -vp $LFS$TOOLS
# mkdir -vp $TOOLS
#mount --bind $LFS$TOOLS $TOOLS

#INITSYS_PACKAGES="binutils-2.25/initsys/1 gcc-4.9.2/initsys/1 linux-api-3.19/initsys glibc-2.21/initsys gcc-4.9.2/initsys/libstd++ binutils-2.25/initsys/2 gcc-4.9.2/initsys/2"
#INITSYS_PACKAGES="binutils-2.25/initsys/1 gcc-4.9.2/initsys/1 linux-api-3.19/initsys glibc-2.21/initsys gcc-4.9.2/initsys/libstd++ binutils-2.25/initsys/2"
#INITSYS_PACKAGES="binutils-2.25/initsys/1"
#INITSYS_PACKAGES="binutils-2.25/initsys/1 gcc-4.9.2/initsys/1"
#INITSYS_PACKAGES="binutils-2.25/initsys/1"
#INITSYS_PACKAGES="linux-api-3.19/initsys"
#INITSYS_PACKAGES="glibc-2.21/initsys"
#INITSYS_PACKAGES="gcc-4.9.2/initsys/libstd++"
#INITSYS_PACKAGES="binutils-2.25/initsys/2"
INITSYS_PACKAGES="gcc-4.9.2/initsys/2"

for pkg in $INITSYS_PACKAGES; do
    NAME=$(parse-name $pkg)
    echo $NAME
    [ -d $LFS_SRC/packages/$NAME ] || die "Package doesn't exist"
    $LFS_SRC/bootstrap-env.sh $LFS_SRC/pkg.sh clear fetch prepare build install $pkg || die "Building $NAME failed"
done



