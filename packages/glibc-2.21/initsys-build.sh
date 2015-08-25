
# NOTE: Requires binutils in /tools

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

pushd $SCRATCH > /dev/null || die

$SRC/glibc-2.21/configure                         \
    --prefix=$TOOLS                               \
    --host=$LFS_TGT                               \
    --build=$(../glibc-2.21/scripts/config.guess) \
    --disable-profile                             \
    --enable-kernel=2.6.32                        \
    --with-headers=$TOOLS/include                 \
    libc_cv_forced_unwind=yes                     \
    libc_cv_ctors_header=yes                      \
    libc_cv_c_cleanup=yes || die "Configuring $NAME failed."

make -j2 || die "Building $NAME failed."

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

# Install to fake root
make DESTDIR=$BUILD install

popd > /dev/null