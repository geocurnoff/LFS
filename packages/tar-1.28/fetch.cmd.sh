
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/texinfo/texinfo-6.0.tar.xz $CACHE/texinfo-6.0.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."

