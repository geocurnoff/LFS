LFS_SRC=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/die.sh

PACKAGES_DIR=$LFS_SRC"/packages"

USE_CACHED=1
if [ $1 = "--overwrite" ] || [ $1 = "-o" ]; then
	USE_CACHED=0
fi

for f in $PACKAGES_DIR/*; do
	NAME=$(basename $f)
	USE_CACHED=$USE_CACHED $LFS_SRC/pkg.sh fetch $NAME || die "Fetching files for $NAME failed."
done