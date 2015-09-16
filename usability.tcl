
# Usability improvements for tcl

namespace eval ::usability {
  namespace export set?

  	# Set to default if variable doesn't exist or empty
	proc set? {var default} {
		upvar $var v	
		if {![info exists v] || $v == ""} {
			set v $default
		}
	}

	set ERROR 0

	proc ! args {
	  global ERROR
	    if [catch {eval exec $args >/dev/stdout} res] {
	        if {[lindex $::errorCode 0]=="CHILDSTATUS"} {
	            set ERROR [lindex $::errorCode 2]
	        }
	    }
	    set res
	} ;# and an echoing version...

	proc !* args {global ERROR; puts [eval ! $args]; if {$ERROR} {exit $ERROR}}
	
}