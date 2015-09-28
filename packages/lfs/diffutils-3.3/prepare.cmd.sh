
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.xz || die "Unpacking $NAME sources failed. Forgot to fetch?"

cd ./*/

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in