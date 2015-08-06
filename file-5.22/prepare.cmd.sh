
rm -rf $SRC &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../file-5.22.tar.gz || die "Unpacking $NAME sources failed. Forgot to fetch?"

popd



