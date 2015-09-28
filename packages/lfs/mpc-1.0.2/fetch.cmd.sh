
mkdir -pv $CACHE

get-file http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz $CACHE/mpc-1.0.2.tar.gz || die "Fetching sources for package $NAME failed."
