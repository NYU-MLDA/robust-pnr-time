#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 03/14/2021 18:02:30
#
# This file can only be run in Innovus Common UI mode.
#
#####################################################################
set read_physical_allow_multiple_port_pin_without_must_join 1


# Design Import
###########################################################
## Reading FlowKit settings file
source ./picorv32_genus_xfer.flowkit_settings.tcl

source ./picorv32_genus_xfer.invs_init.tcl

# Reading metrics file
######################
read_metric -id current ./picorv32_genus_xfer.metrics.json 

## Reading Attributes file
source ./picorv32_genus_xfer.attrs.tcl

## Reading common preserve file for dont_touch and dont_use preserve settings
source ./picorv32_genus_xfer.preserve.tcl



# Mode Setup
###########################################################
source ./picorv32_genus_xfer.mode

# Reading write_name_mapping file
#################################
if {[is_attribute -obj_type port original_name] && [is_attribute -obj_type pin original_name] && [is_attribute -obj_type pin is_phase_inverted]} {
  source ./picorv32_genus_xfer.wnm_attrs.tcl
}

eval_legacy { set edi_pe::pegConsiderMacroLayersUnblocked 1 }
eval_legacy { set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1 }
