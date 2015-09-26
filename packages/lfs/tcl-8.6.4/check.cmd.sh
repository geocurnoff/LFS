. $LFS_SRC/tools.cfg.sh

cd $SRC/*/unix || die

TZ=UTC make -k test
