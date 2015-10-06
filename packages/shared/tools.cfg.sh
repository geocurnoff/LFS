
ARCHITECTURE="${ARCHITECTURE:-$(uname -m)}"

# Installation root
ROOT="${ROOT:-/}"

# Allow overwriting files in installation root
FORCE="${FORCE:-1}"

# Path used as prefix for temporary tools
TOOLS_PREFIX=tools

# Path to tools (convenience binding)
TOOLS=/$TOOLS_PREFIX

LFS_TGT=$(uname -m)-lfs-linux-gnu

LC_ALL=POSIX; export LC_ALL

# NOTE: Path is forced to correct value to allow building tools individually, without wrapper scripts
PATH=$TOOLS/bin:/bin:/usr/bin; export PATH

FORCE_UNSAFE_CONFIGURE=1; export FORCE_UNSAFE_CONFIGURE;
