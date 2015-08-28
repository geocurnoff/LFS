
if [ "$TARGET" = "initsys/1" ]; then
    . initsys-prepare.sh
else
    . normal-prepare.sh
fi
