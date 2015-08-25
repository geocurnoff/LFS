
if [ $TARGET = "initsys/libstd++" ]; then 
	die "Command $COMMAND does not support target $TARGET."
fi

pushd $SCRATCH || die "Scratch directory doesn't exist. Forgot to build?"

ulimit -s 32768

make -k check # TODO: make sure I don't get runtest not found error

$SRC/gcc-4.9.2/contrib/test_summary

popd