
get-file() {
    # $1 - urls
    # $2 - output file path
    # $3 - No Overwrite
    [ $3 = "1" ] && [ -f $2 ] && return 0
    for u in $1; do
          wget --timeout=10 --tries=3 $u -O $2 && return 0
    done
    return 1
}
