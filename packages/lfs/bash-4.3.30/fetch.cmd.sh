
. $SHARED/tools.cfg.sh

mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/bash/bash-4.3.30.tar.gz $CACHE/bash-4.3.30.tar.gz || die "Fetching sources for package $NAME failed."
