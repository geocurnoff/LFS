
mkdir -pv $CACHE

get-file http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz $CACHE/mpfr-3.1.2.tar.xz $USE_CACHED && \

get-file http://www.linuxfromscratch.org/patches/lfs/7.7/mpfr-3.1.2-upstream_fixes-3.patch $CACHE/mpfr-3.1.2-upstream_fixes-3.patch $USE_CACHED || die "Fetching patch for $NAME failed."
