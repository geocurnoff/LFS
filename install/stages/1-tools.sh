# Constructs a temporary tool chain (in current root filesystem!)

# Input: expect LFS environment variable

# Path of LFS source directory
LFS_SRC=$(readlink -f `dirname $0`)/../..

#echo ../../$LFS_SRC
# echo $(readlink -f $LFS_SRC/../..)
# exit 0

# Helper functions
. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

# Configuration
. $LFS_SRC/packages/shared/tools.cfg.sh

printf_color light-red "Linking /$TOOLS_PREFIX to $LFS/$TOOLS_PREFIX\n"

if [ -e /$TOOLS_PREFIX ]; then
	die "File already exists: \"/$TOOLS_PREFIX\"!"
fi

mkdir -pv $LFS/$TOOLS_PREFIX && \
sudo ln -s $LFS/$TOOLS_PREFIX /$TOOLS_PREFIX || die

env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
PATH=$PATH \
FORCE=1 \
/bin/bash -c "$LFS_SRC/group-invoke.sh $LFS_SRC/groups/tools.group" || die

rm /$TOOLS_PREFIX

# exit 0

# if (( $STRIP==1 )); then
#     strip --strip-debug $TOOLS/lib/*
#     /usr/bin/strip --strip-unneeded $TOOLS/{,s}bin/*
#     rm -rf $TOOLS/{,share}/{info,man,doc}
# fi

# sudo chown -R root:root $ROOT/$TOOLS_PREFIX

