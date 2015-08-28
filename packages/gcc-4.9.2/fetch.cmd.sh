
case "$TARGET" in
    initsys/1 | initsys/2)
        . $PKGDIR/normal-fetch.sh
    	. $PKGDIR/initsys-fetch.sh
        ;;    
    DEFAULT | initsys/libstd++)
        . $PKGDIR/normal-fetch.sh
        ;;
    *)
    	die "Unrecognized target $TARGET!"
esac