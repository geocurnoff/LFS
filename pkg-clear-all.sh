
# Remove all fetched and temporary files

LFS_SRC=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/die.sh

. $LFS_SRC/lib/printf-color.sh

PACKAGES_DIR=$LFS_SRC"/packages"

for f in $PACKAGES_DIR/*; do
    NAME=$(basename $f)
    printf_color   light-red "Clearing $NAME"
    rm -rfv $f/build
    rm -rfv $f/src
    rm -rfv $f/cache
    rm -rfv $f/scratch
done
