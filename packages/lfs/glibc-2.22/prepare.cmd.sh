
rm -rfv $SRC &> /dev/null
rm -rfv $SCRATCH &> /dev/null

mkdir -p $SRC

cd $SRC

GLIB_TAR=$CACHE/glibc-2.22.tar.xz

[ -f $GLIB_TAR ] || die "Mising required tar. Forgot to fetch?"

tar -xvf $GLIB_TAR || die "Unpacking $NAME sources failed."

cd $SRC/glibc-*/

# /var/db fix
patch -Np1 -i $CACHE/glibc-2.22-fhs-1.patch

#  i386 problem fix
patch -Np1 -i $CACHE/glibc-2.22-upstream_i386_fix-1.patch

