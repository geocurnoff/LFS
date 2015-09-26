
case "$TARGET" in
    initsys?(/)*)
		. initsys-prepare.sh
        ;;
    *)
    	. normal-prepare.sh		
esac
