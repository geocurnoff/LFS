
. $LFS_SRC/lib/dir-install.sh

if [ -f $PKGDIR/pre-install.hook.sh ]; then
	. $PKGDIR/pre-install.hook.sh
fi

dir-install $BUILD $INSTALL '~INSTALLED_FILES'

echo $PKGDIR/post-install.hook.sh

if [ -f $PKGDIR/post-install.hook.sh ]; then
	. $PKGDIR/post-install.hook.sh
fi

