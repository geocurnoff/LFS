# NOTE: Requires binutils in /tools

# Needs sudo apt-get install --reinstall libc6-dev

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/gcc-*/configure                                 \
    --target=$LFS_TGT                                \
    --prefix=$TOOLS                                  \
    --with-glibc-version=2.40                        \
    --with-sysroot=$LFS                              \
    --with-newlib                                    \
    --without-headers                                \
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

make -j6 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h
