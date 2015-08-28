
# if [ "$TARGET" = "initsys/1" ] || [ "$TARGET" = "initsys/2" ]; then
#     . initsys-build.sh
# elif [ $TARGET = "initsys/libstd++" ]; then
#     . initsys-libstd++-build.sh
# else
#     . normal-build.sh
# fi

case "$TARGET" in
    initsys/1)
        . initsys-build.sh
        ;; 
    initsys/2)
        . initsys-build.sh
        ;;
    initsys/libstd++)
        . initsys-libstd++-build.sh
        ;;
    DEFAULT)
        . normal-build.sh
        ;;
    *)
        die "Unrecognized target $TARGET!"
esac