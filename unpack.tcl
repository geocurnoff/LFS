
namespace eval ::lfs {
  namespace export unpack
	proc unpack {filename} {
	  !* tar -xvf $filename
	  if {$::ERROR} {exit 1}
	}
}