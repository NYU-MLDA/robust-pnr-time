

create_rc_corner -name typical -cap_table "$env(HOME)/freepdk-45nm/rtk-typical.captable" -T 25

create_library_set -name libs_typical -timing [list "$env(HOME)/freepdk-45nm/stdcells.lib"]

create_delay_corner -name delay_default -early_library_set libs_typical -late_library_set libs_typical -rc_corner typical

create_constraint_mode -name constraints_default -sdc_files [list ../GENUS/out/results/${TOP_DESIGN}.final.sdc]

create_analysis_view -name analysis_default -constraint_mode constraints_default -delay_corner delay_default

set_analysis_view -setup [list analysis_default] -hold [list analysis_default]
