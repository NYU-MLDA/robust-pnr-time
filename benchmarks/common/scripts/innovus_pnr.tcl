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


#set init_verilog "../DC/src_area_nangate45/out/results/${TOP_DESIGN}_mapped.v"
set init_verilog "../GENUS/out/results/${TOP_DESIGN}_synthesized.v"
set init_top_cell "${TOP_DESIGN}"
set init_lef_file "$env(HOME)/freepdk-45nm/rtk-tech.lef $env(HOME)/freepdk-45nm/stdcells.lef"
set init_gnd_net "VSS"
set init_pwr_net "VDD"
set init_mmmc_file "setup-timing.tcl"

init_design
set_message -no_limit
#set_interactive_constraint_modes constraints_default
#set_max_fanout 10 [get_ports *]

#Floorplanning

floorPlan -r 1.0 0.7 4.0 4.0 4.0 4.0

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

#Power Grid
sroute -nets {VDD VSS}
addRing -nets {VDD VSS} -width 0.6 -spacing 0.5 -layer [list top 7 bottom 7 left 6 right 6]

#Adding Vertical Stripes
addStripe -nets {VSS VDD} -layer 6 -direction vertical -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5
#Adding Horizontal Stripes
addStripe -nets {VSS VDD} -layer 7 -direction horizontal -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5




#Place Ports

getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true

set ports [get_db ports .name]
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Left -layer 4 -spreadType start -spacing 1.0 -start 0.0 2.0 -pin $ports
setPinAssignMode -pinEditInBatch false


# Placement
place_opt_design

# CTS
setDesignMode -process 45
set_ccopt_property target_max_trans 0.08
set_ccopt_property target_skew 0.5
create_ccopt_clock_tree -name MY_CLK -source clk
ccopt_design


#Placing cells
#place_design

#Clock tree synthesis
#setCTSMode -engine ccopt
#setDesignMode -process 45
#set_ccopt_property target_max_trans 0.08
#set_ccopt_property target_skew 0.5
#create_ccopt_clock_tree -name MY_CLK -source clk
#ccopt_design -cts

#Routing Design
routeDesign
setFillerMode -corePrefix FILL -core "FILLCELL_X4 FILLCELL_X2 FILLCELL_X1"
addFiller

verifyConnectivity
verify_drc

saveNetlist "${RESULTS_DIR}/${TOP_DESIGN}-post-par.v"

#Extract RC parameters file

extractRC
rcOut -rc_corner typical -spef "${RESULTS_DIR}/${TOP_DESIGN}-post-par.spef"

#Real Layout file
streamOut ${OUT_DIR}/${GDS_DIR}/${TOP_DESIGN}-post-par.gds -merge "$env(HOME)/freepdk-45nm/stdcells.gds" -mapFile "$env(HOME)/freepdk-45nm/rtk-stream-out.map"

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

set fl1 [open ../GENUS/syn_gen_paths.csv r]
set lines1 [split [read $fl1] '\n']
close $fl1

set fl2 [open syn_gen_tmp.txt r]
set lines2 [split [read $fl2] '\n']
close $fl2

set fl3 [open ${REPORTS_DIR}/syn_gen_timing_info.csv w]
puts $fl3 "Launch Point, Capturing point, Data Path Delay, Number of cominational cells in data path"
for {set i 0} {$i < [llength $lines1]} {incr i} {puts $fl3 "[lindex $lines1 $i 0][lindex $lines1 $i 1][lindex $lines2 $i],[lindex $lines1 $i 2]"}
close $fl3

#Report timing
report_timing -max_paths 150000 > ${REPORTS_DIR}/timing.rpt
exit
