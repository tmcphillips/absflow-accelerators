# TCL File Generated by Component Editor 13.1
# Tue Mar 04 22:34:15 PST 2014
# DO NOT MODIFY


# 
# st_to_mm_adapter "Avalon ST to MM Adapter" v1.0
#  2014.03.04.22:34:15
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module st_to_mm_adapter
# 
set_module_property DESCRIPTION ""
set_module_property NAME st_to_mm_adapter
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "Avalon ST to MM Adapter"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL st_to_mm_adapter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file st_to_mm_adapter.sv SYSTEM_VERILOG PATH st_to_mm_adapter.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL st_to_mm_adapter
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file st_to_mm_adapter.sv SYSTEM_VERILOG PATH st_to_mm_adapter.sv


# 
# parameters
# 
add_parameter WIDTH INTEGER 8
set_parameter_property WIDTH DEFAULT_VALUE 8
set_parameter_property WIDTH DISPLAY_NAME WIDTH
set_parameter_property WIDTH TYPE INTEGER
set_parameter_property WIDTH UNITS None
set_parameter_property WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WIDTH HDL_PARAMETER true


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
# connection point avalon_mm_out
# 
add_interface avalon_mm_out avalon end
set_interface_property avalon_mm_out addressUnits WORDS
set_interface_property avalon_mm_out associatedClock clock
set_interface_property avalon_mm_out associatedReset reset
set_interface_property avalon_mm_out bitsPerSymbol 8
set_interface_property avalon_mm_out burstOnBurstBoundariesOnly false
set_interface_property avalon_mm_out burstcountUnits WORDS
set_interface_property avalon_mm_out explicitAddressSpan 0
set_interface_property avalon_mm_out holdTime 0
set_interface_property avalon_mm_out linewrapBursts false
set_interface_property avalon_mm_out maximumPendingReadTransactions 0
set_interface_property avalon_mm_out readLatency 0
set_interface_property avalon_mm_out readWaitTime 1
set_interface_property avalon_mm_out setupTime 0
set_interface_property avalon_mm_out timingUnits Cycles
set_interface_property avalon_mm_out writeWaitTime 0
set_interface_property avalon_mm_out ENABLED true
set_interface_property avalon_mm_out EXPORT_OF ""
set_interface_property avalon_mm_out PORT_NAME_MAP ""
set_interface_property avalon_mm_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_mm_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_mm_out out_readdata readdata Output WIDTH
add_interface_port avalon_mm_out out_read read Input 1
add_interface_port avalon_mm_out out_waitrequest waitrequest Output 1
add_interface_port avalon_mm_out out_address address Input 1
set_interface_assignment avalon_mm_out embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_mm_out embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_mm_out embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_mm_out embeddedsw.configuration.isPrintableDevice 0


# 
# connection point avalon_st_in
# 
add_interface avalon_st_in avalon_streaming end
set_interface_property avalon_st_in associatedClock clock
set_interface_property avalon_st_in associatedReset reset
set_interface_property avalon_st_in dataBitsPerSymbol 8
set_interface_property avalon_st_in errorDescriptor ""
set_interface_property avalon_st_in firstSymbolInHighOrderBits true
set_interface_property avalon_st_in maxChannel 0
set_interface_property avalon_st_in readyLatency 0
set_interface_property avalon_st_in ENABLED true
set_interface_property avalon_st_in EXPORT_OF ""
set_interface_property avalon_st_in PORT_NAME_MAP ""
set_interface_property avalon_st_in CMSIS_SVD_VARIABLES ""
set_interface_property avalon_st_in SVD_ADDRESS_GROUP ""

add_interface_port avalon_st_in in_ready ready Output 1
add_interface_port avalon_st_in in_valid valid Input 1
add_interface_port avalon_st_in in_data data Input WIDTH
add_interface_port avalon_st_in in_sop startofpacket Input 1
add_interface_port avalon_st_in in_eop endofpacket Input 1
