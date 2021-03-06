
# (C) 2001-2014 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.1 162 linux 2014.01.30.15:40:44

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "lowpass_filter_dut_tb"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/opt/altera/13.1/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
}
ensure_lib                                    ./libraries/altera_common_sv_packages/         
vmap       altera_common_sv_packages          ./libraries/altera_common_sv_packages/         
ensure_lib                                    ./libraries/dut/                               
vmap       dut                                ./libraries/dut/                               
ensure_lib                                    ./libraries/lowpass_filter_dut_inst_sink_bfm/  
vmap       lowpass_filter_dut_inst_sink_bfm   ./libraries/lowpass_filter_dut_inst_sink_bfm/  
ensure_lib                                    ./libraries/lowpass_filter_dut_inst_source_bfm/
vmap       lowpass_filter_dut_inst_source_bfm ./libraries/lowpass_filter_dut_inst_source_bfm/
ensure_lib                                    ./libraries/lowpass_filter_dut_inst_cutoff_bfm/
vmap       lowpass_filter_dut_inst_cutoff_bfm ./libraries/lowpass_filter_dut_inst_cutoff_bfm/
ensure_lib                                    ./libraries/lowpass_filter_dut_inst_reset_bfm/ 
vmap       lowpass_filter_dut_inst_reset_bfm  ./libraries/lowpass_filter_dut_inst_reset_bfm/ 
ensure_lib                                    ./libraries/lowpass_filter_dut_inst_clock_bfm/ 
vmap       lowpass_filter_dut_inst_clock_bfm  ./libraries/lowpass_filter_dut_inst_clock_bfm/ 
ensure_lib                                    ./libraries/lowpass_filter_dut_inst/           
vmap       lowpass_filter_dut_inst            ./libraries/lowpass_filter_dut_inst/           

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog -sv                                    "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                               -work work 
  vlog -sv                                    "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                        -work work 
  vlog -sv                                    "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                               -work work 
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut_hamming_avalon_st_adapter_001_data_format_adapter_0.v"                              -work work     
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut_hamming_avalon_st_adapter_data_format_adapter_0.v"                                  -work work     
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut_hamming_avalon_st_adapter_001.v"                                                    -work work     
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut_hamming_avalon_st_adapter.v"                                                        -work work         
  vlog -sv                                    "$QSYS_SIMDIR/submodules/hamming_controller.sv"                                             -L altera_common_sv_packages -work work                
  vlog -sv                                    "$QSYS_SIMDIR/submodules/priority_merge_avalon_st.sv"                                       -L altera_common_sv_packages -work work              
  vlog -sv                                    "$QSYS_SIMDIR/submodules/altera_avalon_st_splitter.sv"                                      -L altera_common_sv_packages -work work           
  vlog                                        "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                        -work work
  vlog                                        "$QSYS_SIMDIR/submodules/lowpass_filter_avalon_st.sv"                                                                    -work work                    
  vlog -sv                                    "$QSYS_SIMDIR/submodules/ordered_merge_avalon_st.sv"                                        -L altera_common_sv_packages -work work               
  vlog -sv "+incdir+$QSYS_SIMDIR/submodules/" "$QSYS_SIMDIR/submodules/constant_multiplier.sv"                                                                         -work work             
  vlog                                        "$QSYS_SIMDIR/submodules/multiply_by_constant_avalon_st.sv"                                             					  -work work                    
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut_hamming.v"                                                                          -work work                   
  vlog -sv                                    "$QSYS_SIMDIR/submodules/altera_avalon_st_sink_bfm.sv"                                      -L altera_common_sv_packages -work work                   
  vlog -sv                                    "$QSYS_SIMDIR/submodules/altera_avalon_mm_master_bfm.sv"                                    -L altera_common_sv_packages -work work                   
  vlog -sv                                    "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                     -L altera_common_sv_packages -work work                 
  vlog -sv                                    "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                     -L altera_common_sv_packages -work work                 
  vlog                                        "$QSYS_SIMDIR/submodules/hamming_dut.v"                                                                                  -work work                       
  vlog                                        "$QSYS_SIMDIR/hamming_dut_tb.v"                                                                                                                          
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L dut -L lowpass_filter_dut_inst_sink_bfm -L lowpass_filter_dut_inst_source_bfm -L lowpass_filter_dut_inst_cutoff_bfm -L lowpass_filter_dut_inst_reset_bfm -L lowpass_filter_dut_inst_clock_bfm -L lowpass_filter_dut_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L dut -L lowpass_filter_dut_inst_sink_bfm -L lowpass_filter_dut_inst_source_bfm -L lowpass_filter_dut_inst_cutoff_bfm -L lowpass_filter_dut_inst_reset_bfm -L lowpass_filter_dut_inst_clock_bfm -L lowpass_filter_dut_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
