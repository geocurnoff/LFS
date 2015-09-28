. $SHARED/tools.cfg.sh

cd $SRC/*/

CC=$LFS_TGT-gcc             \
CXX=$LFS_TGT-g++            \
AR=$LFS_TGT-ar              \
RANLIB=$LFS_TGT-ranlib      \
./configure --prefix=$TOOLS \
            --host=$LFS_TGT \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install