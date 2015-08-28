
mkdir -pv $CACHE

get-file "http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.bz2 \
          http://ftp.unicamp.br/pub/gnu/binutils/binutils-2.25.tar.bz2" $CACHE/binutils-2.25.tar.bz2 $USE_CACHED \
          || die "Fetching sources for package $NAME failed."
