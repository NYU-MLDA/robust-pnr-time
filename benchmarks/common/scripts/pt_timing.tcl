suppress_message { VER-130 }

source ./config.tcl

set OUT_DIR ./out
# Reports and logs directories creation
file mkdir ${OUT_DIR}
set REPORTS_DIR "${OUT_DIR}/rpts"

# Added if you run Formality
file mkdir ${REPORTS_DIR}


# Library and Search Path variables */
#- add $search_path , use "" instead of list []
set_app_var search_path ". $search_path"


set_app_var link_library "* \
                       $target_library"
#set symbol_library = {}


read_verilog "../CDS/out/results/${TOP_DESIGN}-post-par.v"
current_design ${TOP_DESIGN}
link_design



# These clocks come from the PLL, but since we don't have
# a PLL in the design, just treat them the same to get a
# rough estimate on the gate count.
# Main clock
create_clock [get_ports ${CLK_NAME}] -period $CLOCK_PERIOD
set_clock_uncertainty -setup ${CLK_UNC_SETUP} [get_clocks ${CLK_NAME}]
set_clock_uncertainty -hold  ${CLK_UNC_HOLD} [get_clocks ${CLK_NAME}]


read_parasitics -format spef ../CDS/out/results/${TOP_DESIGN}-post-par.spef

report_timing -max_paths 1500000 -input_pins -nets -nosplit -transition_time -slack_greater_than -500 > ${REPORTS_DIR}/timing_report.rpt
exit
