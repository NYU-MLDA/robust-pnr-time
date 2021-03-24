make genus
grep "Data Path"  syn_gen_summary.txt | awk '{print $3}' > syn_gen_tmp.txt
make pnr_jg
