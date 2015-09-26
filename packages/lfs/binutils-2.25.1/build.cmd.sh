
case "$TARGET" in
    initsys/1?(/)*)
		. initsys-1-build.sh
        ;;
    initsys/2?(/)*)
		. initsys-2-build.sh
		;;
    *)
        . normal-build.sh
esac
