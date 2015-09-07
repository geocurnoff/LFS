
ARCHITECTURE="${ARCHITECTURE:-$(uname -m)}"

# Installation root
ROOT="${ROOT:-/}"

# Allow overwriting files in installation root
FORCE="${FORCE:-0}"

# Use cached version if available
USE_CACHED="${USE_CACHED:-1}"

echo "ARCHITECTURE: $ARCHITECTURE"
echo "ROOT: $ROOT"
echo "FORCE: $FORCE"
echo "USE_CACHED: $USE_CACHED"
echo "PATH: $PATH"