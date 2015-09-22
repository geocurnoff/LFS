
TOOLS_PACKAGES="\
binutils-2.25.1/initsys/1 \
gcc-5.2.0/initsys/1 \
linux-api-4.2 \
glibc-2.22/initsys \
gcc-5.2.0/initsys/libstd++ \
binutils-2.25.1/initsys/2 \
gcc-5.2.0/initsys/2 \
tcl-8.6.4/initsys \
expect-5.45/initsys \
dejagnu-1.5.3/initsys \
check-0.10.0/initsys \
ncurses-6.0/initsys \
bash-4.3.30/initsys \
bzip2-1.0.6/initsys \
coreutils-8.24/initsys \
diffutils-3.3/initsys \
file-5.24/initsys \
findutils-5.24/initsys \
gawk-4.1.3/initsys \
gettext-0.19.5.1/initsys \
grep-2.21/initsys \
gzip-1.6/initsys \
m4-1.4.17/initsys \
make-4.1/initsys \
patch-2.7.5/initsys \
perl-5.22.0/initsys \
sed-4.2.2/initsys \
tar-1.28/initsys \
textinfo-6.0/initsys \
util-linux-2.27/initsys \
xz-5.2.1/initsys"

COMMANDS="clear fetch prepare build install"

# Path used as prefix for temporary tools
TOOLS_PREFIX=tools

# Path to tools (convenience binding)
TOOLS=/$TOOLS_PREFIX

