. $LFS_SRC/tools.cfg.sh

cd $SRC/*/

./configure --prefix=/tools --host=$LFS_TGT --without-bash-malloc || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install

ln -sv bash $BUILD$TOOLS/bin/sh