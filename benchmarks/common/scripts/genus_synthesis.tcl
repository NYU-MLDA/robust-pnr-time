date
set_db max_cpus_per_server 8
set sdc_set_dont_touch_physical_net 1


source ./config.tcl

set OUT_DIR ./out
# Reports and logs directories creation
# file mkdir ${OUT_DIR}
# set REPORTS_DIR "${OUT_DIR}/rpts"
set RESULTS_DIR "${OUT_DIR}/results"
# set LOGS_DIR     "${OUT_DIR}/logs"
#
# # Added if you run Formality
# set_svf ${OUT_DIR}/${TOP_DESIGN}.svf
# file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}
# file mkdir ${LOGS_DIR}


set_db current_design .optimize_constant_0_seq 		false
set_db current_design .optimize_constant_1_seq 		false
set_db current_design .iopt_force_constant_removal 	false
set_db current_design .optimize_merge_seq 		false
set_db current_design .lp_clock_gating_auto_cost_grouping true

set design ${DESIGN}
set module_name  ${TOP_DESIGN}
set clk          ${CLK_NAME}
set myPeriod     ${CLOCK_PERIOD}

set search_path [get_db init_lib_search_path]
lappend search_path *
set_db init_lib_search_path $search_path
set search_path [get_db script_search_path]
lappend search_path *
set_db script_search_path $search_path

#set_db target_library /home/abc586/nangate15nm/NanGate_15nm_OCL_typical_conditional_ccs.lib
#set_db link_library /home/abc586/nangate15nm/NanGate_15nm_OCL_typical_conditional_ccs.lib

set_db target_library /home/abc586/freepdk-45nm/stdcells.lib
set_db link_library /home/abc586/freepdk-45nm/stdcells.lib

#set_db init_hdl_search_path $design
#set_db hdl_search_path $design
#set tmp_var [glob $design/*.v]
#set rtl_files ""
#foreach tmp $tmp_var {lappend rtl_files [file tail $tmp]}
#read_hdl $rtl_files
read_hdl -f ${DESIGN}
elaborate ${TOP_DESIGN}

current_design ${TOP_DESIGN}

#create_clock -name VCLK -period "${myPeriod}" [get_ports $clk]
create_clock -period "${myPeriod}" [get_ports $clk]
set_clock_uncertainty -setup ${CLK_UNC_SETUP} [get_clocks $clk]
set_clock_uncertainty -hold  ${CLK_UNC_HOLD} [get_clocks $clk]


set input_ports  [all_inputs]
set output_ports [all_outputs]
#set_max_fanout 10 [current_design]
#set EXT_DELAY [expr $CLOCK_PERIOD * 0.2]

#set_input_delay -max 1 [get_ports $input_ports ] -clock VCLK
#set_input_delay -min 0 [get_ports $input_ports ] -clock VCLK

#set_output_delay -max 2 [get_ports $output_ports ] -clock VCLK
#set_output_delay -min 1 [get_ports $output_ports ] -clock VCLK

check_design
syn_gen
report_timing -max_paths 150000 > ${RESULTS_DIR}/${TOP_DESIGN}_generic_timing.rpt


#jg6467 changes start
set paths [report_timing -from [all_registers] -to [all_registers] -logic_levels 1000 -logic_levels_tcl_list -max_paths 10000]

set fl [open syn_gen_paths.csv w]
foreach path $paths {puts $fl "[lindex $path 0], [lindex $path 1], [lindex $path 2]"}
report_timing -from [all_registers] -to [all_registers] -path_type summary -max_paths 10000 > syn_gen_summary.txt
close $fl
#jg6467 changes end

syn_map
syn_opt
report_timing -max_paths 150000 > ${RESULTS_DIR}/${TOP_DESIGN}_techmap_timing.rpt
ungroup -flatten -all

update_names -verilog
#set_db bus_naming_style "%s_%d"
#write_db -all_root_attributes -to_file ${op_file}_2ip.db
write_hdl -lec > ${RESULTS_DIR}/${TOP_DESIGN}_synthesized.v
write_sdc ${TOP_DESIGN} > ${RESULTS_DIR}/${TOP_DESIGN}.final.sdc
exit
