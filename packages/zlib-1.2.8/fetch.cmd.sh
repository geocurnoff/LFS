
rm *.tar.* &> /dev/null

wget http://www.zlib.net/zlib-1.2.8.tar.xz || die "Fetching sources for package $NAME failed."