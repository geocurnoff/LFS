
mkdir -pv $CACHE

get-file "http://ftp.gnu.org/gnu/binutils/binutils-2.25.1.tar.bz2" $CACHE/binutils-2.25.1.tar.bz2 \
          || die "Fetching sources for package $NAME failed."
