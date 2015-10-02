# Path of LFS source directory
LFS_SRC=$(readlink -f `dirname $0`)/../..

mkdir -p $LFS/source && \
cp -rvf $LFS_SRC/{*.sh,packages,tests,lib,groups} $LFS/source && \
mkdir -p $LFS/source/.lfs-work/cache && \
cp -rvf $LFS_SRC/.lfs-work/cache $LFS/source/.lfs-work/ || die