LFS_SRC=$(readlink -f `dirname $0`)/..
SCRIPT_DIR=$(readlink -f `dirname $0`)

. $LFS_SRC/lib/printf-color.sh
. $LFS_SRC/lib/die.sh

# Clear last slash(aesthetics)
LFS=$(echo $1 | sed 's@/*$@@')

for i in $SCRIPT_DIR/stages/{1,2,3a,3b,4,5}*.sh; do
	
	printf_color light-red "Running $(basename $i)\n"

	# Stages suffixed with "chroot" are ran under chroot with environment defined by var
	if echo $i | grep "chroot"; then
		VAR_FILE=$(echo $i | sed -n 's@\(..*\)\.sh@\1.vars@p')

		CMD="$(cat $i)"
		if [ -f $VAR_FILE ]; then
			ARGS="$(cat $VAR_FILE)"
			# Evaluate argument string in current environment
			ARGS="$(SCRIPT_DIR=$SCRIPT_DIR \
				    bash -c "echo \"$ARGS\"")"
		fi
		chroot "$LFS" /tools/bin/env -i $ARGS /tools/bin/bash -c "$CMD" || die
	else
		LFS=$LFS bash $i || die
	fi
done