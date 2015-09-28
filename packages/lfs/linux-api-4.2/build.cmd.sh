
. $SHARED/tools.cfg.sh

cd $SRC/*/ || die

make mrproper

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD/$TOOLS

make INSTALL_HDR_PATH=$BUILD/$TOOLS headers_install

