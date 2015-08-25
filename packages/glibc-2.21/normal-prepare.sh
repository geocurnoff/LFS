
rm -rfv $SRC &> /dev/null
rm -rfv $SCRATCH &> /dev/null

mkdir -p $SRC

pushd $SRC

GLIB_TAR=../glibc-2.21.tar.xz

[ -f $GLIB_TAR ] || die "Mising required tar. Forgot to fetch?"

tar -xvf $GLIB_TAR || die "Unpacking $NAME sources failed."

popd
