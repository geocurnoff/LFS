if [[ $TARGET == initsys?(/)* ]]; then
   die "Command $COMMAND does not support target $TARGET."
fi

cd $SRC/*/ || die

make check
