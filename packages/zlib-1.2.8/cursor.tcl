#!/usr/bin/tclsh

proc terminal {command args} {


}

set fd1 [open /dev/stdout r]

for {set i 0} {$i < 10} {incr i} {
	puts " sds dsd sdsd sds dasd asd asdas ds"
}




puts [read fd1 10]

exec /bin/stty raw <@stdin

fconfigure stdin -blocking 0
global x
global y


flush stdout
puts [gets stdin]
set y 0
set str "#"
set str2 "==============="
while {$y < 10} {
	incr y;
	puts -nonewline "\033\[2J"
	puts -nonewline "\033\[$y;0H"
	#puts "^\033\[6n"
	puts $str
	puts -nonewline "\033\[0;0H"
	puts -nonewline $str2
	#puts -nonewline "\033\[1A\033\[1;35m # \033\[7B\033\[6D"	
	flush stdout
	after 1000
	set c [read stdin 1]
	if {$c != ""} {
		set str "KEY PRESSED"
	}
}

exec /bin/stty -raw <@stdin