# Constructs a temporary tool chain (in current root filesystem!)

# Path of LFS source directory
LFS_SRC=$(readlink -f `dirname $0`)/../..
. $LFS_SRC/lib/die.sh
. $LFS_SRC/packages/shared/tools.cfg.sh

if [ -e /$TOOLS_PREFIX ]; then
	die "File already exists: \"/$TOOLS_PREFIX\"!"
fi

mkdir -pv $LFS/$TOOLS_PREFIX && \
sudo ln -s $LFS/$TOOLS_PREFIX /$TOOLS_PREFIX || die

env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
PATH=$PATH \
/bin/bash -c "$LFS_SRC/groups/group-invoke.sh $LFS_SRC/groups/tools-install.group" || die

rm /$TOOLS_PREFIX
