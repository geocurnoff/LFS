
case "$TARGET" in
    initsys/1)
		. initsys-1-build.sh
        ;;
    initsys/2)
		. initsys-2-build.sh
		;;
    DEFAULT)
        . normal-build.sh
        ;;
    *)
        die "Unrecognized target $TARGET!"
esac
