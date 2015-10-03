
# $1 stage file
# $2 root location
run-stage() {
	# Stages suffixed with "chroot" are ran under chroot with environment defined by var
	if echo $1 | grep "chroot"; then
		VAR_FILE=$(echo $i | sed -n 's@\(..*\)\.sh@\1.vars@p')

		CMD="$(cat $i)"
		if [ -f $VAR_FILE ]; then
			ARGS="$(cat $VAR_FILE)"
			# Evaluate argument string in current environment
			ARGS="$(SCRIPT_DIR=$SCRIPT_DIR \
				    bash -c "echo \"$ARGS\"")"
		fi
		# TODO: there are issues with quotes and spaces, compose this line as a string and evaluate it using "bash -c <script>" for safer string handling
		chroot "$2" /tools/bin/env -i $ARGS /tools/bin/bash -c "$CMD" || return 1
	else
	# Normal stages are just scripts
		LFS=$2 bash $i || return 1
	fi
	return 0
}