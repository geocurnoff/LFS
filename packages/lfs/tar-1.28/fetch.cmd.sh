
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/tar/tar-1.28.tar.xz $CACHE/tar-1.28.tar.xz || die "Fetching sources for package $NAME failed."

