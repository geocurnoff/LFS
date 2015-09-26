
case "$TARGET" in
	initsys/1?(/)*)
        . $PKGDIR/normal-fetch.sh
        . $PKGDIR/initsys-fetch.sh
        ;;
    initsys/2?(/)*)
        . $PKGDIR/normal-fetch.sh
        . $PKGDIR/initsys-fetch.sh
        ;;
    initsys/libstd++?(/)*)
        . $PKGDIR/normal-fetch.sh
        ;;
    *)
        . $PKGDIR/normal-fetch.sh
esac