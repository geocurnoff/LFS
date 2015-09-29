#!/bin/bash

# Helper script for installing packages into target root and keeping track of installed installed files
# TODO: running sed is extremely slow

. $LFS_SRC/lib/die.sh

dir-install() {

    # $1: Where to copy files from
    local SRC=$(readlink -f $1)

    [ -d $SRC ] || die "$SRC is not a valid source directory."

    # $2: Where to copy file to
    local TGT=$(readlink -f $2)

    [ -e $TGT ] || die "$TGT doesn't exist!"

    # $3: Optional, where to write list of installed files
    # Alternatively, output to stdout
    if [ $3 ]; then 
        local LIST_FILE=$(readlink -f $3)
    fi

    # Overwrite files in target directory?
    FORCE=${FORCE:-0}  

    # Find all the files in the source directory
    # NOTE: this includes sym-linked directories
    pushd $SRC &> /dev/null || die
    local SRC_FILES=$(find ./ -type f -o -type l)
    popd &> /dev/null || die

    # Convert source paths to destination paths
    local DEST_FILES=$(echo "$SRC_FILES" | sed "s@^\./@$TGT/@")

    # Check if files already exist
    if (( $FORCE==0 )); then
        pushd $TGT &> /dev/null || die
        local FILES_ALREADY_EXIST=0
        for f in $DEST_FILES; do 
            if [ -f $f ]; then
                FILES_ALREADY_EXIST=1
                echo "File exists: $f" | sed 's@//*@/@g' 1>&2
            fi
        done
        popd &> /dev/null || die
        (( $FILES_ALREADY_EXIST==1 )) && die "Some files already exist in the target directory"
    fi

    # Copy files to target directory, creating paths along the way
    pushd $SRC &> /dev/null || die
    
    for f in $SRC_FILES
    do
        local d_dir=$(dirname $f)
        local d_dir_stripped=$(echo $d_dir | sed 's@^\./@@')
        local abs_d_dir=$(echo "$TGT/$d_dir_stripped" | sed 's@//*@/@g')
        mkdir -p $abs_d_dir || die
        cp -rf $f $abs_d_dir || die "Copying $f to $abs_d_dir failed!"
        local f_stripped=$(echo $f | sed 's@^\./@@')
        local abs_f="$TGT/$f_stripped"
        abs_f=$(echo $abs_f | sed 's@//*@/@g')
        echo "Installing $abs_f" 1>&2
        echo $abs_f
    done > "${LIST_FILE:-/dev/stdout}"

    popd &> /dev/null || die
}