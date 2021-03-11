set_multi_cpu_usage -local_cpu 8
source ./config.tcl

proc list_unique {list} {
    array set included_arr [list]
    set unique_list [list]
    foreach item $list {
        if { ![info exists included_arr($item)] } {
            set included_arr($item) ""
            lappend unique_list $item
        }
    }
    unset included_arr
    return $unique_list
}

set in_file      $env(OP_FILE)

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
set setup_file   ${in_file}_genus_xfer.invs_setup.tcl   

source $setup_file
update_rc_corner -name default_emulate_rc_corner -cap_table "/home/abc586/freepdk-45nm/rtk-typical.captable"

set_message -no_limit
set_interactive_constraint_modes default_emulate_constraint_mode
set_max_fanout 10 [get_db ports -if {.direction == *in}]
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

#Dump Delay Info reg2reg
set fl [open ${REPORTS_DIR}/post_pnr_delay_reg2reg_info.csv w]
set fl2 [open ${REPORTS_DIR}/post_pnr_reg2reg_features.csv w]
puts $fl "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
set path_count 1
foreach_in_collection path [report_timing -from [all_registers] -to [all_registers] -max_paths 10000 -collection] {
	set launch [get_db $path .launching_point.name]
	set capture [get_db $path .capturing_point.name]
	set sum 0
	foreach del [get_db $path .timing_points.delay] {set sum [expr $sum + $del]}
	set depth [expr [llength [lsort -u [get_db $path .timing_points.pin.inst.name]]] - 2]
	if {$depth < 0} {set depth 0}
	puts $fl "$launch,$capture,$sum,$depth"
	set loads [get_db [list_unique [get_db $path .timing_points.pin.net]] .capacitance_max]
	set gates [get_db [get_db $path  .timing_points.pin. -if {.obj_type == *pin && .direction == *out}] .inst.base_cell.name]
	set period [get_db $path .period],
	set line_to_print ""
	lappend line_to_print $path_count,
	for {set i 1} {$i < [llength $loads]} {incr i} {
		if {[regexp INV [lindex $gates [expr $i - 1]]]} {
			set tmp_gate 1.0
		} elseif {[regexp NAND [lindex $gates [expr $i - 1]]] || [regexp NOR [lindex $gates [expr $i - 1]]]} {
			set tmp_gate 2.0
		} elseif {[regexp AND [lindex $gates [expr $i - 1]]] || [regexp OR [lindex $gates [expr $i - 1]]]} {
			set tmp_gate 3.0
		} elseif {[regexp DFF [lindex $gates [expr $i - 1]]]} {set tmp_gate 5.0} else {set tmp_gate 4.0}
			 lappend line_to_print $period,
			 lappend line_to_print $tmp_gate,
			 lappend line_to_print [lindex $loads $i],
	}
	puts $fl2 $line_to_print
	incr path_count
}
close $fl
close $fl2

