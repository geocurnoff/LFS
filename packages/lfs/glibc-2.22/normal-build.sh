
# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/glibc-2.22/configure    \
    --prefix=/usr            \
    --disable-profile        \
    --enable-kernel=2.6.32   \
    --enable-obsolete-rpc || die "Configuring $NAME failed."

make || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# To supress warning during install
touch $BUILD/etc/ld.so.conf

# Install to fake root
make DESTDIR=$BUILD install || die

# C preprocessor link
mkdir -pv $BUILD/lib
ln -sv ../usr/bin/cpp $BUILD/lib

# cc alias for gcc
ln -sv gcc $BUILD/usr/bin/cc

# Symlink for LTO support
install -v -dm755 $BUILD/usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/4.9.2/liblto_plugin.so $BUILD/usr/lib/bfd-plugins/

mkdir -pv $BUILD/usr/share/gdb/auto-load/usr/lib

if [ $ARCHITECTURE = "x86" ]; then
    mv -v $BUILD/usr/lib/*gdb.py $BUILD/usr/share/gdb/auto-load/usr/lib
else
    mv -v $BUILD/usr/lib64/*gdb.py $BUILD/usr/share/gdb/auto-load/usr/lib
fi
