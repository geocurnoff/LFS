#!/usr/bin/bash


SCRIPT_DIR=$(readlink -f `dirname $0`)

. $SCRIPT_DIR/config.sh

. $SCRIPT_DIR/common.sh

#mkdir -vp $LFS$TOOLS

#[ -e $TOOLS ] || ln -sv $LFS$TOOLS $TOOLS

INITSYS_PACKAGES="glibc-2.21"
#INITSYS_PACKAGES="gcc-4.9.2"
#INITSYS_PACKAGES="binutils-2.25"

for pkg in $INITSYS_PACKAGES; do
	./pkg-invoke.sh prepare build $pkg
	#./pkg-invoke.sh clear fetch prepare build $pkg
done



