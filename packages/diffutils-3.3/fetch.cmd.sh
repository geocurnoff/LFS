
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz $CACHE/diffutils-3.3.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
