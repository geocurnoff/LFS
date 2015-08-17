
. normal-prepare.sh

pushd $SRC

# sed -e '/ia32/s/^/1:/' \
#     -e '/SSE2/s/^1://' \
#     -i  sysdeps/i386/i686/multiarch/mempcpy_chk.S

popd
