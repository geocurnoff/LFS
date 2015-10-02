
cd $SRC/*/ || die

make mrproper

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD/$TOOLS

make INSTALL_HDR_PATH=$BUILD headers_install
find $BUILD/include \( -name .install -o -name ..install.cmd \) -delete