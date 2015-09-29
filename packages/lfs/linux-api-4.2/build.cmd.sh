
cd $SRC/*/ || die

make mrproper

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD/$TOOLS
success $TOOLS
make INSTALL_HDR_PATH=$BUILD/$TOOLS headers_install

