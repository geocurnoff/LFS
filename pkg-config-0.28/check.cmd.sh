
pushd $SRC/*/ || die

make check # TODO: make sure I don't get runtest not found error

popd