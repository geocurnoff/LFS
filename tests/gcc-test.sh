shopt -s extglob

# Post install sanity check

case "$TARGET" in
    initsys/1?(/)*)
		CC=$LFS_TGT-gcc
        ;;
    initsys/2?(/)*)
		CC=$LFS_TGT-gcc
		;;
    *)
        CC=cc
esac

pushd $SCRATCH

echo 'int main(){return 0;}' > dummy.c 
cat dummy.c
$CC dummy.c -v -Wl,--verbose 2>&1 | tee dummy.log

printf "\n*** IMPORTANT ***\n\n"
echo "Referenced program interpreter: "$(readelf -l a.out | grep ': /lib' | sed -n  's/\s*\[.*:\s*\([0-9a-zA-Z/.-]*\)\s*\]\s*/\1/p')
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
grep -B4 '^ /usr/include' dummy.log
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log
./a.out
read
rm -v dummy.c a.out dummy.log

popd
