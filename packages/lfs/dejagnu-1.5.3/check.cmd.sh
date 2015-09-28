. $SHARED/tools.cfg.sh

cd $SRC/*/ || die

TZ=UTC make -k check
