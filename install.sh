#!/usr/bin/bash

set +h
umask 022

LFS=/mnt/LFS
TOOLS=/tools

LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu
PATH=$TOOLS/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH TOOLS

#mkdir -vp $LFS$TOOLS

#[ -e $TOOLS ] || ln -sv $LFS$TOOLS $TOOLS

BOOTSTRAP=1
export BOOTSTRAP

INITSYS_PACKAGES="gcc-4.9.2"
#INITSYS_PACKAGES="binutils-2.25"

for pkg in $INITSYS_PACKAGES; do
	./pkg-invoke.sh clear fetch prepare build $pkg
done



