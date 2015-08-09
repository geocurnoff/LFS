
rm *.tar.* &> /dev/null

wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz || die "Fetching sources for package $NAME failed."