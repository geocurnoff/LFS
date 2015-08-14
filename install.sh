#!/usr/bin/bash

set +h
umask 022

BOOTSTRAP=1
export BOOTSTRAP

. config.sh

#mkdir -vp $LFS$TOOLS

#[ -e $TOOLS ] || ln -sv $LFS$TOOLS $TOOLS

INITSYS_PACKAGES="gcc-4.9.2"
#INITSYS_PACKAGES="binutils-2.25"

for pkg in $INITSYS_PACKAGES; do
	./pkg-invoke.sh clear fetch prepare build $pkg
done



