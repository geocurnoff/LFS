. $LFS_SRC/tools.cfg.sh

# NOTE: Requires binutils in /tools

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

CC=$LFS_TGT-gcc                                      \
CXX=$LFS_TGT-g++                                     \
AR=$LFS_TGT-ar                                       \
RANLIB=$LFS_TGT-ranlib                               \
$SRC/gcc-*/configure                                 \
    --with-sysroot=$LFS                              \
    --prefix=$TOOLS                                  \
    --with-local-prefix=$TOOLS                       \
    --with-native-system-header-dir=$TOOLS/include   \
    --enable-languages=c,c++                         \
    --disable-libstdcxx-pch                          \
    --disable-multilib                               \
    --disable-bootstrap                              \
    --disable-libgomp || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install

# Make limits file
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  $BUILD`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

# cc alias for gcc 
ln -sv gcc $BUILD/tools/bin/cc