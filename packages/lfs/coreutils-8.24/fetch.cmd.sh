
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/coreutils/coreutils-8.24.tar.xz $CACHE/coreutils-8.24.tar.xz $USE_CACHED || die "Fetching sources for package $NAME failed."

get-file http://www.linuxfromscratch.org/patches/lfs/7.8-rc1/coreutils-8.24-i18n-1.patch $CACHE/coreutils-8.24-i18n-1.patch $USE_CACHED || die "Fetching sources for package $NAME failed."

