#!/usr/bin/tcsh

setenv BENCHMARK openroad
setenv CIRCUIT gcd
setenv CLOCK clk
setenv RESET reset
setenv MY_PERIOD 23

setenv MODULE_NAME gcd
setenv DESIGN /home/jg6476/flow_dev/MAJOR_REV_ASSURE/assure-dev/tests/$BENCHMARK/$CIRCUIT/src

setenv OP_FILE /home/jg6476/flow_dev/MAJOR_REV_ASSURE/assure-dev/tests/kc2_attack/orig/$CIRCUIT/${MODULE_NAME}_orig
mkdir -p /home/jg6476/flow_dev/MAJOR_REV_ASSURE/assure-dev/tests/kc2_attack/orig/$CIRCUIT/

/opt/cadence/installs/GENUS181/bin/genus -log log_${CIRCUIT}_synth_orig_RTL -files /home/jg6476/flow_dev/synthesis_J_cdns45.tcl
sed -i "s/locking_key/keyinput/g" ${OP_FILE}_2ip.v
sed -i 's/\/\//\//g' ${OP_FILE}_genus_xfer.mmmc.tcl

grep "Data Path"  syn_gen_reg2reg_summary.txt | awk '{print $3}' > syn_gen_reg2reg_tmp.txt
grep "Data Path"  syn_gen_in2reg_summary.txt | awk '{print $3}' > syn_gen_in2reg_tmp.txt
grep "Data Path"  syn_gen_reg2out_summary.txt | awk '{print $3}' > syn_gen_reg2out_tmp.txt
grep "Data Path"  syn_gen_in2out_summary.txt | awk '{print $3}' > syn_gen_in2out_tmp.txt

/opt/cadence/installs/INNOVUS181/bin/innovus -files gcd_v2b_innovus.tcl -log gcd_innovus -stylus

sed -i 's/,,/,/g' out/rpts/*.csv
