
rm -rf $SRC &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../zlib-1.2.8.tar.xz || die "Unpacking $NAME sources failed. Forgot to fetch?"

popd



