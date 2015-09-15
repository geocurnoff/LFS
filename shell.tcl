
namespace eval ::lfs {
  namespace export download

  set ::? 0 

  proc ! args {
      if [catch {eval exec $args} res] {
          if {[lindex $::errorCode 0]=="CHILDSTATUS"} {
              set ::? [lindex $::errorCode 2]
          }
      }
      set res
   } ;# and an echoing version...
   proc !! args {puts $args; puts [eval ! $args]}
}