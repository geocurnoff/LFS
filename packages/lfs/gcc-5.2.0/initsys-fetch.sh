. $LFS_SRC/tools.cfg.sh

get-file http://www.mpfr.org/mpfr-3.1.3/mpfr-3.1.3.tar.xz $CACHE/mpfr-3.1.3.tar.xz $USE_CACHED && \

get-file http://www.multiprecision.org/mpc/download/mpc-1.0.3.tar.gz $CACHE/mpc-1.0.3.tar.gz $USE_CACHED && \

get-file http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz $CACHE/gmp-6.0.0a.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
