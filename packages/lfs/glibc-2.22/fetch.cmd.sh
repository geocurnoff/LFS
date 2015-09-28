
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/glibc/glibc-2.22.tar.xz $CACHE/glibc-2.22.tar.xz && \
get-file http://www.linuxfromscratch.org/patches/lfs/7.8-rc1/glibc-2.22-fhs-1.patch $CACHE/glibc-2.22-fhs-1.patch && \
get-file http://www.linuxfromscratch.org/patches/lfs/7.8-rc1/glibc-2.22-upstream_i386_fix-1.patch $CACHE/glibc-2.22-upstream_i386_fix-1.patch \
|| die "Fetching sources for package $NAME failed."