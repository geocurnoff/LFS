#!/usr/bin/tclsh

source ./download.tcl
source ./run.tcl
source ./colorize.tcl
source ./unpack.tcl

namespace eval ::lfs {
  
	proc parse_goal {goal package target} {
		upvar $package p
		upvar $target t
		regexp {([^/[:space:]]+)/?([^[:space:]]*)} $goal _ p t
	}

}

namespace import ::lfs::*
namespace import ::usability::*

set ::lfs::SCRIPT_DIR [file dirname [file normalize [info script]]]
set COMMANDS [lrange $argv 0 end-1]
set GOAL [lindex $argv [expr $argc - 1]]
::lfs::parse_goal $GOAL PACKAGE_NAME TARGET_NAME
set? TARGET_NAME "DEFAULT"
set PACKAGE_DIR [file normalize "$::lfs::SCRIPT_DIR/packages/$PACKAGE_NAME"]
set CACHE "$PACKAGE_DIR/cache/$TARGET_NAME"
set SRC "$PACKAGE_DIR/src/$TARGET_NAME"
set BUILD "$PACKAGE_DIR/build/$TARGET_NAME"
set SCRATCH "$PACKAGE_DIR/scratch/$TARGET_NAME"

if {![expr [file exists $PACKAGE_DIR] && [file isdirectory $PACKAGE_DIR]]} {
	puts stderr "Package \"$PACKAGE_NAME\" doesn't exist!"
	exit 1
}

foreach COMMAND $COMMANDS {
	set COMMAND_FILE "$PACKAGE_DIR/$COMMAND.cmd.tcl"
	if {![file exists $COMMAND_FILE]} {
		puts stderr "Command \"$COMMAND_FILE\" doesn't exist!"
	    exit 1
	}
	puts [colorize light-red "Invoking $COMMAND command on package $PACKAGE_NAME for target $TARGET_NAME\n"]
	namespace eval ::command:: {
		source $COMMAND_FILE
    }
    namespace delete ::command::
}










# set target "sysinit/sdd"

# proc parse-target {}

# proc :# {x} {
# 	return "^$x/?.*"
# }

# switch -regexp $target \
#   [:# initsys] {
# 	puts "Initsys"
# } [:# normal] {
# 	puts "Normal";
# } [:# sysinit] {
# 	puts "sysinit"
# }

# set labels [format "%-20s %+10s " "Item" "Cost"]
# set price1 [format "%-20s %10d Cents Each" "Tomatoes" "30"]
# set price2 [format "%-20s %10d Cents Each" "Peppers" "20"]
# set price3 [format "%-20s %10d Cents Each" "Onions" "10"]
# set price4 [format "%-20s %10.2f per Lb." "Steak" "3.59997"]

# puts "\n Example of format:\n"
# puts "$labels"
# puts "$price1"
# puts "$price2"
# puts "$price3"
# puts "$price4"


































# I smile, just knowing
# When the sun rises, I will not see

# When the revolution start,
# I'll be late and will be shot as a traitor