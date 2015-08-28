#!/usr/bin/bash

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

ARCHITECTURE=$(uname -m)

# Installation root
LFS=/mnt/lfs

# Path used as prefix for temporary tools
TOOLS=/tools

# Locale
LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu

# Prefer newly built binaries under /tools/bin over host system binaries
PATH=$TOOLS/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH TOOLS

# Turn off hashing
set +h

# New files will end up with permission mode 644 and directories with mode 755
umask 022

. $LFS_SRC/lib/parse-name.sh

# Recreate install paths
umount $TOOLS
rm -rf $LFS
rm -rf $TOOLS
mkdir -vp $LFS$TOOLS
mkdir -vp $TOOLS
mount --bind $LFS$TOOLS $TOOLS

exit 0

pushd /
ln -sv $LFS$TOOLS/ $(basename $TOOLS)
popd

# #INITSYS_PACKAGES="glibc-2.21"
# #INITSYS_PACKAGES="gcc-4.9.2"
INITSYS_PACKAGES="binutils-2.25/initsys/1"
# INITSYS_PACKAGES="binutils-2.25/initsys/1 gcc-4.9.2/initsys/1"

for pkg in $INITSYS_PACKAGES; do
	NAME=$(extract_name $pkg)
	echo $NAME
	[ -d $NAME ] || (echo "Package doesn\'t exist" 1>&2 && exit 1)
	./pkg-invoke.sh clear fetch prepare build $pkg
	FORCE=1 ./dir-install.sh $NAME/build/tools/ /tools
done



