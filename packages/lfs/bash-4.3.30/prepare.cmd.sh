
rm -rf $SRC &> /dev/null

mkdir -pv $SRC die "fail"

cd $SRC

tar -xvf $CACHE/*.tar.gz
