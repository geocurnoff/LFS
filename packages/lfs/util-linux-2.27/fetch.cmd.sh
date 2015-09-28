
mkdir -pv $CACHE

get-file https://www.kernel.org/pub/linux/utils/util-linux/v2.27/util-linux-2.27.tar.xz $CACHE/util-linux-2.27.tar.xz || die "Fetching sources for package $NAME failed."

