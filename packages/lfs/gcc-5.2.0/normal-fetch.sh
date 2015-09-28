
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2 $CACHE/gcc-5.2.0.tar.bz2 || die "Fetching sources for package $NAME failed."
