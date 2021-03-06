# TCL File Generated by Component Editor 13.1
# Tue Mar 25 15:14:36 PDT 2014
# DO NOT MODIFY


# 
# lowpass_filter_avalon_st "Avalon ST Lowpass Filter" v1.0
#  2014.03.25.15:14:36
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module lowpass_filter_avalon_st
# 
set_module_property DESCRIPTION ""
set_module_property NAME lowpass_filter_avalon_st
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "Avalon ST Lowpass Filter"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL lowpass_filter_avalon_st
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file lowpass_filter_avalon_st.sv VERILOG PATH lowpass_filter_avalon_st.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL lowpass_filter_avalon_st
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file lowpass_filter_avalon_st.sv VERILOG PATH lowpass_filter_avalon_st.sv


# 
# parameters
# 
add_parameter IN_WIDTH INTEGER 8
set_parameter_property IN_WIDTH DEFAULT_VALUE 8
set_parameter_property IN_WIDTH DISPLAY_NAME IN_WIDTH
set_parameter_property IN_WIDTH TYPE INTEGER
set_parameter_property IN_WIDTH UNITS None
set_parameter_property IN_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property IN_WIDTH HDL_PARAMETER true
add_parameter OUT_WIDTH INTEGER 8
set_parameter_property OUT_WIDTH DEFAULT_VALUE 8
set_parameter_property OUT_WIDTH DISPLAY_NAME OUT_WIDTH
set_parameter_property OUT_WIDTH TYPE INTEGER
set_parameter_property OUT_WIDTH UNITS None
set_parameter_property OUT_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property OUT_WIDTH HDL_PARAMETER true
add_parameter DEFAULT_CUTOFF INTEGER -1
set_parameter_property DEFAULT_CUTOFF DEFAULT_VALUE -1
set_parameter_property DEFAULT_CUTOFF DISPLAY_NAME DEFAULT_CUTOFF
set_parameter_property DEFAULT_CUTOFF TYPE INTEGER
set_parameter_property DEFAULT_CUTOFF UNITS None
set_parameter_property DEFAULT_CUTOFF ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DEFAULT_CUTOFF HDL_PARAMETER true
add_parameter FORWARD_DELIMITERS INTEGER 0
set_parameter_property FORWARD_DELIMITERS DEFAULT_VALUE 0
set_parameter_property FORWARD_DELIMITERS DISPLAY_NAME FORWARD_DELIMITERS
set_parameter_property FORWARD_DELIMITERS TYPE INTEGER
set_parameter_property FORWARD_DELIMITERS UNITS None
set_parameter_property FORWARD_DELIMITERS ALLOWED_RANGES -2147483648:2147483647
set_parameter_property FORWARD_DELIMITERS HDL_PARAMETER true
add_parameter EOP_ON_EXCEED INTEGER 0
set_parameter_property EOP_ON_EXCEED DEFAULT_VALUE 0
set_parameter_property EOP_ON_EXCEED DISPLAY_NAME EOP_ON_EXCEED
set_parameter_property EOP_ON_EXCEED TYPE INTEGER
set_parameter_property EOP_ON_EXCEED UNITS None
set_parameter_property EOP_ON_EXCEED ALLOWED_RANGES -2147483648:2147483647
set_parameter_property EOP_ON_EXCEED HDL_PARAMETER true
add_parameter NEW_EOP_VALUE INTEGER 0
set_parameter_property NEW_EOP_VALUE DEFAULT_VALUE 0
set_parameter_property NEW_EOP_VALUE DISPLAY_NAME NEW_EOP_VALUE
set_parameter_property NEW_EOP_VALUE TYPE INTEGER
set_parameter_property NEW_EOP_VALUE UNITS None
set_parameter_property NEW_EOP_VALUE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property NEW_EOP_VALUE HDL_PARAMETER true


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point cutoff
# 
add_interface cutoff avalon end
set_interface_property cutoff addressUnits WORDS
set_interface_property cutoff associatedClock clock
set_interface_property cutoff associatedReset reset
set_interface_property cutoff bitsPerSymbol 8
set_interface_property cutoff burstOnBurstBoundariesOnly false
set_interface_property cutoff burstcountUnits WORDS
set_interface_property cutoff explicitAddressSpan 0
set_interface_property cutoff holdTime 0
set_interface_property cutoff linewrapBursts false
set_interface_property cutoff maximumPendingReadTransactions 0
set_interface_property cutoff readLatency 0
set_interface_property cutoff readWaitTime 1
set_interface_property cutoff setupTime 0
set_interface_property cutoff timingUnits Cycles
set_interface_property cutoff writeWaitTime 0
set_interface_property cutoff ENABLED true
set_interface_property cutoff EXPORT_OF ""
set_interface_property cutoff PORT_NAME_MAP ""
set_interface_property cutoff CMSIS_SVD_VARIABLES ""
set_interface_property cutoff SVD_ADDRESS_GROUP ""

add_interface_port cutoff cutoff_write write Input 1
add_interface_port cutoff cutoff_read read Input 1
add_interface_port cutoff cutoff_readdata readdata Output OUT_WIDTH
add_interface_port cutoff cutoff_writedata writedata Input OUT_WIDTH
set_interface_assignment cutoff embeddedsw.configuration.isFlash 0
set_interface_assignment cutoff embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment cutoff embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment cutoff embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock clk Input 1


# 
# connection point in
# 
add_interface in avalon_streaming end
set_interface_property in associatedClock clock
set_interface_property in associatedReset reset
set_interface_property in dataBitsPerSymbol 1
set_interface_property in errorDescriptor ""
set_interface_property in firstSymbolInHighOrderBits true
set_interface_property in maxChannel 0
set_interface_property in readyLatency 0
set_interface_property in ENABLED true
set_interface_property in EXPORT_OF ""
set_interface_property in PORT_NAME_MAP ""
set_interface_property in CMSIS_SVD_VARIABLES ""
set_interface_property in SVD_ADDRESS_GROUP ""

add_interface_port in in_data data Input IN_WIDTH
add_interface_port in in_ready ready Output 1
add_interface_port in in_valid valid Input 1
add_interface_port in in_startofpacket startofpacket Input 1
add_interface_port in in_endofpacket endofpacket Input 1


# 
# connection point out
# 
add_interface out avalon_streaming start
set_interface_property out associatedClock clock
set_interface_property out associatedReset reset
set_interface_property out dataBitsPerSymbol 8
set_interface_property out errorDescriptor ""
set_interface_property out firstSymbolInHighOrderBits true
set_interface_property out maxChannel 0
set_interface_property out readyLatency 0
set_interface_property out ENABLED true
set_interface_property out EXPORT_OF ""
set_interface_property out PORT_NAME_MAP ""
set_interface_property out CMSIS_SVD_VARIABLES ""
set_interface_property out SVD_ADDRESS_GROUP ""

add_interface_port out out_ready ready Input 1
add_interface_port out out_valid valid Output 1
add_interface_port out out_data data Output OUT_WIDTH
add_interface_port out out_startofpacket startofpacket Output 1
add_interface_port out out_endofpacket endofpacket Output 1


# 
# connection point busy
# 
add_interface busy conduit end
set_interface_property busy associatedClock clock
set_interface_property busy associatedReset reset
set_interface_property busy ENABLED true
set_interface_property busy EXPORT_OF ""
set_interface_property busy PORT_NAME_MAP ""
set_interface_property busy CMSIS_SVD_VARIABLES ""
set_interface_property busy SVD_ADDRESS_GROUP ""

add_interface_port busy wait_for_eop export Output 1

