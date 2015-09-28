if [[ $TARGET == initsys?(/)* ]]; then
  . $SHARED/tools.cfg.sh
fi

cd $SCRATCH || die

make -k check # TODO: make sure I don't get runtest not found error
