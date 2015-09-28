. $SHARED/tools.cfg.sh

cd $SRC/*/ || die

./configure --host=$LFS_TGT --prefix=$TOOLS || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die
