#!/usr/bin/bash


SCRIPT_DIR=$(readlink -f `dirname $0`)

ARCHITECTURE=$(uname -m)
LFS=/mnt/LFS
TOOLS=/tools
LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu
PATH=$TOOLS/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH TOOLS

. $SCRIPT_DIR/common.sh

#mkdir -vp $LFS$TOOLS

#[ -e $TOOLS ] || ln -sv $LFS$TOOLS $TOOLS

#INITSYS_PACKAGES="glibc-2.21"
#INITSYS_PACKAGES="gcc-4.9.2"
INITSYS_PACKAGES="binutils-2.25/initsys/1 gcc-4.9.2/initsys/1"

for pkg in $INITSYS_PACKAGES; do
	NAME=$(extract_name $pkg)
	echo $NAME
	[ -d $NAME ] || (echo "Package doesn\'t exist" 1>&2 && exit 1)
	./pkg-invoke.sh clear fetch prepare build $pkg
	FORCE=1 ./dir-install.sh $NAME/build/tools/ /tools
done



