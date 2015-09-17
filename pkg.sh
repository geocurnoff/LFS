#!/usr/bin/bash

# A command interface for packages

# Enable extended glob patterns for case expressions
shopt -s extglob

# Default Permissions & Hashing Off 
umask 022; set +h;

[ "$#" -lt 2 ] && echo "\
USAGE: pkg.sh <command list> <package name>
       pkg.sh create <package name>" 1>&2 && exit 1

LFS_SRC=$(readlink -f `dirname $0`)
PACKAGES_DIR=$LFS_SRC"/packages"
TEMPLATES_DIR=$LFS_SRC"/templates"

# Import helper functions

. $LFS_SRC/lib/die.sh

. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/get-file.sh

. $LFS_SRC/lib/dir-install.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/pkg-create.sh

# Configuration

. $LFS_SRC/pkg.cfg.sh

LAST_ARGUMENT="${@:$#}"

PKG_DIR_NAME=$(parse-name $LAST_ARGUMENT )

[ -d $PACKAGES_DIR/$PKG_DIR_NAME ] || die "Package doesn't exist!"

# Recursively process each command

if [ "$#" -gt 2 ]; then
    $LFS_SRC/pkg.sh $1 $LAST_ARGUMENT || die "Command $1 failed."
    shift
    $LFS_SRC/pkg.sh $@ || die
else
    pushd $PACKAGES_DIR/$PKG_DIR_NAME/ > /dev/null || die

    # Set variables available to all package commands

    # Target name
    TARGET="$(parse-target $LAST_ARGUMENT)"
    TARGET="${TARGET:-DEFAULT}"

    # Package directory
    PKGDIR=$(pwd)

    # Fake root
    BUILD=$PKGDIR/build/$TARGET

    # Source code
    SRC=$PKGDIR/src/$TARGET

    # Temporary files
    SCRATCH=$PKGDIR/scratch/$TARGET

    # Fetched files
    CACHE=$PKGDIR/cache/$TARGET

    # Package name
    NAME=$(basename "$PACKAGES_DIR/$PKG_DIR_NAME/")

      # Prepare directories
    # mkdir -pv $BUILD
    # mkdir -pv $SRC
    # mkdir -pv $SCRATCH
    # mkdir -pv $CACHE

    # Invoked command
    COMMAND=$1

    echo "PKGDIR: $PKGDIR"
    echo "BUILD: $BUILD"
    echo "SRC: $SRC"
    echo "SCRATCH: $SCRATCH"
    echo "CACHE: $CACHE"
    echo "NAME: $NAME"
    echo "TARGET: $TARGET"
    echo "COMMAND: $COMMAND"

    printf_color light-red "Invoking $1 command on package ${NAME-$2} for target ${TARGET}\n"

    if [ -f "$1".cmd.sh ]; then
        . "$1".cmd.sh || die "Command failed!"
    else
        die "Command not found!"
    fi

    popd > /dev/null
fi

exit 0

