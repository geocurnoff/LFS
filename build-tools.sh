#!/usr/bin/bash

# Constructs a temporary tool chain (in current root filesystem!)

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)
SHARED=$LFS_SRC/packages/shared/

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/lfs.cfg.sh
. $LFS_SRC/packages/shared/tools.cfg.sh

[ "$#" -lt 1 ] && die "\
USAGE: build-tools.sh <target directory>"

LFS=$1

if [ -e /$TOOLS_PREFIX ]; then
	die "File already exists: \"/$TOOLS_PREFIX\"!"
fi

if [ -e $LFS/$TOOLS_PREFIX ]; then
	die "File already exists: \"$LFS/$TOOLS_PREFIX\"!"
fi

mkdir -pv $LFS/$TOOLS_PREFIX && \
sudo ln -s $LFS/$TOOLS_PREFIX /$TOOLS_PREFIX || die

COMMANDS="clear fetch prepare build install"
COMMANDS="install"
for pkg in $TOOLS_PACKAGES; do
    NAME=$(parse-name $pkg)
    env -i \
    HOME=$HOME \
    TERM=$TERM PS1='\u:\w\$ ' \
    PATH=$PATH \
    /bin/bash -c "$LFS_SRC/pkg.sh $COMMANDS $pkg" || die "Building $NAME failed"
done

sudo rm /$TOOLS_PREFIX

exit 0

if (( $STRIP==1 )); then
    strip --strip-debug $TOOLS/lib/*
    /usr/bin/strip --strip-unneeded $TOOLS/{,s}bin/*
    rm -rf $TOOLS/{,share}/{info,man,doc}
fi

sudo chown -R root:root $ROOT/$TOOLS_PREFIX

