
rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.gz || die "Unpacking $NAME sources failed. Forgot to fetch?"

cd ./*/

patch -Np1 -i $CACHE/bzip2-1.0.6-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Make CC, AR and RANLIB replaceable
sed -i -e "s@CC=@CC?=@" -e "s@AR=@AR?=@" -e "s@RANLIB=@RANLIB?=@" Makefile


