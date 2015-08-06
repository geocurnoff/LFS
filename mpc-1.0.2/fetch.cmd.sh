
rm *.tar.* &> /dev/null

wget http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz || die "Fetching sources for package $NAME failed."
