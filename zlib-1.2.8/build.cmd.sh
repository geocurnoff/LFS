
pushd $SRC/*/ || die

./configure --prefix=$ROOT || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD
mkdir -v -p $BUILD/lib

# Install to fake root
make DESTDIR=$BUILD install || die

popd

# Move shared library and recreate a link
mv -v $BUILD/usr/lib/libz.so.* $BUILD/lib/
ln -sfv ../../lib/$(readlink $PKG/usr/lib/libz.so) $BUILD/usr/lib/libz.so




