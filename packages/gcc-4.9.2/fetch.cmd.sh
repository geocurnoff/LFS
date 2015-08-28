
rm -rf $CACHE

mkdir -pv $CACHE

cd $CACHE &> /dev/null

if [ "$TARGET" = "DEFAULT" ]; then
    . $PKGDIR/normal-fetch.sh
else
    . $PKGDIR/initsys-fetch.sh
fi