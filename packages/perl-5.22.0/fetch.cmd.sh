
mkdir -pv $CACHE

get-file http://www.cpan.org/src/5.0/perl-5.22.0.tar.bz2 $CACHE/perl-5.22.0.tar.bz2 $USE_CACHED || die "Fetching sources for package $NAME failed."

