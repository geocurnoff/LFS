get-file https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz $CACHE/mpfr-4.2.1.tar.xz && \
get-file https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz $CACHE/mpc-1.3.1.tar.gz && \
get-file https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz $CACHE/gmp-6.3.0.tar.xz || die "Fetching sources for package $NAME failed."
