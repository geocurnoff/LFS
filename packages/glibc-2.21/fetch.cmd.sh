[ "$TARGET" = "initsys" ] || [ "$TARGET" = "DEFAULT" ] || die "Package $NAME doesn't support $TARGET target!"

mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/glibc/glibc-2.21.tar.xz $CACHE/glibc-2.21.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."