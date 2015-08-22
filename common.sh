
die() {  printf %s "${@+$@$'\n'}" 1>&2 ; exit 1; }

using() {
	for u in $USE; do
		[ $u = $1 ] && return 0
	done
}

dir_exists_in() {
	pushd "$2" &> /dev/null
	for pkg in ./*/
	do
		[ "$1" = $(basename $pkg) ] && popd &> /dev/null && return 0
	done
	popd &> /dev/null && return 1
}
