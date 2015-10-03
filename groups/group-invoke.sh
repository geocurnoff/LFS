#!/bin/bash

LFS_SRC=$(readlink -f `dirname $0`)"/.."
. $LFS_SRC/lib/die.sh
. $LFS_SRC/lib/success.sh

FAIL_MSG="Group $(basename $1) failed!"
SUCCESS_MSG="Group $(basename $1) finished."

status=0
while (( ! $status )); do
	read p
	status=$?
	[ "$p" ] || continue
	bash $LFS_SRC/packages/package-invoke.sh $p || die "$FAIL_MSG"
done < $1 || die "$FAIL_MSG"

success "$SUCCESS_MSG"