
mkdir -pv $CACHE

get-file https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz $CACHE/mpc-1.3.1.tar.gz || die "Fetching sources for package $NAME failed."
