if {! [is_attribute wlec_internal_to_write_lec_db_for_invocation -obj_type root]} {define_attribute -obj_type root -category lec -data_type string -help_string {Capture internal write_lec variables.} wlec_internal_to_write_lec_db_for_invocation}
if {! [is_attribute wlec_internal_to_write_lec_db_for_label -obj_type root]} {define_attribute -obj_type root -category lec -data_type string -help_string {Capture internal write_lec variables.} wlec_internal_to_write_lec_db_for_label}
if {! [is_attribute wlec_internal_to_write_lec_label_data -obj_type root]} {define_attribute -obj_type root -category lec -data_type string -help_string {Capture internal write_lec variables.} wlec_internal_to_write_lec_label_data}
set_db wlec_internal_to_write_lec_label_data {{calling_function write_lec top_design picorv32 label rtl fvdir fv/picorv32 filename N/A filename_absolute N/A} {calling_function write_lec top_design picorv32 label fv_map fvdir fv/picorv32 filename fv/picorv32/fv_map.v.gz filename_absolute /home/abc586/currentResearch/robust-pnr-time/benchmarks/aspdac/picorv32/run_core150/GENUS/fv/picorv32/fv_map.v.gz}}
set_db wlec_internal_to_write_lec_db_for_label {write_lec {picorv32 {fv_map {do_set_vars {{set env(RC_VERSION)     "18.14-s037_1"} {set env(CDN_SYNTH_ROOT) "/opt/cadence/installs/GENUS181/tools.lnx86"} {set CDN_SYNTH_ROOT      "/opt/cadence/installs/GENUS181/tools.lnx86"} {set env(CW_DIR) "/opt/cadence/installs/GENUS181/tools.lnx86/lib/chipware"} {set CW_DIR      "/opt/cadence/installs/GENUS181/tools.lnx86/lib/chipware"}} do_set_naming {{set_naming_style rc -golden} {set_naming_rule "%s\[%d\]" -instance_array -golden} {set_naming_rule "%s_reg" -register -golden} {set_naming_rule "%L.%s" "%L\[%d\].%s" "%s" -instance -golden} {set_naming_rule "%L.%s" "%L\[%d\].%s" "%s" -variable -golden}} do_set_hdl_options {{# Align LEC's treatment of mismatched port widths with constant} {# connections with Genus's. Genus message CDFG-467 and LEC message} {# HRC3.6 may indicate the presence of this issue. This option is} {# only available with LEC 17.20-d301 or later.} {set lec_version_required "17.20301"} if\ \{\$lec_version\ >=\ \$lec_version_required\}\ \{ {    set_hdl_options -const_port_extend} \} {set_hdl_options -VERILOG_INCLUDE_DIR "incdir:sep:src:cwd"}} do_set_undriven {{set_undriven_signal 0 -golden}} do_set_undefined {{# default is to error out when module definitions are missing} {set_undefined_cell black_box -noascend -both}} do_read_library {{add_search_path . /opt/cadence/installs/GENUS181/tools.lnx86/lib/tech * -library -both} {read_library -liberty -both   /home/abc586/freepdk-45nm/stdcells.lib}} do_read_rtl {{add_search_path . -design -golden} {read_design     -merge bbox -golden -lastmod -noelab -verilog2k -f file_list.f} {elaborate_design -golden -root {picorv32} -rootonly -rootonly  }} do_read_design_revised {{read_design -verilog95   -revised -lastmod -noelab fv/picorv32/fv_map.v.gz} {elaborate_design -revised -root {picorv32}}} do_uniquify {{uniquify -all -nolib -golden}} do_int_reports {report_design_data report_black_box} do_flatten {{set_flatten_model -seq_constant} {set_flatten_model -seq_constant_x_to 0} {set_flatten_model -nodff_to_dlat_zero} {set_flatten_model -nodff_to_dlat_feedback} {set_flatten_model -hier_seq_merge}} alias_file_name {singlebit {original_name fv/picorv32/fv_map.singlebit.original_name.alias.json.gz hdl_name fv/picorv32/fv_map.singlebit.hdl_name.alias.json.gz}} do_alias_mapping {{#add_name_alias fv/picorv32/fv_map.singlebit.original_name.alias.json.gz -revised} {#set_mapping_method -alias -revised} {#add_renaming_rule r1alias _reg((\\\[%w\\\])*(/U\\\$%d)*)$ @1 -type dff dlat -both}} mapping_file_name fv/picorv32/fv_map.map.do revised_hier_compare 1 retimed_modules {} unresolved_modules {} partial_sum_outputs_modules {} lock true}}}}
set_db wlec_internal_to_write_lec_db_for_invocation {write_lec {picorv32 {fvdir fv/picorv32 current_label fv_map smart_lec false exit_at_end 1 dofile_replace 0 dofile_name fv/picorv32/rtl_to_fv_map.do logfile_name fv/picorv32/rtl_to_fv_map.log outdir {} verbose 0 save_session {} checkpoint {} no_dft 0 no_lp 0 sim_lib {} sim_plus_lib 0 env_vars {} pre_read {} pre_design_read {} pre_compare {} pre_exit {} dft_constraint_file {} cw_sim {} golden_cpf {} revised_cpf {} golden_1801 {} revised_1801 {} golden_design rtl revised_design fv/picorv32/fv_map.v.gz revised_design_legacy {} hier_compare 1 flat_compare 0 no_insert_iso_in_dof 0 lp_ec_flow 0 lp_cpf_flow 0 lp_1801_flow 0 pipeline_comp_exists 0 need_retiming_lec 0 jtag_macro_exists_in_golden 0 cw_comp_list {} pipeline_comps {} vhdl_specified_as_golden {} hdl_param {} share_dp_analysis -share dft_constraints {} top_design_in_rtl picorv32 top_design_in_lec picorv32 start_time 1615758403611372 label_list {rtl fv_map} revised_design_normalized /home/abc586/currentResearch/robust-pnr-time/benchmarks/aspdac/picorv32/run_core150/GENUS/fv/picorv32/fv_map.v.gz imp_label_rev fv_map rtl_top {} auto_analyze true analyze_abort false analyze_setup false cg_declone_hier_compare true name_for_alias_flow original_name alias_flow true mapping_file_flow true add_golden_driver_info true cut_point none add_noblack_box_retime_subdesign true parallel_threads 4 compare_threads 4 hier_comp_threshold 50 low_power_analysis false write_cpf_lp_ec_flow true use_cpf_for_library true stop_after_syn_eqn_mismatch false set_cdn_synth_root false composite_compare true ncprotect_keydb true uniquify true retimed_module_uniquify true use_io_pad true use_constant_function_timing_model true use_lec_model true one_hot_mux false g1_has_iso_inserted false use_extconst false multithread_license_list {} golden_is_rtl 1 golden_cpf_files {} revised_cpf_files {} golden_1801_files {} revised_1801_files {} fvdir_list fv/picorv32 cw_vhdllib_list {} cw_model_list {} auto_verilog_detect_is_used {} all_clk clk all_test_clk {} pincon_rvz {} pincon_gdn {} generating_fv_map_info 1 rcv_vi_index 1 need_datapath_lec 1 hier_dofile_index 1}}}
