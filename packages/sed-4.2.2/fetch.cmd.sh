
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/sed/sed-4.2.2.tar.bz2 $CACHE/sed-4.2.2.tar.bz2 $USE_CACHED || die "Fetching sources for package $NAME failed."

