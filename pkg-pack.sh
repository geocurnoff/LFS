#!/usr/bin/bash

# Script for making binary packages

[ "$#" -lt 1 ] && die "USAGE: pkg-pack.sh [<destination>] <package name>"

PACKAGES_DIR=$(readlink -f `dirname $0`)

. $PACKAGES_DIR/config.sh

. $PACKAGES_DIR/common.sh

if [ "$#" -eq 2 ]; then
	DESTINATION=$1
	PKG_DIR_NAME=$2
else
	PKG_DIR_NAME=$1
fi

# Default destination is ./
DESTINATION="${DESTINATION:-./}"

# Convert to absolute
DESTINATION=$(readlink -f $DESTINATION)

dir_exists_in $PKG_DIR_NAME $PACKAGES_DIR || die "Package doesn't exist!"

NAME=$(basename "$PACKAGES_DIR/$PKG_DIR_NAME/")

# echo ""
# echo "NAME:$NAME"
# echo "PACKAGES_DIR:$PACKAGES_DIR"
# echo "DESTINATION:$DESTINATION"
# echo "PKG_DIR_NAME:$PKG_DIR_NAME"
# echo ""

[ -d $PACKAGES_DIR/$PKG_DIR_NAME/build ] || die "Package $NAME is not built. Try running: \"pkg-invoke clear fetch prepare build $NAME\""

# Get a tmp directory for sources
TMPDIR=$(mktemp -d)

cleanup() {
	echo "Clean-up..."
	rm -rv $TMPDIR
}

# Clean-up trap
trap "cleanup" 0

pushd $TMPDIR

mkdir -p $TMPDIR/$NAME || die

cp -r $PACKAGES_DIR/$PKG_DIR_NAME/build ./$NAME || die

cp -v $PACKAGES_DIR/$PKG_DIR_NAME/{pre-install.hook.sh,post-install.hook.sh,pre-uninstall.hook.sh,post-uninstall.hook.sh} ./$NAME 2> /dev/null

tar -cvf ./${NAME}.tar.gz ./$NAME || die "Couldn't create the archive."

cp *.tar.gz $DESTINATION 

popd


