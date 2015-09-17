if [[ $TARGET == initsys?(/)* ]]; then
  . $LFS_SRC/tools.cfg.sh
fi

cd $SRC/*/

make tests