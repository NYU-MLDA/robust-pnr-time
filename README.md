# Implementation of ASPDAC 2021 paper: "Read your circuit: Leveraging word embedding to guide logic optimization"


1) Benchmarks/aspdac directory contain the designs on which synthesis, place and route can be done.

3) Each design have a folder "template" having subfolder "GENUS". The "src" folder contain the source codes.

4) "GENUS" have a config.tcl, file_list.f and a Makefile. The Makefile is linked to the common Makefile.common in scripts directory.

5) "file_list.f" contains the list of source files in the "src" folder. config.tcl have the necessary environment variables.

6) Copy the freepdk-45nm folder to your $HOME directory.

7) Run commands (inside template folder):
   
   Synthesis: **_make genus_**
   Placement and rounting: **_make pnr_jg_**
   
8) Run the following scripts to extract timing data:

   Timing report and input features: **_python3 etGen.py -t ../../benchmarks/aspdac/picosoc/template/GENUS/out/results/picosoc_generic_timing.rpt -d [TargetCT] -o [output data dump folder]_**
   
   Timing report post techmap: **_python3 etGen.py -t ../../benchmarks/aspdac/picosoc/template/GENUS/out/results/picosoc_techmap_timing.rpt -o [output data dump folder]_**
   
   Timing report post PnR: **_python3 etGen.py -t ../../benchmarks/aspdac/picosoc/template/GENUS/out_pnr/rpts/timing.rpt -o [output data dump folder]_**

   
