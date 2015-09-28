
. $SHARED/tools.cfg.sh

mkdir -pv $CACHE

get-file http://ftp.gnu.org/gnu/bash/bash-4.3.30.tar.gz $CACHE/bash-4.3.30.tar.gz a27b3ee9be83bd3ba448c0ff52b28447 || die "Fetching sources for package $NAME failed."
