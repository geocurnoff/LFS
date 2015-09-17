
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"

cd ./*/

patch -Np1 -i $CACHE/*.patch

sed -i '/tests\/misc\/sort.pl/ d' Makefile.in