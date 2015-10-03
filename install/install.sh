#!/bin/bash

# Execute installation stages

LFS_SRC=$(readlink -f `dirname $0`)/..
SCRIPT_DIR=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/printf-color.sh
. $LFS_SRC/lib/die.sh
. $LFS_SRC/lib/success.sh
. $LFS_SRC/lib/run-stage.sh

# Clear last slash(aesthetics)
LFS=$(echo $1 | sed 's@/*$@@')

for i in $SCRIPT_DIR/stages/{1a,2,3,4,5}*.sh; do
	printf_color light-red "Running $(basename $i)\n" && \
	run-stage $i $LFS && success "Stage $(basename $i) completed." || die "Stage $(basename $i) failed!"
done