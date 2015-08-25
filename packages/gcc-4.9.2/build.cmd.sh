
if [ "$TARGET" = "initsys/1" ] || [ "$TARGET" = "initsys/2" ]; then
    . initsys-build.sh
elif [ $TARGET = "initsys/libstd++" ]; then
    . initsys-libstd++-build.sh
else
    . normal-build.sh
fi
