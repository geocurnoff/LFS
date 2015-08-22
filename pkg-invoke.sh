#!/usr/bin/bash

# A command interface for packages

[ "$#" -lt 2 ] && echo "USAGE: pkg-invoke.sh <command list> <package name>" 1>&2 && exit 1

PACKAGES_DIR=$(readlink -f `dirname $0`)

. $PACKAGES_DIR/config.sh

. $PACKAGES_DIR/common.sh

PKG_DIR_NAME="${@:$#}"

dir_exists_in $PKG_DIR_NAME $PACKAGES_DIR || die "Package doesn't exist!"

# Recursively process each command

if [ "$#" -gt 2 ]; then
	$PACKAGES_DIR/pkg-invoke.sh $1 $PKG_DIR_NAME || die "Command $1 failed."
	shift
	$PACKAGES_DIR/pkg-invoke.sh $@ || die
else
	pushd $PACKAGES_DIR/$PKG_DIR_NAME/ > /dev/null || die

	PKGDIR=$(pwd)
	BUILD=$PKGDIR/build
    SRC=$PKGDIR/src
    SCRATCH=$PKGDIR/scratch
	NAME=$(basename "$PACKAGES_DIR/$PKG_DIR_NAME/")

	RED='\033[1;31m'
	NC='\033[0m' # No Color
	printf "${RED}Invoking $1 command on package ${NAME-$2}${NC}\n"
	[ -f "$1".cmd.sh ] && . "$1".cmd.sh || die "Command not found!"
	popd > /dev/null
fi

exit 0
