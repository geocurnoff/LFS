
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH || die

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
$SRC/binutils-*/configure      \
    --prefix=$TOOLS            \
    --host=$LFS_TGT            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=$TOOLS/lib \
    --with-sysroot

# --host=$LFS_TGT  is this Okay?

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# case $ARCHITECTURE in
#   x86_64) mkdir -v $BUILD/$TOOLS_PREFIX/lib && ln -sv lib $BUILD/$TOOLS_PREFIX/lib64 ;;
# esac

make || die "Building $NAME failed."

# Install to fake root
make DESTDIR="$BUILD" install || die

# Prepare for readjust
make -C ld clean || die "ld clean failed"
make -C ld LIB_PATH=/usr/lib:/lib || die "ld build failed"
cp -v ld/ld-new $BUILD/$TOOLS_PREFIX/bin