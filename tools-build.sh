#!/usr/bin/bash

# Constructs a temporary toolchain (in current root filesystem!)

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/lfs.cfg.sh
. $LFS_SRC/packages/shared/tools.cfg.sh

[ -e /$TOOLS ] || die "$TOOLS doesn't exist!"

COMMANDS="clear fetch prepare build install"
for pkg in $TOOLS_PACKAGES; do
    NAME=$(parse-name $pkg)
    env -i \
    HOME=$HOME \
    TERM=$TERM PS1='\u:\w\$ ' \
    PATH=$PATH \
    /bin/bash -c "$LFS_SRC/pkg.sh $COMMANDS $pkg" || die "Building $NAME failed"
done

exit 0

if (( $STRIP==1 )); then
    strip --strip-debug $TOOLS/lib/*
    /usr/bin/strip --strip-unneeded $TOOLS/{,s}bin/*
    rm -rf $TOOLS/{,share}/{info,man,doc}
fi

sudo chown -R root:root $ROOT/$TOOLS_PREFIX

