# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "dut"
set QSYS_SIMDIR "complement_st_dut/testbench/"

# Source Qsys-generated script and set up alias commands used below
source $QSYS_SIMDIR/mentor/msim_setup.tcl  

# Compile device library files
dev_com

# Compile the design files in correct orderbfm
com

# Compile the additional test files
vlog -sv ./test_program.sv
vlog -sv ./complement_st_sim_top.v

# Elaborate top level design
elab

# Add to waveform viewer all the tb signals
add wave -position insertpoint sim:/complement_st_dut_tb/complement_st_dut_inst/complement_base_st_0/*

# Log all the tb signals 
add log -r sim:/complement_st_dut_tb/complement_st_dut_inst/complement_base_st_0/*

# Run the sim for 1ms
run 500ns
