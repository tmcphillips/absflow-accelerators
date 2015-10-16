
# get path to the JTAG debug service
set jd_path [lindex [get_service_paths jtag_debug] 0]

# open the JTAG debug service
open_service jtag_debug $jd_path

# reset the system
jtag_debug_reset_system $jd_path