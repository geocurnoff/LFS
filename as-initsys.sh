
# Run script in initsys environment

set +h
umask 022


SCRIPT_DIR=$(readlink -f `dirname $0`)

. $SCRIPT_DIR/config.sh

LFS=/mnt/LFS
TOOLS=/tools
LC_ALL=POSIX
LFS_TGT=$ARCHITECTURE-lfs-linux-gnu
PATH=$TOOLS/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH TOOLS

CMD=$1

shift

$CMD $@
