
cd $SRC/*/ || die

# Use /bin/stty instead of a /usr/local/bin/stty
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=$TOOLS                  \
            --with-tcl=$TOOLS/lib            \
            --with-tclinclude=$TOOLS/include || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD
mkdir -v -p $BUILD/lib

# Install to fake root
make SCRIPTS="" DESTDIR=$BUILD install || die

# Remove empty lib
rm -rf $BUILD/lib