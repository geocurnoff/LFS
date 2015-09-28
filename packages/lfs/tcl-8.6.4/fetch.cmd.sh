
mkdir -pv $CACHE

get-file http://sourceforge.net/projects/tcl/files/Tcl/8.6.4/tcl-core8.6.4-src.tar.gz $CACHE/tcl-core8.6.4-src.tar.gz || die "Fetching sources for package $NAME failed."
