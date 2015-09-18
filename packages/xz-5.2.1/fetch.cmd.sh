
mkdir -pv $CACHE

get-file http://tukaani.org/xz/xz-5.2.1.tar.xz $CACHE/xz-5.2.1.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."

