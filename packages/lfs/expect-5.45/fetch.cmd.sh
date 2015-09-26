
mkdir -pv $CACHE

get-file http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz $CACHE/expect5.45.tar.gz $USE_CACHED || die "Fetching sources for package $NAME failed."
