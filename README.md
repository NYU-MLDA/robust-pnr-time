# robust-pnr-time

1) Clone the repository.

2) Benchmarks directory contain the benchmarks on which synthesis, place and route can be done.

3) Benchmark contain a folder name "run_*", having subfolders "GENUS", "CDS" and "DC". The "src" folder contain the source codes of the benchmark

4) "GENUS" and "DC" will have a config.tcl, file_list.f and a Makefile. The Makefile is linked to the common Makefile.common in scripts directory.

5) "file_list.f" contains the list of source files in the "src" folder. config.tcl have the necessary environment variables.

6) Copy the freepdk-45nm folder to your $HOME directory.

7) Run commands:
   
   Synthesis: Go the GENUS folder, type "make genus"
   
   Placement and rounting: Go to CDS folder, type "make pnr".
