
. $LFS_SRC/lib/dir-install.sh
. $LFS_SRC/lib/die.sh

[ $ROOT ] || die "ROOT is not set!"
[ $BUILD ] || die "BUILD=\"$BUILD\" - directory doesn't exist!"

if [ -f $PKGDIR/pre-install.hook.sh ]; then
	echo "Executing $PKGDIR/pre-install.hook.sh"
    . $PKGDIR/pre-install.hook.sh
fi

SAFE_NAME='~'$(echo $TARGET | sed s@/@-@g)".installed"

echo "Writing install list to $SAFE_NAME"
echo ""

dir-install $BUILD $ROOT $SAFE_NAME

# echo "
# Following files were installed:
# "
# cat $SAFE_NAME || die
# echo ""

if [ -f $PKGDIR/post-install.hook.sh ]; then
	echo "Executing $PKGDIR/post-install.hook.sh"
    . $PKGDIR/post-install.hook.sh
fi
