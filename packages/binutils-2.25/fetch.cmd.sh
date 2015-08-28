
rm *.tar.* &> /dev/null

mkdir -pv $CACHE

pushd $CACHE &> /dev/null

wget http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.bz2 || die "Fetching sources for package $NAME failed."

popd &> /dev/null