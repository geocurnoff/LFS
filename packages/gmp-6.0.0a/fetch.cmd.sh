
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz $CACHE/gmp-6.0.0a.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
