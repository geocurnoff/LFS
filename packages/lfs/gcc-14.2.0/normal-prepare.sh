
rm -rfv $SRC &> /dev/null
rm -rfv $SCRATCH &> /dev/null

mkdir -pv $SRC

cd $SRC

GCC_TAR=$CACHE/gcc-*.tar.xz

[ -f $GCC_TAR ] || die "Mising required tar. Forgot to fetch?"
tar -xvf $GCC_TAR || die "Unpacking $NAME sources failed."
