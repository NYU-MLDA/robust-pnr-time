date
set_db max_cpus_per_server 8
set sdc_set_dont_touch_physical_net 1
set_db current_design .optimize_constant_0_seq 		false
set_db current_design .optimize_constant_1_seq 		false
set_db current_design .iopt_force_constant_removal 	false
set_db current_design .optimize_merge_seq 		false
set_db current_design .lp_clock_gating_auto_cost_grouping true

set design [getenv DESIGN]
set module_name  $env(MODULE_NAME)
set clk          $env(CLOCK)
set reset        $env(RESET)
set op_file      $env(OP_FILE)
set myPeriod     $env(MY_PERIOD)

set search_path [get_db init_lib_search_path]
lappend search_path *
set_db init_lib_search_path $search_path
set search_path [get_db script_search_path]
lappend search_path *
set_db script_search_path $search_path
set_db lef_library {/home/abc586/freepdk-45nm/rtk-tech.lef /home/abc586/freepdk-45nm/stdcells.lef}

set v2b_home {/home/abc586/currentResearch/MAJOR_REV_ASSURE/assure-dev/tests/v2bench}
set_db target_library /home/abc586/freepdk-45nm/stdcells.lib
set_db link_library /home/abc586/freepdk-45nm/stdcells.lib

#set_dont_use [get_lib_cells NanGate_15nm_OCL/*]
#set_db [get_lib_cells NanGate_15nm_OCL/NAND2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/AND2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/NOR2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/OR2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/XOR2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/XNOR2_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/INV_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/BUF_*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/DFF*] .dont_use false
#set_db [get_lib_cells NanGate_15nm_OCL/LHQ*] .dont_use false 

set_db init_hdl_search_path $design
set_db hdl_search_path $design
set tmp_var [glob $design/*.v]
set rtl_files ""
foreach tmp $tmp_var {lappend rtl_files [file tail $tmp]}
read_hdl $rtl_files

elaborate

create_clock -name VCLK -period "${myPeriod}" -waveform "0 [expr $myPeriod/2]" [get_ports $clk]

set input_ports  [all_inputs]
set output_ports [all_outputs]

set_input_delay -max 1 [get_ports $input_ports ] -clock VCLK
set_input_delay -min 0 [get_ports $input_ports ] -clock VCLK

set_output_delay -max 2 [get_ports $output_ports ] -clock VCLK
set_output_delay -min 1 [get_ports $output_ports ] -clock VCLK

check_design
syn_gen

set paths [report_timing -from [all_registers] -to [all_registers] -logic_levels 1000 -logic_levels_tcl_list -max_paths 10000]

set fl [open syn_gen_reg2reg_paths.csv w]
foreach path $paths {puts $fl "[lindex $path 0], [lindex $path 1], [lindex $path 2]"}
close $fl
report_timing -from [all_registers] -to [all_registers] -path_type summary -max_paths 10000 > syn_gen_reg2reg_summary.txt
report_timing -from [all_registers] -to [all_registers] -max_paths 10000 -fields {timing_point cell load} > syn_gen_reg2reg_gate_n_loads.txt


set paths [report_timing -from [all_inputs] -to [all_registers] -logic_levels 1000 -logic_levels_tcl_list -max_paths 10000]

set fl [open syn_gen_in2reg_paths.csv w]
foreach path $paths {puts $fl "[lindex $path 0], [lindex $path 1], [lindex $path 2]"}
close $fl
report_timing -from [all_inputs] -to [all_registers] -path_type summary -max_paths 10000 > syn_gen_in2reg_summary.txt
report_timing -from [all_inputs] -to [all_registers] -max_paths 10000 -fields {timing_point cell load} > syn_gen_in2reg_gate_n_loads.txt

set paths [report_timing -from [all_registers] -to [all_outputs] -logic_levels 1000 -logic_levels_tcl_list -max_paths 10000]

set fl [open syn_gen_reg2out_paths.csv w]
foreach path $paths {puts $fl "[lindex $path 0], [lindex $path 1], [lindex $path 2]"}
close $fl
report_timing -from [all_registers] -to [all_outputs] -path_type summary -max_paths 10000 > syn_gen_reg2out_summary.txt
report_timing -from [all_registers] -to [all_outputs] -max_paths 10000 -fields {timing_point cell load} > syn_gen_reg2out_gate_n_loads.txt

set paths [report_timing -from [all_inputs] -to [all_outputs] -logic_levels 1000 -logic_levels_tcl_list -max_paths 10000]

set fl [open syn_gen_in2out_paths.csv w]
foreach path $paths {puts $fl "[lindex $path 0], [lindex $path 1], [lindex $path 2]"}
close $fl
report_timing -from [all_inputs] -to [all_outputs] -path_type summary -max_paths 10000 > syn_gen_in2out_summary.txt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 10000 -fields {timing_point cell load} > syn_gen_in2out_gate_n_loads.txt

syn_map
syn_opt
ungroup -flatten -all

update_names -verilog
#set_db bus_naming_style "%s_%d"
write_db -all_root_attributes -to_file ${op_file}_2ip.db
write_hdl -lec > ${op_file}_2ip_netlist.v
write_design -innovus -base_name ${op_file}_genus_xfer
exit
