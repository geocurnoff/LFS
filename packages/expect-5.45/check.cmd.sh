. $LFS_SRC/tools.cfg.sh

cd $SRC/*/ || die

TZ=UTC make -k test
