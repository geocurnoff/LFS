
pushd $SRC/*/ || die

make check 2>&1 | tee gmp-check-log

(( $(awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log) < 188 )) && echo "Some tests failed!" 1>&2 && exit 1

popd