
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/file-5.22.tar.gz || die "Unpacking $NAME sources failed. Forgot to fetch?"
