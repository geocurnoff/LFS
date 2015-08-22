#!/bin/bash

PKG_DB="./pkgsdb/"

SCRIPT_DIR=$(readlink -f `dirname $0`)

die() {  printf %s "${@+$@$'\n'}" 1>&2 ; exit 1; }

PKGPATH=$(readlink -f $1)

[ -f $PKGPATH ] || die "File $PKGPATH doesn't exist!" 

# Default ROOT is /
ROOT="${ROOT:-/}"
ROOT=$(readlink -f $ROOT)

# Default package database location
PKG_DB="${PKG_DB:-/var/pkgs}"
PKG_DB=$(readlink -f $PKG_DB)

# Initialize, if this is first run
[ -d $PKG_DB ] || mkdir -p $PKG_DB

# Get a tmp directory for sources
TMPDIR=$(mktemp -d)

cleanup() {
	echo "Clean-up..."
	rm -rv $TMPDIR
}

# Clean-up trap
trap "cleanup" 0

pushd $TMPDIR

tar -xvf $PKGPATH

PKGNAME=$(find ./ -maxdepth 1 -type d | tail -n 1) # Find package directory PKGname
PKGNAME=${PKGNAME:2}                               # Strip leading ./

# Pre-install hook
[ -f ./$PKGNAME/pre-install.hook.sh ] && ./$PKGNAME/pre-install.hook.sh
# Perform installation into specified root and record changes
$SCRIPT_DIR/dir-install.sh ./$PKGNAME/build $ROOT $TMPDIR/FILES || die "Installation of $PKGNAME into target root $ROOT failed"
# Post-install hook
[ -f ./$PKGNAME/post-install.hook.sh ] && ./$PKGNAME/post-install.hook.sh

# Create an uninstall script from list of installed files
while read line; do
	echo "rm $line" >> ./uninstall.sh
done < "$TMPDIR/FILES"

# Create "entry" in package "database"
mkdir -p $PKG_DB/$PKGNAME 

cp -v ./uninstall.sh $PKG_DB/$PKGNAME
cp -v ./$PKGNAME/{pre-uninstall.hook.sh,post-uninstall.hook.sh} $PKG_DB/$PKGNAME

popd


# scan build, store file list under package PKGname, copy files
# invoke install command pkg-invoke install $1


# install build package (if necessery), copy files and record changes

# inital system installer
# low level package interface
# normal exploitation scripts, installation, removal of packages, 