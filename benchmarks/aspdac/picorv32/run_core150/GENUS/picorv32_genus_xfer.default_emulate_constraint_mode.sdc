# ####################################################################

#  Created by Genus(TM) Synthesis Solution 18.14-s037_1 on Sun Mar 14 18:02:28 EDT 2021

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1.0fF
set_units -time 1000.0ps

# Set the current design
current_design picorv32

create_clock -name "clk" -period 0.15 -waveform {0.0 0.075} [get_ports clk]
set_clock_gating_check -setup 0.0 
