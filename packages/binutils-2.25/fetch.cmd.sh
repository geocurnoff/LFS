
rm -rf $CACHE

mkdir -pv $CACHE

cd $CACHE &> /dev/null

wget http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.bz2 || die "Fetching sources for package $NAME failed."
