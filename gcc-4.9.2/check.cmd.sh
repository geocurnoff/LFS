
pushd $SCRATCH || die

ulimit -s 32768

make -k check # TODO: make sure I don't get runtest not found error

$SRC/gcc-4.9.2/contrib/test_summary

popd