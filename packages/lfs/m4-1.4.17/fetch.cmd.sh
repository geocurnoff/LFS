
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz $CACHE/m4-1.4.17.tar.xz || die "Fetching sources for package $NAME failed."

