
# Helper script to parse package target

parse-target() {
	echo $1 | sed -ne 's@^[^[:space:]/]*/\([^[:space:]]*\)@\1@p'
}