###############################################################
#  Generated by:      Cadence Innovus 18.13-s088_1
#  OS:                Linux x86_64(Host ID hansolo.poly.edu)
#  Generated on:      Sun Mar 14 20:06:40 2021
#  Design:            picorv32
#  Command:           write_db out/post_impl.final
###############################################################
current_design picorv32
set_clock_gating_check -rise -setup 0 
set_clock_gating_check -fall -setup 0 
create_clock [get_ports {clk}]  -name clk -period 0.200000 -waveform {0.000000 0.100000}
set_propagated_clock  [get_ports {clk}]
