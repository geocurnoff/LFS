#!/bin/bash

# A helper script for entering chroot environment of LFS. Used for testing only.

chroot "$1" /tools/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='\u:\w\$ '              \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h