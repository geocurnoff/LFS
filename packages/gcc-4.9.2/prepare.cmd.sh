
case "$TARGET" in
    initsys/1)
        . initsys-prepare.sh
        ;; 
    initsys/2)
        . initsys-prepare.sh
        ;;
    initsys/libstd++)
        . normal-prepare.sh
        ;;
    DEFAULT)
        . normal-prepare.sh
        ;;
    *)
        die "Unrecognized target $TARGET!"
esac