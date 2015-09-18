
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/patch/patch-2.7.5.tar.xz $CACHE/patch-2.7.5.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."

