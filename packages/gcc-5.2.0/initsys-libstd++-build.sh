
. $LFS_SRC/tools.cfg.sh

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/gcc-*/libstdc++-v3/configure \
    --host=$LFS_TGT                   \
    --prefix=$TOOLS                   \
    --disable-multilib                \
    --disable-nls                     \
    --disable-libstdcxx-threads       \
    --disable-libstdcxx-pch           \
    --with-gxx-include-dir=/$TOOLS/$LFS_TGT/include/c++/5.2.0

#     --disable-shared                  \

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die

# FIX: for -lstdc++ not found error from ld
if [ $ARCHITECTURE = "x86_64" ]; then
    mv -v $BUILD/{lib64,lib}
else