
pushd $SRC/*/ || die

$SRC/*/configure --prefix=$ROOT        \
            --with-internal-glib  \
            --disable-host-tool   \
            --docdir=$DOCDIR      \
            || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die

popd