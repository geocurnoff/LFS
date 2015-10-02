#!/bin/bash

LFS_SRC=$(readlink -f `dirname $0`)
. $LFS_SRC/lib/die.sh
. $LFS_SRC/lib/success.sh

status=0
while (( ! $status )); do
	read p
	status=$?
	[ "$p" ] || continue
	bash $LFS_SRC/pkg.sh $p || die 
done < $1

success "Group $1 finished."