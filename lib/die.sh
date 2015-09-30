
. $LFS_SRC/lib/printf-color.sh

die() {  printf_color red %s "${@+$@$'\n'}" 1>&2 ; exit 1; }

