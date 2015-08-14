
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

pushd $SCRATCH > /dev/null || die

LFS=/mnt/LFS
TOOLS=/tools

LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu
PATH=$TOOLS/bin:/bin:/usr/bin   # TODO: turning these off break build. Why?

$SRC/gcc-4.9.2/configure                             \
    --target=$LFS_TGT                                \
    --prefix=/tools                                  \
    --with-sysroot=$LFS                              \
    --with-newlib                                    \
    --without-headers                                \
    --with-local-prefix=/tools                       \
    --with-native-system-header-dir=/tools/include   \
    --disable-nls                                    \
    --disable-shared                                 \
    --disable-multilib                               \
    --disable-decimal-float                          \
    --disable-threads                                \
    --disable-libatomic                              \
    --disable-libgomp                                \
    --disable-libitm                                 \
    --disable-libquadmath                            \
    --disable-libsanitizer                           \
    --disable-libssp                                 \
    --disable-libvtv                                 \
    --disable-libcilkrts                             \
    --disable-libstdc++-v3                           \
    --enable-languages=c,c++ || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install

popd > /dev/null