
# Run script in initsys environment

set +h
umask 022

BOOTSTRAP=1

. ./config.sh

CMD=$1

shift

$CMD $@
