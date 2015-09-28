. $SHARED/tools.cfg.sh

get-file http://www.mpfr.org/mpfr-3.1.3/mpfr-3.1.3.tar.xz $CACHE/mpfr-3.1.3.tar.xz && \
get-file http://www.multiprecision.org/mpc/download/mpc-1.0.3.tar.gz $CACHE/mpc-1.0.3.tar.gz && \
get-file http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz $CACHE/gmp-6.0.0a.tar.xz || die "Fetching sources for package $NAME failed."
