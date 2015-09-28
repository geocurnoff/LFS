
get-file() {
    # $1 - urls
    # $2 - output file path
    # $3 - checksum
    CHECKSUM=$(md5sum $2 2>/dev/null | cut -f 1 -d " ")
    [ "$3" ] && [ "$CHECKSUM" = "$3" ] && printf_color green "Checksums match.\n" && return 0
    for u in $1; do
        wget --timeout=10 --tries=3 $u -O $2 && md5sum $2 2>/dev/null | cut -f 1 -d " " > $CACHE/$(basename $2)".md5" && success "Downloaded $1 to $2." && return 0
    done
    return 1
}
