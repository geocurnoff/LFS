
mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/gettext/gettext-0.19.5.1.tar.xz $CACHE/gettext-0.19.5.1.tar.xz || die "Fetching sources for package $NAME failed."
