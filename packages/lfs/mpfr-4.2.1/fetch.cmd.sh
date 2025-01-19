
mkdir -pv $CACHE

get-file https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz $CACHE/mpfr-4.2.1.tar.xz || die "Fetching patch for $NAME failed."
