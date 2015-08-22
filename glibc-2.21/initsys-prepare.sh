
. normal-prepare.sh

pushd $SRC

# 
#                 ╔═══ what to replace with(4) ════
#replace(2) ══╗   ║
#             ║   ║
#             ║   ║          
sed -e '/ia32/s/^/1:/' -e '/SSE2/s/^1://' sysdeps/i386/i686/multiarch/mempcpy_chk.S
#         ║     ║
#         ║     ╙───── beginning of the line(3) ──────
#      pattern
#    identifying 
#     the line (1)

sed -e '/pattern/s/^/1:/' 
         
popd
