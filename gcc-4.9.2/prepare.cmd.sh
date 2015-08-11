
rm -rfv $SRC &> /dev/null
rm -rfv $SCRATCH &> /dev/null

mkdir -p $SRC

pushd $SRC

[ -f ../gcc-4.9.2.tar.bz2 ] || die "Mising required tar. Forgot to fetch?"

if (( $BOOTSTRAP )); then
	[ -f ../mpfr-3.1.2.tar.xz ] && [ -f ../mpc-1.0.2.tar.gz ] && [ -f ../gmp-6.0.0a.tar.xz ] || die "Mising required tars. Forgot to fetch?"
fi

for t in ../*.tar.*; do
    tar -xvf $t || die "Unpacking $NAME sources failed."
done

if (( $BOOTSTRAP )); then
	mv -v mpfr-* gcc-4.9.2/mpfr
	mv -v mpc-* gcc-4.9.2/mpc
	mv -v gmp-* gcc-4.9.2/gmp
fi

popd



