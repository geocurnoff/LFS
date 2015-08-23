#!/usr/bin/bash

extract_name() {
	echo $1 | sed -ne 's@\(^[^[:space:]/]*\).*@\1@p'
	# Sed demangling 
	# s - replace command, 
	# @ is delimiter 
	# \( \) - grouping
	# ^[^[:space:]/]* - match everything except whitespace and /
	# \( \).* - match the rest of the string, whatever it is 
	# @\1@ - replace matched string with the group \1
	# p - print
}

extract_target() {
	echo $1 | sed -ne 's@^[^[:space:]/]*/\([^[:space:]]*\)@\1@p'
}

# A command interface for packages

[ "$#" -lt 2 ] && echo "USAGE: pkg-invoke.sh <command list> <package name>" 1>&2 && exit 1

PACKAGES_DIR=$(readlink -f `dirname $0`)

. $PACKAGES_DIR/config.sh

. $PACKAGES_DIR/common.sh

LAST_ARGUMENT="${@:$#}"
PKG_DIR_NAME=$(extract_name $LAST_ARGUMENT )

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
	TARGET="$(extract_target $LAST_ARGUMENT)"
	TARGET="${TARGET:-DEFAULT}"

	RED='\033[1;31m'
	NC='\033[0m' # No Color
	printf "${RED}Invoking $1 command on package ${NAME-$2} for target ${TARGET} ${NC}\n"
	[ -f "$1".cmd.sh ] && . "$1".cmd.sh || die "Command not found!"
	popd > /dev/null
fi

exit 0

