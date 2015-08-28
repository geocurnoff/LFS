
. normal-prepare.sh

cd $SRC/*/

# 
#                 ╔═══ what to replace with(4)
#replace(2) ══╗   ║
#             ║   ║
#             ║   ║          
sed -e '/ia32/s/^/1:/' -e '/SSE2/s/^1://' -i sysdeps/i386/i686/multiarch/mempcpy_chk.S
#         ║     ║
#         ║     ╙───── beginning of the line(3)
#      pattern
#    identifying 
#     the line (1)

