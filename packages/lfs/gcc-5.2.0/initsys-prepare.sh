. normal-prepare.sh

MPFR_TAR=$CACHE/mpfr-*.xz
MPC_TAR=$CACHE/mpc-*.tar.gz
GMP_TAR=$CACHE/gmp-*.tar.xz

[ -f $MPFR_TAR ] && [ -f $MPC_TAR ] && [ -f $GMP_TAR ] || die "Mising required tars. Forgot to fetch?"

for t in $MPFR_TAR $MPC_TAR $GMP_TAR; do
    tar -xvf $t || die "Unpacking $NAME sources failed.($t)"
done

cd gcc-*

# move dependencies into gcc's dir, 
mv -v ../mpfr-* mpfr
mv -v ../mpc-*  mpc
mv -v ../gmp-*  gmp

# fix paths
for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' \
      -e 's@/lib64@/lib@g' \
      $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

# manually enable stack protection
sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure
