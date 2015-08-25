
pushd $SRC/*/ || die

make clean

make -f Makefile-libbz2_so || die "Building $NAME failed."

make clean

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD
mkdir -v -p $BUILD/usr

# Install to fake root
make PREFIX=$BUILD/usr install || die

popd
