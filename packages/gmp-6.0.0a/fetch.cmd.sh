
rm *.tar.* &> /dev/null

wget http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz || die "Fetching sources for package $NAME failed."
