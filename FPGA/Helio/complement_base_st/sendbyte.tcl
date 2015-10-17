
#
set bs [lindex [get_service_paths bytestream] 0]

#
open_service bytestream $bs

#
bytestream_send $bs [list 0x41 0x54 0x43 0x47]

#
bytestream_receive $bs 4
