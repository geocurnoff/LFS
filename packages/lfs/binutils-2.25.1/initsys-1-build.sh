success $ROOT
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH || die

$SRC/*/configure           \
--prefix=$TOOLS            \
--with-sysroot=$LFS        \
--with-lib-path=$TOOLS/lib \
--target=$LFS_TGT          \
--disable-nls              \
--disable-werror

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

case $ARCHITECTURE in
  x86_64) mkdir -v $BUILD/$TOOLS_PREFIX/lib && ln -sv lib $BUILD/$TOOLS_PREFIX/lib64 ;;
esac

make || die "Building $NAME failed."

# Install to fake root
make DESTDIR="$BUILD" install || die

# FIX: for "file no found" errors when running any executable
# mkdir -pv ./tools/lib64/
# pushd ./tools/lib64/
# ln -s ../bin/x86_64-lfs-linux-gnu-ld ld-linux-x86-64.so.2
# popd
