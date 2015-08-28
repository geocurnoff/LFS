
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2 $CACHE/gcc-4.9.2.tar.bz2 $USE_CACHED || die "Fetching sources for package $NAME failed."
