# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "tb"
set QSYS_SIMDIR "testbench"

# Source Qsys-generated script and set up alias commands used below
source msim_setup.tcl  

# Compile device library files
dev_com

# Compile the design files in correct order
com

# Compile the additional test files
vlog -sv ./bfm_helpers.sv
vlog -sv ./test_program.sv
vlog -sv ./top.v

# Elaborate top level design
elab

# Add to waveform viewer all the tb signals
add wave /top/tb/*
add wave /top/tb/dut/ordered_merge/*

# Log all the tb signals 
#add log -r sim:/lowpass_filter_dut_tb/*

# Run the sim for 1ms
run 1000ns
