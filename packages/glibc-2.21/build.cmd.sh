
if [ "$TARGET" = "initsys" ]; then
    . initsys-build.sh
else
    . normal-build.sh
fi