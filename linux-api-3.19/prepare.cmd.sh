
rm -rf $SRC &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"

popd



