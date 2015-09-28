. $SHARED/tools.cfg.sh

cd $SRC/*/

./configure --prefix=$TOOLS --host=$LFS_TGT --enable-install-program=hostname || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install