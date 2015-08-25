
rm *.tar.* &> /dev/null

wget ftp://ftp.astron.com/pub/file/file-5.22.tar.gz || die "Fetching sources for package $NAME failed."