
PREFIX=/usr
DOCDIR=/usr/share/doc/$NAME

pushd $SRC/*/ || die

./configure --prefix=$PREFIX \
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