
#CLOCK
set_location_assignment PIN_V12 -to clock_100m
#CLOCK STANDARD
set_instance_assignment -name IO_STANDARD "2.5 V" -to clock_100m

#HPS DDR3 LOCATIONS:
set_location_assignment PIN_C28 -to ddr3_mem_a[0]
set_location_assignment PIN_B28 -to ddr3_mem_a[1]
set_location_assignment PIN_E26 -to ddr3_mem_a[2]
set_location_assignment PIN_D26 -to ddr3_mem_a[3]
set_location_assignment PIN_J21 -to ddr3_mem_a[4]
set_location_assignment PIN_J20 -to ddr3_mem_a[5]
set_location_assignment PIN_C26 -to ddr3_mem_a[6]
set_location_assignment PIN_B26 -to ddr3_mem_a[7]
set_location_assignment PIN_F26 -to ddr3_mem_a[8]
set_location_assignment PIN_F25 -to ddr3_mem_a[9]
set_location_assignment PIN_A24 -to ddr3_mem_a[10]
set_location_assignment PIN_B24 -to ddr3_mem_a[11]
set_location_assignment PIN_D24 -to ddr3_mem_a[12]
set_location_assignment PIN_C24 -to ddr3_mem_a[13]
set_location_assignment PIN_G23 -to ddr3_mem_a[14]
set_location_assignment PIN_A27 -to ddr3_mem_ba[0]
set_location_assignment PIN_H25 -to ddr3_mem_ba[1]
set_location_assignment PIN_G25 -to ddr3_mem_ba[2]
set_location_assignment PIN_N21 -to ddr3_mem_ck
set_location_assignment PIN_N20 -to ddr3_mem_ck_n
set_location_assignment PIN_L28 -to ddr3_mem_cke
set_location_assignment PIN_L21 -to ddr3_mem_cs_n
set_location_assignment PIN_A25 -to ddr3_mem_ras_n
set_location_assignment PIN_A26 -to ddr3_mem_cas_n
set_location_assignment PIN_E25 -to ddr3_mem_we_n
set_location_assignment PIN_V28 -to ddr3_mem_reset_n
set_location_assignment PIN_J25 -to ddr3_mem_dq[0]
set_location_assignment PIN_J24 -to ddr3_mem_dq[1]
set_location_assignment PIN_E28 -to ddr3_mem_dq[2]
set_location_assignment PIN_D27 -to ddr3_mem_dq[3]
set_location_assignment PIN_J26 -to ddr3_mem_dq[4]
set_location_assignment PIN_K26 -to ddr3_mem_dq[5]
set_location_assignment PIN_G27 -to ddr3_mem_dq[6]
set_location_assignment PIN_F28 -to ddr3_mem_dq[7]
set_location_assignment PIN_K25 -to ddr3_mem_dq[8]
set_location_assignment PIN_L25 -to ddr3_mem_dq[9]
set_location_assignment PIN_J27 -to ddr3_mem_dq[10]
set_location_assignment PIN_J28 -to ddr3_mem_dq[11]
set_location_assignment PIN_M27 -to ddr3_mem_dq[12]
set_location_assignment PIN_M26 -to ddr3_mem_dq[13]
set_location_assignment PIN_M28 -to ddr3_mem_dq[14]
set_location_assignment PIN_N28 -to ddr3_mem_dq[15]
set_location_assignment PIN_N24 -to ddr3_mem_dq[16]
set_location_assignment PIN_N25 -to ddr3_mem_dq[17]
set_location_assignment PIN_T28 -to ddr3_mem_dq[18]
set_location_assignment PIN_U28 -to ddr3_mem_dq[19]
set_location_assignment PIN_N26 -to ddr3_mem_dq[20]
set_location_assignment PIN_N27 -to ddr3_mem_dq[21]
set_location_assignment PIN_R27 -to ddr3_mem_dq[22]
set_location_assignment PIN_V27 -to ddr3_mem_dq[23]
set_location_assignment PIN_R26 -to ddr3_mem_dq[24]
set_location_assignment PIN_R25 -to ddr3_mem_dq[25]
set_location_assignment PIN_AA28 -to ddr3_mem_dq[26]
set_location_assignment PIN_W26 -to ddr3_mem_dq[27]
set_location_assignment PIN_R24 -to ddr3_mem_dq[28]
set_location_assignment PIN_T24 -to ddr3_mem_dq[29]
set_location_assignment PIN_Y27 -to ddr3_mem_dq[30]
set_location_assignment PIN_AA27 -to ddr3_mem_dq[31]
set_location_assignment PIN_R17 -to ddr3_mem_dqs[0]
set_location_assignment PIN_R19 -to ddr3_mem_dqs[1]
set_location_assignment PIN_T19 -to ddr3_mem_dqs[2]
set_location_assignment PIN_U19 -to ddr3_mem_dqs[3]
set_location_assignment PIN_R16 -to ddr3_mem_dqs_n[0]
set_location_assignment PIN_R18 -to ddr3_mem_dqs_n[1]
set_location_assignment PIN_T18 -to ddr3_mem_dqs_n[2]
set_location_assignment PIN_T20 -to ddr3_mem_dqs_n[3]
set_location_assignment PIN_D28 -to ddr3_mem_odt
set_location_assignment PIN_G28 -to ddr3_mem_dm[0]
set_location_assignment PIN_P28 -to ddr3_mem_dm[1]
set_location_assignment PIN_W28 -to ddr3_mem_dm[2]
set_location_assignment PIN_AB28 -to ddr3_mem_dm[3]
set_location_assignment PIN_D25 -to ddr3_oct_rzqin
#HPS DDR3 STANDARDS:
puts " important: Qsys creates a separate script to create assignments for hps sdram"
puts " important: This script must be run AFTER successful synthesis:"
puts "           <system_name>/synthesis/submodules/hps_sdram_p0_pin_assignments.tcl"
puts " important: compare before/after to make sure assignments are created"


