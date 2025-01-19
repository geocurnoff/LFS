
mkdir -pv $CACHE

get-file https://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz $CACHE/gcc-14.2.0.tar.xz || die "Fetching sources for package $NAME failed."
