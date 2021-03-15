#####################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 18.14-s037_1
#   on 03/14/2021 18:02:31
#
# This file can only be run in Genus Common UI mode.
#
#####################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 18.14-s037_1


# Remove Existing Design
###########################################################
if {[::legacy::find -design design:picorv32] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:picorv32
}


# To allow user-readonly attributes
########################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Source INIT Setup file
########################################################
source ./picorv32_genus_xfer.genus_init.tcl
read_metric -id current ./picorv32_genus_xfer.metrics.json

source ./picorv32_genus_xfer.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "18.14-s037_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 18.14-s037_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:picorv32]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "-292.9"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: -292.9,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns design:picorv32]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "357280"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 357280,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:picorv32]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "17993"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 17993,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:picorv32]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "15645"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 15645,  current net area: $_net_area_"
}
unset _net_area_
