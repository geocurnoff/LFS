
mkdir -pv $CACHE

get-file "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz" $CACHE/bzip2-1.0.6.tar.gz || die "Fetching sources for package $NAME failed."

get-file http://www.linuxfromscratch.org/patches/lfs/7.8-rc1/bzip2-1.0.6-install_docs-1.patch $CACHE/bzip2-1.0.6-install_docs-1.patch || die "Fetching sources for package $NAME failed."

