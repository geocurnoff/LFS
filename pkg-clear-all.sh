
# Remove all fetched and temporary files

LFS_SRC=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/die.sh

PACKAGES_DIR=$LFS_SRC"/packages"

for f in $PACKAGES_DIR/*; do
	NAME=$(basename $f)
	$LFS_SRC/pkg.sh clear $NAME || die "Can't clear $NAME!"
done