if [[ $TARGET == initsys?(/)* ]]; then
  die "Unsupported"
fi

cd $SRC/*/ || die

make check
