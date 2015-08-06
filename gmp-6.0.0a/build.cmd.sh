
pushd $SRC/*/ || die

./configure --prefix=$ROOT \
            --enable-cxx   \
            --docdir=$DOCDIR || die "Configuring $NAME failed."


make || die "Building $NAME failed."
make html || die "Building HTML documentation for $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die
make DESTDIR=$BUILD install-html || die

popd