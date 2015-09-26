
case "$TARGET" in
    initsys?(/)*)
        . initsys-build.sh
        ;;
    *)
        . normal-build.sh
esac