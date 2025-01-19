
mkdir -pv $CACHE

get-file https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz $CACHE/gmp-6.3.0.tar.xz || die "Fetching sources for package $NAME failed."
