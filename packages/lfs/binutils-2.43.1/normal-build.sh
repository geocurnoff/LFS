
PREFIX=/usr
TOOLDIR=/usr

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH || die

$SRC/*/configure \
--prefix=$PREFIX   \
--enable-shared  \
--disable-werror \
|| die "Configuring $NAME failed."

make tooldir=$TOOLDIR || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make tooldir=$TOOLDIR DESTDIR=$BUILD install || die
