
. $SHARED/tools.cfg.sh

# NOTE: Requires binutils in /tools
#       Provides ld*.so library, initsys/1 compiler will not produce working executables without it

# Don't remove this directory when rebuilding
mkdir -v -p $SCRATCH || die

cd $SCRATCH > /dev/null || die

$SRC/glibc-*/configure                            \
    --prefix=$TOOLS                               \
    --host=$LFS_TGT                               \
    --build=$($SRC/glibc-*/scripts/config.guess)  \
    --disable-profile                             \
    --enable-kernel=2.6.32                        \
    --enable-obsolete-rpc                         \
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
