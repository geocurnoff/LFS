# Constructs a temporary tool chain (in current root filesystem!)

# Path of LFS source directory
LFS_SRC=$(readlink -f `dirname $0`)/../..
. $LFS_SRC/lib/die.sh
. $LFS_SRC/packages/shared/tools.cfg.sh
. $LFS_SRC/lib/prompting.sh

echo $LFS

if [ -e "/$TOOLS_PREFIX" ]; then
  # Check if it's a link
  [ -h "/$TOOLS_PREFIX" ] || die "/$TOOLS_PREFIX exists but it's not a link!"
  
  # Check if it points to the correct location
  [ "$LFS/$TOOLS_PREFIX" == $(readlink -f "/$TOOLS_PREFIX") ] \
  && echo "Reusing existing link to tools..." \
  || die "/$TOOLS_PREFIX already exists, but it's pointing to wrong location!"
else
  ln -s $LFS/$TOOLS_PREFIX /$TOOLS_PREFIX || die
fi

# Create LFS and tools directories
mkdir -pv $LFS/$TOOLS_PREFIX || die
 
env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
PATH=$PATH \
/bin/bash -c "$LFS_SRC/groups/group-invoke.sh $LFS_SRC/groups/tools-install.group" || die

rm /$TOOLS_PREFIX
