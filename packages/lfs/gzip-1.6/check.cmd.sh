if [[ $TARGET == initsys?(/)* ]]; then
  . $SHARED/tools.cfg.sh
fi

cd $SRC/*/ || die

# TODO: Two tests here fail under initsys

make check
