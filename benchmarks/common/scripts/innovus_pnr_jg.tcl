source ./config.tcl
#set init_mmmc_file "setup-timing.tcl"

set OUT_DIR ./out
# Reports and logs directories creation
file mkdir ${OUT_DIR}
set REPORTS_DIR "${OUT_DIR}/rpts"
set RESULTS_DIR "${OUT_DIR}/results"
set GDS_DIR     "${OUT_DIR}/gds"

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}
file mkdir ${GDS_DIR}


# Initialize
set_db design_process_node 45
set_db init_ground_nets VSS
set_db init_power_nets VDD
set setup_file   "../GENUS/${TOP_DESIGN}_genus_xfer.invs_setup.tcl"
   

source $setup_file
update_rc_corner -name default_emulate_rc_corner -cap_table "/home/abc586/freepdk-45nm/rtk-typical.captable"

set_message -no_limit
# Floorplan

create_floorplan -core_density_size 1.0 0.7 4.0 4.0 4.0 4.0

connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -verbose
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -verbose

# Power Grid
route_special -nets {VDD VSS}
add_rings -nets {VDD VSS} -width 0.6 -spacing 0.5 -layer {top 7 bottom 7 left 6 right 6}

add_stripes -nets {VSS VDD} -layer 6 -direction vertical -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5
add_stripes -nets {VSS VDD} -layer 7 -direction horizontal -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5

# Place Ports

set_db assign_pins_edit_in_batch true

set ports [get_db ports .name]
edit_pin -fix_overlap 1 -unit MICRON -spread_direction clockwise -side Left -layer 3 -spread_type start -spacing 0.4 -start 0.0 2.0 -pin $ports

set_db assign_pins_edit_in_batch false

# Placement
place_opt_design

# CTS
set_db cts_target_max_transition_time 0.08
set_db cts_target_skew 0.5
create_clock_tree -name MY_CLK -source clk
ccopt_design

# Route
route_design

set_db add_fillers_prefix FILL
set_db add_fillers_cells {FILLCELL_X4 FILLCELL_X2 FILLCELL_X1}
add_fillers

check_connectivity
check_drc

write_netlist "${RESULTS_DIR}/${TOP_DESIGN}-post-par.v"

#Extract RC parameters file

extract_rc
write_parasitics -rc_corner default_emulate_rc_corner -spef_file "${RESULTS_DIR}/${TOP_DESIGN}-post-par.spef"

#Real Layout file
write_stream ${OUT_DIR}/${GDS_DIR}/${TOP_DESIGN}-post-par.gds -merge "/home/abc586/freepdk-45nm/stdcells.gds" -map_file "/home/abc586/freepdk-45nm/rtk-stream-out.map"

write_db out/post_impl.final

#Dump Delay Info
set fl [open ${REPORTS_DIR}/post_pnr_delay_info.csv w]
puts $fl "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
foreach_in_collection path [report_timing -from [all_register] -to [all_registers] -max_paths 10000 -collection] {
	set launch [get_db $path .launching_point.name]
	set capture [get_db $path .capturing_point.name]
	set sum 0
	foreach del [get_db $path .timing_points.delay] {set sum [expr $sum + $del]}
	set depth [expr [llength [lsort -u [get_db $path .timing_points.pin.inst.name]]] - 2]
	if {$depth < 0} {set depth 0}
	puts $fl "$launch,$capture,$sum,$depth"
}
close $fl

set fl1 [open syn_gen_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

rm syn_gen_summary.txt
rm syn_gen_paths.csv
rm syn_gen_tmp.txt
#Report timing
report_timing -max_paths 150000 > ${REPORTS_DIR}/timing.rpt
exit
