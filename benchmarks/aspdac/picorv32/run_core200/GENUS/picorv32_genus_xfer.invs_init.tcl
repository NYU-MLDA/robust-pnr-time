#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 03/14/2021 18:02:09
#
#####################################################################


read_mmmc ./picorv32_genus_xfer.mmmc.tcl

read_physical -lef {/home/abc586/freepdk-45nm/rtk-tech.lef /home/abc586/freepdk-45nm/stdcells.lef}

read_netlist ./picorv32_genus_xfer.v

init_design
