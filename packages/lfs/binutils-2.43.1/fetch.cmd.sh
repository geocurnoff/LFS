
mkdir -pv $CACHE

get-file "https://sourceware.org/pub/binutils/releases/binutils-2.43.1.tar.xz" $CACHE/binutils-2.43.1.tar.xz \
          || die "Fetching sources for package $NAME failed."
