
. ../common/install.sh

if [ "$TARGET" = "initsys/1" ]; then
    install $NAME/build/tools/ /tools
else
    install $BUILD/ $ROOT
    # create remove script from list of files and remove hooks
    # copy everything
    # run install hooks
fi

