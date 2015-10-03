#!/bin/bash

LFS_SRC=$(readlink -f `dirname $0`)
. $LFS_SRC/lib/die.sh

if [[ $EUID -ne 0 ]]; then
	die "Must be ran as root!"
fi

umount $1/dev/pts/            && \
umount $1/dev                 && \
umount $1/proc                && \
umount $1/sys                 && \
umount $1/run                 && \
rm $1/dev/console             && \
rm $1/dev/null                && \
rm -r $1/{dev,proc,sys,run}