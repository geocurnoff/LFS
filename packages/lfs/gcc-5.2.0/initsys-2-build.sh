. $SHARED/tools.cfg.sh

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
    --host=$LFS_TGT                                  \
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
LIMITS_DIR=$BUILD`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed
mkdir -pv $LIMITS_DIR
cat $SRC/*/gcc/limitx.h $SRC/*/gcc/glimits.h $SRC/*/gcc/limity.h > $LIMITS_DIR/limits.h

# cc alias for gcc 
ln -sv gcc $BUILD/tools/bin/cc

# FIX: lib64 again...
[ -d $BUILD/$TOOLS_PREFIX/lib64/ ] && mv -v $BUILD/$TOOLS_PREFIX/lib64/* $BUILD/$TOOLS_PREFIX/lib
[ -d $BUILD/$TOOLS_PREFIX/lib64/ ] && rm -rfv $BUILD/$TOOLS_PREFIX/lib64/

# Replace all "unknown" paths
# for f in $(find $BUILD -type f -name "*unknown*"); do
# 	f_fixed=$(echo $f | sed "s@unknown@lfs@g")
# 	mv -v $f $f_fixed
# done

# mv -v $BUILD/tools/include/c++/5.2.0/{x86_64-unknown-linux-gnu,x86_64-lfs-linux-gnu}
# mv -v $BUILD/tools/libexec/gcc/{x86_64-unknown-linux-gnu,x86_64-lfs-linux-gnu}
# cp -rv $BUILD/tools/lib/gcc/x86_64-unknown-linux-gnu/* $BUILD/tools/lib/gcc/x86_64-lfs-linux-gnu/
