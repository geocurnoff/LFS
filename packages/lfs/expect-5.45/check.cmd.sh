
cd $SRC/*/ || die

TZ=UTC make -k test
