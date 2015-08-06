
rm *.tar.* &> /dev/null

wget http://ftp.gnu.org/gnu/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2 || die "Fetching sources for package $NAME failed."