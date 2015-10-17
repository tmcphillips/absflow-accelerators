# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "dut"
set QSYS_SIMDIR "dut/testbench/dut_tb/simulation"

# Source Qsys-generated script and set up alias commands used below
source $QSYS_SIMDIR/mentor/msim_setup.tcl  

# Compile device library files
dev_com

# Compile the design files in correct order
com

# Compile the additional test files
vlog -sv ./test_program.sv
vlog -sv ./top.v

# Elaborate top level design
elab

# Add to waveform viewer all the tb signals
add wave /top/tb/*
add wave /top/tb/dut_inst/mypwmled_0/*

# Log all the tb signals 
add log -r sim:/top/tb/*

# Run the sim for 1ms
run 500ns
