
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/gcc-4.9.2/libstdc++-v3/configure \
    --host=$LFS_TGT                   \
    --prefix=$TOOLS                   \
    --disable-multilib                \
    --disable-shared                  \
    --disable-nls                     \
    --disable-libstdcxx-threads       \
    --disable-libstdcxx-pch           \
    --with-gxx-include-dir=/$TOOLS/$LFS_TGT/include/c++/4.9.2

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die
