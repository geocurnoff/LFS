. $SHARED/tools.cfg.sh

cd $SRC/*/ || die

./configure --prefix=$TOOLS --host=$LFS_TGT || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install || die
