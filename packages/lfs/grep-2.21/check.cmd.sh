if [[ $TARGET == initsys?(/)* ]]; then
  . $SHARED/tools.cfg.sh
fi

cd $SRC/*/ || die

make check
