
mkdir -pv $CACHE

get-file http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz $CACHE/pkg-config-0.28.tar.gz $USE_CACHED || die "Fetching sources for package $NAME failed."