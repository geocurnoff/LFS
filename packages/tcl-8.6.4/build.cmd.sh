. $LFS_SRC/tools.cfg.sh

cd $SRC/*/unix || die

./configure --host=$LFS_TGT --prefix=$TOOLS || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD
mkdir -v -p $BUILD/lib

# Install to fake root
make DESTDIR=$BUILD install || die

chmod -v u+w $BUILD$TOOLS/lib/libtcl8.6.so

make DESTDIR=$BUILD$TOOLS install-private-headers

ln -sv tclsh8.6 $BUILD$TOOLS/bin/tclsh