#HPS EMAC LOCATIONS:
set_location_assignment PIN_J15 -to emac_tx_clk
set_location_assignment PIN_A16 -to emac_txd[0]
set_location_assignment PIN_J14 -to emac_txd[1]
set_location_assignment PIN_A15 -to emac_txd[2]
#----purposeful error on txd[3]
#does it cause compile error?
set_location_assignment PIN_D17 -to emac_txd[3]
#----
set_location_assignment PIN_E16 -to emac_mdio
set_location_assignment PIN_A13 -to emac_mdc
set_location_assignment PIN_J13 -to emac_rx_dv
set_location_assignment PIN_A12 -to emac_tx_en
set_location_assignment PIN_J12 -to emac_rx_clk
set_location_assignment PIN_A14 -to emac_rxd[0]
set_location_assignment PIN_A11 -to emac_rxd[1]
#----purposeful error on rxd[2]
#does it cause compile error?
set_location_assignment PIN_C15 -to emac_rxd[2]
#----
set_location_assignment PIN_A9 -to emac_rxd[3]
#HPS EMAC STANDARDS:
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_tx_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_mdio
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_mdc
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_rx_dv
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_tx_en
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_rx_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to emac_rxd


#HPS SD LOCATIONS:
set_location_assignment PIN_B8 -to sd_clk
set_location_assignment PIN_D14 -to sd_cmd
set_location_assignment PIN_C13 -to sd_dat[0]
set_location_assignment PIN_B6 -to sd_dat[1]
set_location_assignment PIN_B11 -to sd_dat[2]
set_location_assignment PIN_B9 -to sd_dat[3]
#HPS SD STANDARDS:
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to sd_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to sd_cmd
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to sd_dat


#HPS UART LOCATIONS:
set_location_assignment PIN_B19 -to uart_rx
set_location_assignment PIN_C16 -to uart_tx
#HPS UART STANDARDS:
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to uart_rx
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to uart_tx


#HPS TRACE LOCATIONS:
set_location_assignment PIN_C21 -to trace_clk
set_location_assignment PIN_A22 -to trace_data[0]
set_location_assignment PIN_B21 -to trace_data[1]
set_location_assignment PIN_A21 -to trace_data[2]
set_location_assignment PIN_K18 -to trace_data[3]
set_location_assignment PIN_A20 -to trace_data[4]
set_location_assignment PIN_J18 -to trace_data[5]
set_location_assignment PIN_A19 -to trace_data[6]
set_location_assignment PIN_C18 -to trace_data[7]
#HPS TRACE STANDARDS:
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to trace_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to trace_data


#HPS BUTTON LOCATIONS:
set_location_assignment PIN_T17 -to hps_button[3]
set_location_assignment PIN_T16 -to hps_button[2]
set_location_assignment PIN_Y28 -to hps_button[1]
set_location_assignment PIN_Y26 -to hps_button[0]
#HPS BUTTON STANDARDS:
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to hps_button


#FPGA LED LOCATIONS:
set_location_assignment PIN_U9 -to fpga_led[0]
set_location_assignment PIN_AD4 -to fpga_led[1]
set_location_assignment PIN_V10 -to fpga_led[2]
set_location_assignment PIN_AC4 -to fpga_led[3]
#FPGA LED STANDARDS:
set_instance_assignment -name IO_STANDARD "2.5 V" -to fpga_led


#FPGA BUTTON LOCATIONS:
set_location_assignment PIN_Y4 -to fpga_button[0]
set_location_assignment PIN_Y8 -to fpga_button[1]
set_location_assignment PIN_Y5 -to fpga_button[2]
#FPGA BUTTON STANDARDS:
set_instance_assignment -name IO_STANDARD "2.5 V" -to fpga_button