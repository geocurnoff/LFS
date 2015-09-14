
proc http_copy { url file {chunk 4096} } {
	http::register https 443 [list ::tls::socket -tls1 1]
    set out [open $file w]
    set token [::http::geturl $url -channel $out \
            -progress httpCopyProgress -blocksize $chunk]
    close $out

    # This ends the line started by httpCopyProgress
    puts stderr ""
    
    upvar #0 $token state
    set max 0
    foreach {name value} $state(meta) {
        if {[string length $name] > $max} {
            set max [string length $name]
        }
        if {[regexp -nocase ^location$ $name]} {
            # Handle URL redirects
            puts stderr "Location:$value"
            return [http_copy [string trim $value] $file $chunk]
        }
    }
    incr max
    foreach {name value} $state(meta) {
        puts [format "%-*s %s" $max $name: $value]
    }

    return $token
}