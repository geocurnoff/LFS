
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

extract_name() {
	echo $1 | sed -ne 's@\(^[^[:space:]/]*\).*@\1@p'
	# Sed demangling 
	# s - replace command, 
	# @ is delimiter 
	# \( \) - grouping
	# ^[^[:space:]/]* - match everything except whitespace and /
	# \( \).* - match the rest of the string, whatever it is 
	# @\1@ - replace matched string with the group \1
	# p - print
}

extract_target() {
	echo $1 | sed -ne 's@^[^[:space:]/]*/\([^[:space:]]*\)@\1@p'
}