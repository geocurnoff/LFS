
mkdir -pv $CACHE

get-file http://sourceforge.net/projects/check/files/check/0.10.0/check-0.10.0.tar.gz $CACHE/check-0.10.0.tar.gz || die "Fetching sources for package $NAME failed."
