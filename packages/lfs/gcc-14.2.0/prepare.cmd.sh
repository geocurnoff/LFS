
case "$TARGET" in
    initsys/1?(/)*)
        . initsys-prepare.sh
        ;; 
    initsys/2?(/)*)
        . initsys-prepare.sh
        ;;
    initsys/libstd++?(/)*)
        . normal-prepare.sh
        ;;
    *)
        . normal-prepare.sh
esac