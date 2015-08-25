
rm -rf $SRC &> /dev/null

mkdir -p $SRC

pushd $SRC

tar -xvf ../*.tar.gz || die "Unpacking $NAME sources failed. Forgot to fetch?"

pushd ./*/

patch -Np1 -i ../../bzip2-1.0.6-install_docs-1.patch

popd

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' ./*/Makefile

sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" ./*/Makefile

popd



