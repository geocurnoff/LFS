
mkdir -pv $CACHE

get-file URL $CACHE/FILENAME $USE_CACHED \
get-file URL $CACHE/FILENAME $USE_CACHED \
get-file URL $CACHE/FILENAME $USE_CACHED || die "Fetching sources for package $NAME failed."

get-file URL $CACHE/FILENAME $USE_CACHED || die "Fetching sources for package $NAME failed."
