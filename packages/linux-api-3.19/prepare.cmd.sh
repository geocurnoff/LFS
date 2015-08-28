[ "$TARGET" = "initsys" ] || [ "$TARGET" = "DEFAULT" ] || die "Package $NAME doesn't support $TARGET target!"

rm -rf $SRC &> /dev/null

mkdir -p $SRC

cd $SRC

tar -xvf $CACHE/*.tar.* || die "Unpacking $NAME sources failed. Forgot to fetch?"
