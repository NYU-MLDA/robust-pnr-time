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


set init_verilog "../DC/src_area_nangate45/out/results/${TOP_DESIGN}_mapped.v"
set init_top_cell "${TOP_DESIGN}"
set init_lef_file "$env(HOME)/freepdk-45nm/rtk-tech.lef $env(HOME)/freepdk-45nm/stdcells.lef"
set init_gnd_net "VSS"
set init_pwr_net "VDD"
set init_mmmc_file "setup-timing.tcl"

init_design
set_message -no_limit
set_interactive_constraint_modes constraints_default
set_max_fanout 10 [get_ports *]

#Floorplanning

floorPlan -r 1.0 0.7 4.0 4.0 4.0 4.0


globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose


sroute -nets {VDD VSS}

addRing -nets {VDD VSS} -width 0.6 -spacing 0.5 -layer [list top 7 bottom 7 left 6 right 6]

#Adding Vertical Stripes
addStripe -nets {VSS VDD} -layer 6 -direction vertical -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5


#Adding Horizontal Stripes
addStripe -nets {VSS VDD} -layer 7 -direction horizontal -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5

#Placing cells

place_design

#Clock tree synthesis
setCTSMode -engine ccopt
setDesignMode -process 45
set_ccopt_property target_max_trans 0.08
set_ccopt_property target_skew 0.5
create_ccopt_clock_tree -name MY_CLK -source clk
ccopt_design

routeDesign

#Adding filler cells
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

#Report timing
report_timing > ${REPORTS_DIR}/timing.rpt
exit
