. $SHARED/tools.cfg.sh

. normal-prepare.sh

cd $SRC/*/

patch -Np1 -i $CACHE/glibc-2.22-upstream_i386_fix-1.patch
