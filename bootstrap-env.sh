#!/bin/bash

# Run script in initsys environment

# Configuration

. bootstrap.cfg.sh

CMD=$@

exec env -i \
HOME=$HOME \
TERM=$TERM PS1='\u:\w\$ ' \
ARCHITECTURE=$ARCHITECTURE \
LFS=$LFS \
TOOLS=$TOOLS \
ROOT=$ROOT \
FORCE=$FORCE \
LC_ALL=$LC_ALL \
LFS_TGT=$LFS_TGT \
PATH=$PATH \
USE_CACHED=$USE_CACHED \
/bin/bash -c "umask 022; set +h; $CMD" 
