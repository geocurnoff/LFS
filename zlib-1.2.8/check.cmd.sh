
pushd $SRC/*/ || die

make -k check

popd