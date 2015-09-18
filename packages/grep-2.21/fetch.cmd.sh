
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/grep/grep-2.21.tar.xz $CACHE/grep-2.21.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."

