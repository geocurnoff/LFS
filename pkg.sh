#!/usr/bin/bash

# A command interface for packages

LFS_SRC=$(readlink -f `dirname $0`)

# Helper functions for this script
. $LFS_SRC/lib/die.sh
. $LFS_SRC/lib/success.sh
. $LFS_SRC/lib/parse-name.sh
. $LFS_SRC/lib/parse-target.sh


# Helper functions for command script
COMMAND_IMPORTS="\
. $LFS_SRC/lib/die.sh;\
. $LFS_SRC/lib/success.sh;\
. $LFS_SRC/lib/get-file.sh;\
. $LFS_SRC/lib/dir-install.sh;\
. $LFS_SRC/lib/printf-color.sh;"

[ "$#" -lt 2 ] && echo "\
USAGE: pkg.sh <command list> <package name>
       pkg.sh create <package name>" 1>&2 && exit 1

PACKAGES_DIRS=$(ls $LFS_SRC/packages | sed s/shared//)

PACKAGES_DIR=$LFS_SRC"/packages"

SHARED=$LFS_SRC/packages/shared
LFS_WORK_DIR=$LFS_SRC/lfs_work

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
            for s in $(ls -d $PACKAGES_DIR/$d/*/ 2> /dev/null ); do
                local base=$(basename $s)
                [[ $base == $NAME ]] && NAME=$base && PKGDIR=$PACKAGES_DIR/$d/$NAME && break 2
            done
        done

        [ "$PKGDIR" ] || die "Package $NAME doesn't exist!"

        # Sort out arguments
        COMMAND=$1
        TARGET="$(parse-target ${@:$#})"
        TARGET="${TARGET:-DEFAULT}"

        pushd $PKGDIR > /dev/null || die

        # Fake root
        BUILD=$LFS_WORK_DIR/build/$NAME/$TARGET

        # Source code
        SRC=$LFS_WORK_DIR/src/$NAME/$TARGET

        # Temporary files
        SCRATCH=$LFS_WORK_DIR/scratch/$NAME/$TARGET

        # Fetched files
        CACHE=$LFS_WORK_DIR/cache/$NAME/$TARGET

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
            bash -c "shopt -s extglob; umask 022; set +h; $COMMAND_IMPORTS [ -e preamble.cmd.sh ] && . preamble.cmd.sh; . $1.cmd.sh" && \
            success "Command $1 finished." \
            || die "Command failed!"
        else
            die "Command not found!"
        fi

        popd > /dev/null
    fi
}

process_command $@
