#!/usr/bin/bash

# A command interface for packages

INSTALL="${INSTALL:-/home/echolot/root}"

[ "$#" -lt 2 ] && echo "USAGE: pkg-invoke.sh <command list> <package name>" 1>&2 && exit 1

LFS_SRC=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/die.sh

. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

PACKAGES_DIR=$LFS_SRC"/packages"

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
    pwd
	PKGDIR=$(pwd)
	BUILD=$PKGDIR/build
    SRC=$PKGDIR/src
    SCRATCH=$PKGDIR/scratch
    CACHE=$PKGDIR/cache
	NAME=$(basename "$PACKAGES_DIR/$PKG_DIR_NAME/")
	TARGET="$(parse-target $LAST_ARGUMENT)"
	TARGET="${TARGET:-DEFAULT}"
	COMMAND=$1
	
	RED='\033[1;31m'
	NC='\033[0m' # No Color
	printf "${RED}Invoking $1 command on package ${NAME-$2} for target ${TARGET} ${NC}\n"

	if [ -f "$1".cmd.sh ]; then
		. "$1".cmd.sh || die "Command failed!"
	else
		die "Command not found!"
	fi

	popd > /dev/null
fi

exit 0

