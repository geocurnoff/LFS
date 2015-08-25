
rm -rvf $SRC &> /dev/null
rm -rvf $SCRATCH &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"

popd



