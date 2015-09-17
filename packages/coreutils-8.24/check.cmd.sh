if [[ $TARGET == initsys?(/)* ]]; then
  . $LFS_SRC/tools.cfg.sh
fi

cd $SRC/*/ || die

# TODO: Two tests here fail under initsys

make RUN_EXPENSIVE_TESTS=yes check
