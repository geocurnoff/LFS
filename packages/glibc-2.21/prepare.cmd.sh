
if [ "$TARGET" = "initsys" ]; then
    . initsys-prepare.sh
else
    . normal-prepare.sh
fi