#reg2out
set fl [open ${REPORTS_DIR}/post_pnr_delay_reg2out_info.csv w]
puts $fl "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
set fl2 [open ${REPORTS_DIR}/post_pnr_reg2out_features.csv w]
set path_count 1
foreach_in_collection path [report_timing -from [all_registers] -to [all_outputs] -max_paths 10000 -collection] {
        set launch [get_db $path .launching_point.name]
        set capture [get_db $path .capturing_point.name]
        set sum 0
        foreach del [get_db $path .timing_points.delay] {set sum [expr $sum + $del]}
        set depth [expr [llength [lsort -u [get_db [get_db $path .timing_points.pin. -if {.obj_type == *pin}] .inst.name]]] - 2]
        if {$depth < 0} {set depth 0}
        puts $fl "$launch,$capture,$sum,$depth"
        set loads [get_db [list_unique [get_db $path .timing_points.pin.net]] .capacitance_max]
        set gates [get_db [get_db $path  .timing_points.pin. -if {.obj_type == *pin && .direction == *out}] .inst.base_cell.name]
        set period [get_db $path .period],
        set line_to_print ""
        lappend line_to_print $path_count,
        for {set i 1} {$i < [llength $loads]} {incr i} {
                if {[regexp INV [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 1.0
                } elseif {[regexp NAND [lindex $gates [expr $i - 1]]] || [regexp NOR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 2.0
                } elseif {[regexp AND [lindex $gates [expr $i - 1]]] || [regexp OR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 3.0
                } elseif {[regexp DFF [lindex $gates [expr $i - 1]]]} {set tmp_gate 5.0} else {set tmp_gate 4.0}
                         lappend line_to_print $period,
                         lappend line_to_print $tmp_gate,
                         lappend line_to_print [lindex $loads $i],
        }
        puts $fl2 $line_to_print
        incr path_count
}
close $fl
close $fl2

# in2reg
set fl [open ${REPORTS_DIR}/post_pnr_delay_in2reg_info.csv w]
puts $fl "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
set path_count 1
set fl2 [open ${REPORTS_DIR}/post_pnr_in2reg_features.csv w]
foreach_in_collection path [report_timing -from [all_inputs] -to [all_registers] -max_paths 10000 -collection] {
        set launch [get_db $path .launching_point.name]
        set capture [get_db $path .capturing_point.name]
        set sum 0
        foreach del [get_db $path .timing_points.delay] {set sum [expr $sum + $del]}
        set depth [expr [llength [lsort -u [get_db [get_db $path .timing_points.pin. -if {.obj_type == *pin}] .inst.name]]] - 1]        
	if {$depth < 0} {set depth 0}
        puts $fl "$launch,$capture,$sum,$depth"
        set loads [get_db [list_unique [get_db $path .timing_points.pin.net]] .capacitance_max]
        set gates [get_db [get_db $path  .timing_points.pin. -if {.obj_type == *pin && .direction == *out}] .inst.base_cell.name]
        set period [get_db $path .period],
	set line_to_print ""
        lappend line_to_print $path_count,
        for {set i 1} {$i < [llength $loads]} {incr i} {
                if {[regexp INV [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 1.0
                } elseif {[regexp NAND [lindex $gates [expr $i - 1]]] || [regexp NOR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 2.0
                } elseif {[regexp AND [lindex $gates [expr $i - 1]]] || [regexp OR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 3.0
                } elseif {[regexp DFF [lindex $gates [expr $i - 1]]]} {set tmp_gate 5.0} else {set tmp_gate 4.0}
                         lappend line_to_print $period,
                         lappend line_to_print $tmp_gate,
                         lappend line_to_print [lindex $loads $i],
        }
        puts $fl2 $line_to_print
        incr path_count
}
close $fl
close $fl2

# in2out
set fl [open ${REPORTS_DIR}/post_pnr_delay_in2out_info.csv w]
puts $fl "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
set path_count 1
set fl2 [open ${REPORTS_DIR}/post_pnr_in2out_features.csv w]
foreach_in_collection path [report_timing -from [all_inputs] -to [all_outputs] -max_paths 10000 -collection] {
        set launch [get_db $path .launching_point.name]
        set capture [get_db $path .capturing_point.name]
        set sum 0
        foreach del [get_db $path .timing_points.delay] {set sum [expr $sum + $del]}
        set depth [llength [lsort -u [get_db [get_db $path .timing_points.pin. -if {.obj_type == *pin}] inst.name]]]
	if {$depth < 0} {set depth 0}
        puts $fl "$launch,$capture,$sum,$depth"
        set loads [get_db [list_unique [get_db $path .timing_points.pin.net]] .capacitance_max]
        set gates [get_db [get_db $path  .timing_points.pin. -if {.obj_type == *pin && .direction == *out}] .inst.base_cell.name]
        set period [get_db $path .period],
	set line_to_print ""
	lappend line_to_print $path_count,
        for {set i 1} {$i < [llength $loads]} {incr i} {
                if {[regexp INV [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 1.0
                } elseif {[regexp NAND [lindex $gates [expr $i - 1]]] || [regexp NOR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 2.0
                } elseif {[regexp AND [lindex $gates [expr $i - 1]]] || [regexp OR [lindex $gates [expr $i - 1]]]} {
                        set tmp_gate 3.0
                } elseif {[regexp DFF [lindex $gates [expr $i - 1]]]} {set tmp_gate 5.0} else {set tmp_gate 4.0}
                         lappend line_to_print $period,
                         lappend line_to_print $tmp_gate,
                         lappend line_to_print [lindex $loads $i],
        }
        puts $fl2 $line_to_print
        incr path_count
}
close $fl
close $fl2

set fl1 [open syn_gen_reg2reg_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_reg2reg_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_reg2reg_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

set fl1 [open syn_gen_in2reg_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_in2reg_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_in2reg_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

set fl1 [open syn_gen_reg2out_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_reg2out_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_reg2out_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

set fl1 [open syn_gen_in2out_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_in2out_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_in2out_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

set fl [open syn_gen_reg2reg_gate_n_loads.txt r]
set lines [split [read $fl] '\n']
close $fl

set cnt 1
set line_to_print ""
set fl [open ${REPORTS_DIR}/syn_gen_reg2reg_features.csv w]
foreach a $lines {
        if {[regexp Arrival $a]} {
        	set period [expr [lindex $a 1]/1000]
	        if {[llength $line_to_print] > 0} {puts $fl $line_to_print}
        	set line_to_print ""
	        lappend line_to_print $cnt
        	incr cnt
        }
	if {[regexp unmapped_ $a] && [lindex $a 2] > 0} {
        	if {[regexp not [lindex $a 1]]} {set tmp_gate 1.0}
        	if {[regexp nand2 [lindex $a 1]] || [regexp nor2 [lindex $a 1]]} {set tmp_gate 2.0}
        	if {[regexp _and2 [lindex $a 1]] || [regexp _or2 [lindex $a 1]]} {set tmp_gate 3.0}
        	if {[regexp complex2 [lindex $a 1]]} {set tmp_gate 4.0}
        	if {[regexp d_flop [lindex $a 1]]} {set tmp_gate 5.0}
        	lappend line_to_print $period, 
        	lappend line_to_print $tmp_gate,
        	lappend line_to_print [lindex $a 2].
        }
}
puts $fl $line_to_print
close $fl

set fl [open syn_gen_in2reg_gate_n_loads.txt r]
set lines [split [read $fl] '\n']
close $fl

set cnt 1
set line_to_print ""
set fl [open ${REPORTS_DIR}/syn_gen_in2reg_features.csv w]
foreach a $lines {
        if {[regexp Arrival $a]} {
                set period [expr [lindex $a 1]/1000]
                if {[llength $line_to_print] > 0} {puts $fl $line_to_print}
                set line_to_print ""
                lappend line_to_print $cnt
                incr cnt
        }
        if {[regexp unmapped_ $a] && [lindex $a 2] > 0} {
                if {[regexp not [lindex $a 1]]} {set tmp_gate 1.0}
                if {[regexp nand2 [lindex $a 1]] || [regexp nor2 [lindex $a 1]]} {set tmp_gate 2.0}
                if {[regexp _and2 [lindex $a 1]] || [regexp _or2 [lindex $a 1]]} {set tmp_gate 3.0}
                if {[regexp complex2 [lindex $a 1]]} {set tmp_gate 4.0}
                if {[regexp d_flop [lindex $a 1]]} {set tmp_gate 5.0}
                lappend line_to_print $period,
                lappend line_to_print $tmp_gate,
                lappend line_to_print [lindex $a 2].
        }
}
puts $fl $line_to_print
close $fl

set fl [open syn_gen_reg2out_gate_n_loads.txt r]
set lines [split [read $fl] '\n']
close $fl

set cnt 1
set line_to_print ""
set fl [open ${REPORTS_DIR}/syn_gen_reg2out_features.csv w]
foreach a $lines {
        if {[regexp Arrival $a]} {
                set period [expr [lindex $a 1]/1000]
                if {[llength $line_to_print] > 0} {puts $fl $line_to_print}
                set line_to_print ""
                lappend line_to_print $cnt
                incr cnt
        }
        if {[regexp unmapped_ $a] && [lindex $a 2] > 0} {
                if {[regexp not [lindex $a 1]]} {set tmp_gate 1.0}
                if {[regexp nand2 [lindex $a 1]] || [regexp nor2 [lindex $a 1]]} {set tmp_gate 2.0}
                if {[regexp _and2 [lindex $a 1]] || [regexp _or2 [lindex $a 1]]} {set tmp_gate 3.0}
                if {[regexp complex2 [lindex $a 1]]} {set tmp_gate 4.0}
                if {[regexp d_flop [lindex $a 1]]} {set tmp_gate 5.0}
                lappend line_to_print $period,
                lappend line_to_print $tmp_gate,
                lappend line_to_print [lindex $a 2].
        }
}
puts $fl $line_to_print
close $fl

set fl [open syn_gen_in2out_gate_n_loads.txt r]
set lines [split [read $fl] '\n']
close $fl

set cnt 1
set line_to_print ""
set fl [open ${REPORTS_DIR}/syn_gen_in2out_features.csv w]
foreach a $lines {
        if {[regexp Arrival $a]} {
                set period [expr [lindex $a 1]/1000]
                if {[llength $line_to_print] > 0} {puts $fl $line_to_print}
                set line_to_print ""
                lappend line_to_print $cnt
                incr cnt
        }
        if {[regexp unmapped_ $a] && [lindex $a 2] > 0} {
                if {[regexp not [lindex $a 1]]} {set tmp_gate 1.0}
                if {[regexp nand2 [lindex $a 1]] || [regexp nor2 [lindex $a 1]]} {set tmp_gate 2.0}
                if {[regexp _and2 [lindex $a 1]] || [regexp _or2 [lindex $a 1]]} {set tmp_gate 3.0}
                if {[regexp complex2 [lindex $a 1]]} {set tmp_gate 4.0}
                if {[regexp d_flop [lindex $a 1]]} {set tmp_gate 5.0}
                lappend line_to_print $period,
                lappend line_to_print $tmp_gate,
                lappend line_to_print [lindex $a 2].
        }
}
puts $fl $line_to_print
close $fl

rm syn_gen_*summary.txt
rm syn_gen_*paths.csv
rm syn_gen_*tmp.txt
rm syn_gen_*gate_n_loads.txt

#Report timing
report_timing > ${REPORTS_DIR}/timing.rpt
exit
