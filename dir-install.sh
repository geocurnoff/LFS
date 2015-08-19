#!/bin/bash

# Helper script for installing packages into target root and keeping track of installed installed files

die() {  printf %s "${@+$@$'\n'}" 1>&2 ; exit 1; }

[ "$#" -lt 2 ] && die "USAGE: dir-install.sh <SOURCE> <DESTINATION> [<LIST OUT>]"

# $1: Where to copy files from
SRC=$(readlink -f $1)

[ -d $SRC ] || die "$SRC is not a valid source directory."

# $2: Where to copy file to
TGT=$(readlink -f $2)

[ -d $TGT ] || die "$TGT is not a valid destination directory."


# $3: Optional, where to write list of installed files
# Alternatively, output to stdout
if [ $3 ]; then 
	LIST_FILE=$(readlink -f $3)
fi

# Overwrite files in target directory?
FORCE=${FORCE:-0}

pushd $SRC &> /dev/null || die

FILES=$(find ./ -type f -o -type l)

popd &> /dev/null || die

if (( $FORCE==0 )); then
	pushd $TGT &> /dev/null || die
	for f in $FILES
	do 
	 	abs_f=`readlink -f $f` # TODO: doesn't work with links, shows wrong path
		[ -f $f ] && die "File $abs_f exists!"
	done > "${3:-/dev/stdout}"
	popd &> /dev/null || die
fi

# Copy files to target directory supplied in second argument
pushd $SRC &> /dev/null || die

cp -r ./* $TGT &> /dev/null || die

popd &> /dev/null || die

# Write list of installed files to either standard output or file supplied in third argument
pushd $TGT &> /dev/null || die
for f in $FILES
do
 	pushd `dirname $f` &> /dev/null
 	echo `pwd``basename $f`
 	popd &> /dev/null
done > "${LIST_FILE:-/dev/stdout}"
popd &> /dev/null || die



# discover all files to be installed
# make sure no files are going to be replaced, fail otherwise
# 

# pkg-install.sh ./zlib-3.15/build / > /var/pkgs/zlib-3.15
# pkg-uninstall.sh < /var/pkgs/zlib-3.15

