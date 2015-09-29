
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu//ncurses/ncurses-6.0.tar.gz $CACHE/ncurses-6.0.tar.gz  || die "Fetching patch for $NAME failed."
