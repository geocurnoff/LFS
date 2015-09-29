
case "$TARGET" in
    initsys?(/)*)
		. $SHARED/tools.cfg.sh
        ;;
    *)
        . $SHARED/normal.cfg.sh
esac