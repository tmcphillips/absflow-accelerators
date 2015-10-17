 
# get path to JTAG master service
set jm_path [lindex [get_service_paths master] 0]

# open the JTAG master service
open_service master $jm_path

# read
master_read_8 $jm_path 0x0000000 1
