
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gawk/gawk-4.1.3.tar.xz $CACHE/gawk-4.1.3.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
