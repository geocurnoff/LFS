
# Helper script to parse package name

parse-name() {
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

