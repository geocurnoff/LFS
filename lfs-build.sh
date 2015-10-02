#!/bin/bash

# Construct a basic LFS system in a given directory. Requires tools to be present in /$TOOLS_PREFIX path.

# Root path of LFS scripts and sources
LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions
. $LFS_SRC/lib/parse-name.sh

. $LFS_SRC/lib/parse-target.sh

. $LFS_SRC/lib/printf-color.sh

. $LFS_SRC/lib/die.sh

. $LFS_SRC/lib/prompting.sh

. $LFS_SRC/lib/root-environment.sh

# Configuration
. $LFS_SRC/lfs.list.sh
. $LFS_SRC/packages/shared/tools.cfg.sh

[ "$#" -lt 1 ] && die "\
USAGE: lfs-build.sh <target directory>"

LFS=$1

if [[ $EUID -ne 0 ]]; then
	die "Must be ran as root!"
fi

if [ ! -d $LFS/$TOOLS_PREFIX ]; then
	die "Tools not found in $LFS/$TOOLS_PREFIX"
fi

if [ ! -d $LFS/dev ] || [ ! -d $LFS/proc ] || [ ! -d $LFS/sys ] || [ ! -d $LFS/run ];  then
	die "Root file system doesn't appear to be ready. Run chroot-prepare.sh on it."
fi

bash $LFS_SRC/group-invoke.sh $LFS_SRC/groups/lfs-fetch.group || die

#prepare-root $LFS || die



# Build & Install LFS Packages
chroot "$LFS" env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
PATH=/bin:/usr/bin:/usr/local/bin:/tools/bin \
bash "/source/group-invoke.sh" "/source/groups/lfs.group" 

# teardown-root $LFS

# # Bind source directory
# mkdir $LFS/source
# mount --bind /source $LFS/source


# # chroot "$LFS" /usr/bin/env   -i   \
# #     HOME=/root                    \
# #     TERM="$TERM"                  \
# #     PS1='\u:\w\$ '                \
# #     TEST='abcd'                   \
# #     PATH='/tools/bin:/bin:/usr/bin:/usr/local/bin' \
# #     /usr/bin/bash +h

# # -i
# chroot "$LFS" /usr/bin/env        \
#     HOME=/root                    \
#     TERM="$TERM"                  \
#     PS1='\u:\w\$ '                \
#     PATH='/tools/bin:/bin:/usr/bin:/usr/local/bin' \
#     /usr/bin/bash +h -c "/$SOURCES_PREFIX/base-build.sh"


