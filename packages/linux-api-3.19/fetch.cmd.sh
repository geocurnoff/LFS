[ "$TARGET" = "initsys" ] || [ "$TARGET" = "DEFAULT" ] || die "Package $NAME doesn't support $TARGET target!"

mkdir -pv $CACHE

get-file https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.19.tar.xz $CACHE/linux-3.19.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."
