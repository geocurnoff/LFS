
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/make/make-4.1.tar.bz2 $CACHE/make-4.1.tar.bz2 $USE_CACHED || die "Fetching sources for package $NAME failed."

