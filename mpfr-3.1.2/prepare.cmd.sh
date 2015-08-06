
rm -rf $SRC &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"

pushd ./*/

patch -Np1 -i $PKGDIR/mpfr-3.1.2-upstream_fixes-3.patch

popd

popd



