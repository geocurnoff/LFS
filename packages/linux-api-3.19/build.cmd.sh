
pushd $SRC/*/ || die

make mrproper

# Reset fake root directory
rm -rf $BUILD &> /dev/null
mkdir -v -p $BUILD

make INSTALL_HDR_PATH=$BUILD headers_install

popd