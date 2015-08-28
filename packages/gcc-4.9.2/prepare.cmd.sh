
if [ $TARGET = "initsys/1" ] || [ $TARGET = "initsys/2" ]; then
    . initsys-prepare.sh
else
    . normal-prepare.sh
fi
