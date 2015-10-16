

proc mmopen { {index 0} } {
  global mm
  puts "Opening JTAG master service: "
  puts [set mm [lindex [get_service_paths master] $index]]
  open_service master $mm
}

proc mmclose {} {
  global mm
  close_service master $mm
  puts "Closed JTAG master service"
}

proc mmread8 {address {addressCount 1} {repeatCount 1}} {
  global mm
  for {set i 0} {$i < $repeatCount} {incr i} {
    puts [master_read_8 $mm $address $addressCount]
  }
}

proc mmread16 {address {count 1}} {
  global mm
  master_read_16 $mm $address $count
}

proc mmread32 {address {count 1}} {
  global mm
  master_read_32 $mm $address $count
}

proc mmwrite8 {address args} {
  global mm
  if { [llength args] == 1 } {
    master_write_8 $mm $address $args 
  } else {
    master_write_8 $mm $address[list $args]
  }
}

proc mmwrite16 {address args} {
  global mm
  if { [llength args] == 1 } {
    master_write_16 $mm $address $args 
  } else {
    master_write_16 $mm $address[list $args]
  }
}

proc mmwrite32 {address args} {
  global mm
  if { [llength args] == 1 } {
    master_write_32 $mm $address $args 
  } else {
    master_write_32 $mm $address[list $args]
  }
}

proc stopen { {index 0} } {
  global bs
  puts "Opening JTAG bytestream $index: "
  puts [set bs($index) [lindex [get_service_paths bytestream] $index]]
  open_service bytestream $bs($index)
}

proc stwrite { {index 0} args } {
  global bs
  puts "Writing bytestream $index:"
  puts $bs($index)
  if { [llength args] == 1 } {
    bytestream_send $bs($index) $args 
  } else {
    bytestream_send $bs($index) [list $args]
  }
}

proc stread { {index 0} {count 1} } {
  global bs
  puts "Reading bytestream $index:"
  puts $bs($index)
  bytestream_receive $bs($index) $count
}

proc stclose { {index 0}} {
  global bs
  close_service bytestream $bs($index)
  puts "Closed JTAG bytestream $index:"
  puts $bs($index)
}

proc reset {} {
  puts "Resetting system via JTAG debug service..."
  set jd [lindex [get_service_paths jtag_debug] 1]
  open_service jtag_debug $jd
  jtag_debug_reset_system $jd
  close_service jtag_debug $jd
  puts "System reset complete."
}

proc run { {max 15} } {
  global mm
  mmopen 1
  mmwrite8 0xff210050 $max
  mmwrite8 0xff210060 1
  while {1} {
    set v [master_read_8 $mm 0xff210040 1]
    if { [string equal $v "0xff"] } { break }
    puts $v
  }
  mmclose
}