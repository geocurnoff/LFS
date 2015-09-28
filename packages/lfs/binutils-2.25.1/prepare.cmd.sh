
rm -rvf $SRC &> /dev/null
rm -rvf $SCRATCH &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.bz2 || die "Unpacking $NAME sources failed. Forgot to fetch?"
