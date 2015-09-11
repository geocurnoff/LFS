
. $LFS_SRC/tools.cfg.sh

# NOTE: Requires binutils in /tools

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/gcc-*/configure                                 \
    --target=$LFS_TGT                                \
    --prefix=$TOOLS                                  \
    --with-glibc-version=2.11                        \
    --with-sysroot=$LFS                              \
    --with-newlib                                    \
    --without-headers                                \
    --with-local-prefix=$TOOLS                       \
    --with-native-system-header-dir=$TOOLS/include   \
    --disable-nls                                    \
    --disable-shared                                 \
    --disable-multilib                               \
    --disable-decimal-float                          \
    --disable-threads                                \
    --disable-libatomic                              \
    --disable-libgomp                                \
    --disable-libquadmath                            \
    --disable-libssp                                 \
    --disable-libvtv                                 \
    --disable-libcilkrts                             \
    --disable-libstdcxx                              \
    --enable-languages=c,c++ || die "Configuring $NAME failed."

#   --disable-libitm                                 \
#   --disable-libsanitizer                           \

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install
