
ARCHITECTURE="${ARCHITECTURE:-$(uname -m)}"

# Installation root
ROOT="${ROOT:-/}"

# Allow overwriting files in installation root
FORCE="${FORCE:-0}"

LC_ALL=POSIX; export LC_ALL

# NOTE: PATH is left unchanged, and will use HOST tools here, unless overridden. 
# It's overridden during installation to include LFS tools.
