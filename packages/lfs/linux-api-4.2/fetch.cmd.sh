
mkdir -pv $CACHE

get-file https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.2.tar.xz $CACHE/linux-4.2.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
