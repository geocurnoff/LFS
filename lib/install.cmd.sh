
. $LFS_SRC/lib/dir-install.sh
. $LFS_SRC/lib/die.sh

[ $ROOT ] || die "INSTALL is not set!"
[ $BUILD ] || die "BUILD=\"$BUILD\" - directory doesn't exist!"

if [ -f $PKGDIR/pre-install.hook.sh ]; then
	. $PKGDIR/pre-install.hook.sh
fi

dir-install $BUILD $ROOT '~INSTALLED_FILES'

echo $PKGDIR/post-install.hook.sh

if [ -f $PKGDIR/post-install.hook.sh ]; then
	. $PKGDIR/post-install.hook.sh
fi

