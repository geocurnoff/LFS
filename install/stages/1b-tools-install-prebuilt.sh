# Installs pre-built tools into path specified by $LFS (alternative for 1a-tools-build)

LFS_SRC=$(readlink -f `dirname $0`)/../..

mkdir -pv $LFS/$TOOLS_PREFIX

env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
PATH=$PATH \
FORCE=1 \
ROOT=$LFS \
/bin/bash -c "$LFS_SRC/groups/group-invoke.sh $LFS_SRC/groups/tools-install-prebuilt.group" || exit 1

