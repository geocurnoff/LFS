. $LFS_SRC/tools.cfg.sh

cd $SRC/*/

CC=$LFS_TGT-gcc             \
CXX=$LFS_TGT-g++            \
AR=$LFS_TGT-ar              \
RANLIB=$LFS_TGT-ranlib      \
make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD
mkdir -v -p $BUILD

# Install to fake root
make PREFIX=$BUILD/$TOOLS_PREFIX install