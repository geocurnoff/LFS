
rm *.tar.* &> /dev/null

wget http://ftp.gnu.org/gnu/glibc/glibc-2.21.tar.xz || die "Fetching sources for package $NAME failed."