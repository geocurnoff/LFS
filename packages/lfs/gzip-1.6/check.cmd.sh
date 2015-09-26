if [[ $TARGET == initsys?(/)* ]]; then
  . $LFS_SRC/tools.cfg.sh
fi

cd $SRC/*/ || die

# TODO: Two tests here fail under initsys

make check
