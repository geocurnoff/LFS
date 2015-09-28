
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/dejagnu/dejagnu-1.5.3.tar.gz $CACHE/dejagnu-1.5.3.tar.gz || die "Fetching sources for package $NAME failed."
