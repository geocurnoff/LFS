
. $LFS_SRC/lib/dir-install.sh
. $LFS_SRC/lib/die.sh

[ $ROOT ] || die "INSTALL is not set!"
[ $BUILD ] || die "BUILD=\"$BUILD\" - directory doesn't exist!"

if [ -f $PKGDIR/pre-install.hook.sh ]; then
    . $PKGDIR/pre-install.hook.sh
fi

SAFE_NAME='~'$(echo $TARGET | sed s@/@-@g)".installed"

echo "Writing install list to $SAFE_NAME"

dir-install $BUILD $ROOT $SAFE_NAME

echo "
Following files were installed:
"
cat $SAFE_NAME
echo ""

echo $PKGDIR/post-install.hook.sh

if [ -f $PKGDIR/post-install.hook.sh ]; then
    . $PKGDIR/post-install.hook.sh
fi
