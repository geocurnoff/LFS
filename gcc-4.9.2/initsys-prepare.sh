
. normal-prepare.sh

pushd $SRC

MPFR_TAR=../mpfr-3.1.2.tar.xz
MPC_TAR=../mpc-1.0.2.tar.gz
GMP_TAR=../gmp-6.0.0a.tar.xz

[ -f $MPFR_TAR ] && [ -f $MPC_TAR ] && [ -f $GMP_TAR ] || die "Mising required tars. Forgot to fetch?"

for t in $MPFR_TAR $MPC_TAR $GMP_TAR; do
    tar -xvf $t || die "Unpacking $NAME sources failed.($t)"
done

GCC_DIR=gcc-4.9.2

# move dependencies into gcc's dir, 
mv -v mpfr-* $GCC_DIR/mpfr
mv -v mpc-*  $GCC_DIR/mpc
mv -v gmp-*  $GCC_DIR/gmp

# fix paths
for file in \
 $(find $GCC_DIR/gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

# manually enable stack protection
sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' $GCC_DIR/gcc/configure

popd
