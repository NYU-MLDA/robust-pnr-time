###################################################################

# Created by write_sdc on Wed Feb 24 19:08:14 2021

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_fanout 2 [current_design]
set_max_transition 150 [current_design]
set_max_area 0
set_load -pin_load 1.844 [get_ports req_rdy]
set_load -pin_load 1.844 [get_ports {resp_msg[15]}]
set_load -pin_load 1.844 [get_ports {resp_msg[14]}]
set_load -pin_load 1.844 [get_ports {resp_msg[13]}]
set_load -pin_load 1.844 [get_ports {resp_msg[12]}]
set_load -pin_load 1.844 [get_ports {resp_msg[11]}]
set_load -pin_load 1.844 [get_ports {resp_msg[10]}]
set_load -pin_load 1.844 [get_ports {resp_msg[9]}]
set_load -pin_load 1.844 [get_ports {resp_msg[8]}]
set_load -pin_load 1.844 [get_ports {resp_msg[7]}]
set_load -pin_load 1.844 [get_ports {resp_msg[6]}]
set_load -pin_load 1.844 [get_ports {resp_msg[5]}]
set_load -pin_load 1.844 [get_ports {resp_msg[4]}]
set_load -pin_load 1.844 [get_ports {resp_msg[3]}]
set_load -pin_load 1.844 [get_ports {resp_msg[2]}]
set_load -pin_load 1.844 [get_ports {resp_msg[1]}]
set_load -pin_load 1.844 [get_ports {resp_msg[0]}]
set_load -pin_load 1.844 [get_ports resp_val]
create_clock [get_ports clk]  -period 2  -waveform {0 1}
set_clock_uncertainty -setup 0.5  [get_clocks clk]
set_clock_uncertainty -hold 0.3  [get_clocks clk]
