
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"

cd ./*/

patch -Np1 -i $PKGDIR/mpfr-3.1.2-upstream_fixes-3.patch
