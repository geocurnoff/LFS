#!/bin/bash

# Helper script for installing packages into target root and keeping track of installed installed files

. $LFS_SRC/lib/die.sh

dir-install() {

    # $1: Where to copy files from
    local SRC=$(readlink -f $1)

    [ -d $SRC ] || die "$SRC is not a valid source directory."

    # $2: Where to copy file to
    local TGT=$(readlink -f $2)

    [ -d $TGT ] || die "$TGT is not a valid destination directory."

    # $3: Optional, where to write list of installed files
    # Alternatively, output to stdout
    if [ $3 ]; then 
        local LIST_FILE=$(readlink -f $3)
    fi

    # Overwrite files in target directory?
    FORCE=${FORCE:-0}
    
    pushd $SRC &> /dev/null || die

    # Find all the files in the source directory and convert to absolute paths
    local FILES=""
    for f in $(find ./ -type f -o -type l)
    do 
        local f_stripped=$(echo $f | sed 's@^\./@@')
        local abs_f="$TGT/$f_stripped"
        FILES="$FILES 
               $abs_f"
    done

    popd &> /dev/null || die
        
    # Check if files already exist
    if (( $FORCE==0 )); then
        pushd $TGT &> /dev/null || die
        local FILES_ALREADY_EXIST=0
        for f in $FILES; do 
            if [ -f $f ]; then
                FILES_ALREADY_EXIST=1
                echo "File $abs_f exists!" 1>&2
            fi
        done
        popd &> /dev/null || die
        (( $FILES_ALREADY_EXIST==1 )) && die "Some files already exist in the target directory"
    fi

    # Copy files to target directory
    pushd $SRC &> /dev/null || die

    cp -r ./* $TGT &> /dev/null || die

    popd &> /dev/null || die

    # Write list of installed files to either standard output or file supplied in third argument
    pushd $TGT &> /dev/null || die
    for f in $FILES
    do
        echo $f
    done > "${LIST_FILE:-/dev/stdout}"
    popd &> /dev/null || die

}