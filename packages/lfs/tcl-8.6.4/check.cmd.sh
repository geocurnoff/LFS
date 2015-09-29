
cd $SRC/*/unix || die

TZ=UTC make -k test
