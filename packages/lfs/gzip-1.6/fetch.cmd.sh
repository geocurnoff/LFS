
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gzip/gzip-1.6.tar.xz $CACHE/gzip-1.6.tar.xz || die "Fetching sources for package $NAME failed."

