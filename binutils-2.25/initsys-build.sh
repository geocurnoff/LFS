
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

pushd $SCRATCH || die

$SRC/*/configure           \
--prefix=$TOOLS            \
--with-sysroot=$LFS        \
--with-lib-path=$TOOLS/lib \
--target=$LFS_TGT          \
--disable-nls              \
--disable-werror

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD$TOOLS

case $ARCHITECTURE in
  x86_64) mkdir -v $BUILD$TOOLS/lib && ln -sv lib $BUILD$TOOLS/lib64 ;;
esac

make || die "Building $NAME failed."

# Install to fake root
make DESTDIR="$BUILD$TOOLS" install || die

popd