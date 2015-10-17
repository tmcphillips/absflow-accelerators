
# 100MHz board input clock
create_clock -period 10 [get_ports clock_100m]


# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdo]


# False Path to/from HPS Peripherals:
# These have dedicated routing so we can ignore timing analysis of them
set_false_path -from * -to [get_ports {emac_*}]
set_false_path -from [get_ports {emac_*}] -to *
set_false_path -from * -to [get_ports {sd_*}]
set_false_path -from [get_ports {sd_*}] -to *
set_false_path -from * -to [get_ports {uart_*}]
set_false_path -from [get_ports {uart_*}] -to *
set_false_path -from * -to [get_ports {trace_*}]
set_false_path -from [get_ports {trace_*}] -to *
set_false_path -from * -to [get_ports {hps_button*}]
set_false_path -from [get_ports {hps_button*}] -to *

# False Path Buttons Inputs (they are asycn)
# False Path Led Outputs (they are async
set_false_path -from [get_ports {fpga_button*}] -to *
set_false_path -from * -to [get_ports {fpga_led*}]
