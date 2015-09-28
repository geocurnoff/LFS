
mkdir -pv $CACHE

get-file "ftp://ftp.astron.com/pub/file/file-5.24.tar.gz" $CACHE/file-5.24.tar.gz || die "Fetching sources for package $NAME failed."
