
. $SHARED/common.cfg.sh

# Installation root
ROOT="${ROOT:-/}"

# Allow overwriting files in installation root
FORCE="${FORCE:-0}"

LC_ALL=POSIX; export LC_ALL

if [ -e $TOOLS/bin ]; then
	PATH=$PATH:$TOOLS/bin; export PATH
fi
