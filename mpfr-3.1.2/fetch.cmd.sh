
rm *.tar.* &> /dev/null

rm *.patch &> /dev/null

wget http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz || die "Fetching sources for package $NAME failed."

wget http://www.linuxfromscratch.org/patches/lfs/7.7/mpfr-3.1.2-upstream_fixes-3.patch || die "Fetching patch for $NAME failed."
