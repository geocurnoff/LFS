
mkdir -pv $CACHE

get-file "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz" $CACHE/bzip2-1.0.6.tar.gz $USE_CACHED || die "Fetching sources for package $NAME failed."