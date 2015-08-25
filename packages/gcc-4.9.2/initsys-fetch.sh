
rm *.tar.* &> /dev/null

wget http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz || die "Fetching sources for package $NAME failed. (mpfr)"

wget http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz || die "Fetching sources for package $NAME failed. (mpc)"

wget http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz || die "Fetching sources for package $NAME failed. (gmp)"

wget http://ftp.gnu.org/gnu/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2 || die "Fetching sources for package $NAME failed."
