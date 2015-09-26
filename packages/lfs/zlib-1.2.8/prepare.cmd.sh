
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/zlib-1.2.8.tar.xz || die "Unpacking $NAME sources failed. Forgot to fetch?"


