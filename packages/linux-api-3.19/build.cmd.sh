
[ "$TARGET" = "initsys" ] || [ "$TARGET" = "DEFAULT" ] || die "Package $NAME doesn't support $TARGET target!"

cd $SRC/*/ || die

make mrproper

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD/tools

make INSTALL_HDR_PATH=$BUILD/tools headers_install

