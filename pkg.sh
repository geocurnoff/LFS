#!/usr/bin/bash

# A command interface for packages

LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions for this script
. $LFS_SRC/lib/die.sh
. $LFS_SRC/lib/parse-name.sh
. $LFS_SRC/lib/parse-target.sh
. $LFS_SRC/lib/printf-color.sh

# Helper functions for command script
COMMAND_IMPORTS="\
. $LFS_SRC/lib/die.sh;\
. $LFS_SRC/lib/get-file.sh;\
. $LFS_SRC/lib/dir-install.sh;\
. $LFS_SRC/lib/printf-color.sh;"

[ "$#" -lt 2 ] && echo "\
USAGE: pkg.sh <command list> <package name>
       pkg.sh create <package name>" 1>&2 && exit 1

PACKAGES_DIRS=$(ls $LFS_SRC/packages | sed s/shared//)

PACKAGES_DIR=$LFS_SRC"/packages"

# Configuration
. $LFS_SRC/pkg.cfg.sh

SHARED=$LFS_SRC/packages/shared
LFS_WORK_DIR=$LFS_SRC/.lfs_work

process_command() {
    if [ "$#" -gt 2 ]; then
        # Pass first command with the last two arguments
        process_command $1 "${@:$#}"
        # Discard processed command
        shift
        # Recurse on the remainder
        process_command $@
    else
        NAME=$(parse-name ${@:$#})

        PKGDIR=""
        for d in $PACKAGES_DIRS; do
            [ -d $PACKAGES_DIR/$d/$NAME ] && PKGDIR=$PACKAGES_DIR/$d/$NAME && break
        done

        [ $PKGDIR ] || die "Package $PKG_NAME_ARG doesn't exist!"

        # Sort out arguments
        COMMAND=$1
        TARGET="$(parse-target ${@:$#})"
        TARGET="${TARGET:-DEFAULT}"

        pushd $PKGDIR > /dev/null || die

        # Fake root
        BUILD=$LFS_WORK_DIR/$NAME/build/$TARGET

        # Source code
        SRC=$LFS_WORK_DIR/$NAME/src/$TARGET

        # Temporary files
        SCRATCH=$LFS_WORK_DIR/$NAME/scratch/$TARGET

        # Fetched files
        CACHE=$LFS_WORK_DIR/$NAME/cache/$TARGET

        printf_color light-red "Invoking $1 command on package ${NAME-$2} for target ${TARGET}\n"

        if [ -f "$1".cmd.sh ]; then
            env -i \
            TARGET=$TARGET \
            COMMAND=$COMMAND \
            NAME=$NAME \
            BUILD=$BUILD \
            SRC=$SRC \
            SCRATCH=$SCRATCH \
            CACHE=$CACHE \
            PKGDIR=$PKGDIR \
            PATH=$PATH \
            SHARED=$SHARED \
            PACKAGES_DIR=$PACKAGES_DIR \
            LFS_SRC=$LFS_SRC \
            /bin/bash -c "shopt -s extglob; umask 022; set +h; $COMMAND_IMPORTS . $1.cmd.sh" || die "Command failed!"
        else
            die "Command not found!"
        fi

        popd > /dev/null
    fi
}

process_command $@
