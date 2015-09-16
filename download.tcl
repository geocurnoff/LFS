package require http
package require tls
package require ftp
package require uri

namespace eval ::lfs {
  namespace export download

  proc basename {path} {
    return [lrange [file split $path] end end]
  }

  proc terminal {command args} {
    switch -exact -- $command {
      size {
        return [exec stty size]
      }
      width {
        return [lindex [exec stty size] 1]
      }
      height {
        return [lindex [exec stty size] 0]
      }
      default {}
    }
  }

  proc parse_protocol {url} {
    regexp {([[:alpha:]]+)://} $url _ protocol
    return $protocol
  }

  proc http_copy { url filename {chunk 4096} } {
    http::register https 443 [list ::tls::socket -tls1 1]
    
    set out [open $filename w]

    # Parametrize callback
    make-http-callback http-progress-cb [basename $filename]

    if [catch {set token [::http::geturl $url -channel $out -progress ::lfs::http-progress-cb -blocksize $chunk]} e] {
      puts stderr "Error: $e"
      close $out
      return 0;
    }

    close $out

    # Check for transfer error
    switch -exact -- [::http::status $token] {
      eof {
        puts stderr "Error: server closed connection"   
        ::http::cleanup $token
        return 0
      }
      error {
        puts stderr "Error: [::http::status $token]]"
        ::http::cleanup $token
        return 0    
      }
    }

    # Check http errors
    set code [::http::ncode $token]
    if {[lsearch [list 200 301 302 307] $code] == -1} {
      puts stderr "Error: [::http::code $token]]"
      flush stderr
      ::http::cleanup $token
      return 0    
    }

    # This ends the line started by httpCopyProgress
    puts stderr ""

    upvar #0 $token state
    set max 0
    foreach {name value} $state(meta) {
      if {[regexp -nocase ^location$ $name]} {
        # Handle URL redirects
        puts stdout "$url -> $value"
        return [http_copy [string trim $value] $filename $chunk]
      }
    }
    ::http::cleanup $token
    return 1
  }

  proc ftp_copy { url filename {chunk 4096} } {
    set out [open $filename w]
    array set url_parts [uri::split $url]
    set handle [ftp::Open $url_parts(host) "anonymous" "" -progress ::lfs::ftp-progress-cb]
    if {$handle == -1} { 
      puts stderr "Error: connection failed"
      close $out
      return 0 
    }
    set size [ftp::FileSize $handle $url_parts(path)]
    make-ftp-callback ftp-progress-cb [basename $filename] $size
    if {! [ftp::Get $handle $url_parts(path) -channel $out]} {
      puts stderr "Error: downloading failed"
      ftp::Close $handle
      close $out
      return 0
    }
    rename ftp-progress-cb ""
    puts stderr ""
    ftp::Close $handle
    close $out
    return 1
  }

  set PROGRESS_CALLBACK_TEMPLATE {
    set width [expr int(([terminal width]-[string length #FILENAME#])*1.0)-4]
    set progress [expr double($current_size)/double(#TOTAL_SIZE#)]
    if {$progress <= 1.0} {
      set bars [expr int($progress * $width)]
      } else {
        set bars $width
      }
      puts -nonewline stderr "\r#FILENAME# \[[join [lrepeat $bars =] ""]>\]"
      flush stderr
  }

  proc make-http-callback {pname filename} {
    set body [string map [list #FILENAME# $filename #TOTAL_SIZE# {$total_size}] $::lfs::PROGRESS_CALLBACK_TEMPLATE ]
    proc $pname {args total_size current_size} $body
  }

  proc make-ftp-callback {pname filename total_size} {
    set body [string map [list #FILENAME# $filename #TOTAL_SIZE# $total_size] $::lfs::PROGRESS_CALLBACK_TEMPLATE ]
    proc $pname {current_size} $body
  }

  proc download {name args} {
    foreach url $args {
      set protocol [parse_protocol $url];
      switch -exact -- $protocol {
        http -
        https {
          set copy_proc http_copy
        }
        ftp {
          set copy_proc ftp_copy
        }
        default {
          error "Unsupported protocol $protocol!"
        }
      }
      if {[$copy_proc $url $name]} {return 1;}
    }
    return 0;
  }
}