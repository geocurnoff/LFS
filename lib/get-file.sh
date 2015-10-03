
get-file() {
    # $1 - urls
    # $2 - output file path
    local MD5_FILE=$CACHE/$(basename $2)".md5"
    local CHECKSUM_CALCULATED=$(md5sum $2 2>/dev/null | cut -f 1 -d " ")
    local CHECKSUM_STORED=""; CHECKSUM_STORED=$(cat $MD5_FILE 2>/dev/null)

    if [ "$CHECKSUM_STORED" ] && [ "$CHECKSUM_CALCULATED" = "$CHECKSUM_STORED" ]; then
    	printf_color green "Checksums match.\n" 
    	return 0
    fi
    # TODO: implement sticky checksums, that don't get overwritten
    for u in $1; do
        wget --timeout=10 --tries=3 $u -O $2 && md5sum $2 2>/dev/null | cut -f 1 -d " " > $MD5_FILE && return 0
    done

    return 1
}

get-file-or-die() {
    get-file $@ && success "Downloaded $1 to $2." || die "Failed downloading $1"
}