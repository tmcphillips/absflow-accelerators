
# get path to JTAG master service
set jm [lindex [get_service_paths master] 0]

# open the JTAG master service
open_service master $jm

# read the system id
master_read_8 $jm 0x0000000 1

# close the JTAG master service
# close_service master $jm
