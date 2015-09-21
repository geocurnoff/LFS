#!/usr/bin/bash

# Constructs a temporary toolchain

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/tools.cfg.sh

for pkg in $TOOLS_PACKAGES; do
    NAME=$(parse-name $pkg)
    [ -d "$LFS_SRC/packages/$NAME" ] || die "Package $NAME doesn't exist"
    env -i \
    HOME=$HOME \
    TERM=$TERM PS1='\u:\w\$ ' \
    ARCHITECTURE=$ARCHITECTURE \
    TOOLS_PREFIX=$TOOLS_PREFIX \
    TOOLS=$TOOLS \
    ROOT=$ROOT \
    FORCE=1 \
    LC_ALL=$LC_ALL \
    LFS_TGT=$LFS_TGT \
    PATH=$PATH \
    USE_CACHED=$USE_CACHED \
    /bin/bash -c "$LFS_SRC/pkg.sh $COMMANDS $pkg" || die "Building $NAME failed"
done

exit 0

if (( $STRIP==1 )); then
    strip --strip-debug $TOOLS/lib/*
    /usr/bin/strip --strip-unneeded $TOOLS/{,s}bin/*
    rm -rf $TOOLS/{,share}/{info,man,doc}
fi

sudo chown -R root:root $ROOT/$TOOLS_PREFIX

