module soc_hamming_hps_top (

	//CLOCK
	input			wire					clock_100m,

	//HPS DDR3
	output		wire	[14:0]		ddr3_mem_a,
	output		wire	[2:0]			ddr3_mem_ba,
	output		wire					ddr3_mem_ck,
	output		wire					ddr3_mem_ck_n,
	output		wire					ddr3_mem_cke,
	output		wire					ddr3_mem_cs_n,
	output		wire					ddr3_mem_ras_n,
	output		wire					ddr3_mem_cas_n,
	output		wire					ddr3_mem_we_n,
	output		wire					ddr3_mem_reset_n,
	inout			wire	[31:0]		ddr3_mem_dq,
	inout			wire	[3:0]			ddr3_mem_dqs,
	inout			wire	[3:0]			ddr3_mem_dqs_n,
	output		wire					ddr3_mem_odt,
	output		wire	[3:0]			ddr3_mem_dm,
	input			wire					ddr3_oct_rzqin,
	
	//HPS EMAC	
	output		wire					emac_tx_clk,
	output		wire	[3:0]			emac_txd,
	inout			wire					emac_mdio,
	output		wire					emac_mdc,
	input			wire					emac_rx_dv,
	output		wire					emac_tx_en,
	input			wire					emac_rx_clk,
	input			wire	[3:0]			emac_rxd,

	//HPS SD
	output		wire					sd_clk,		
	inout			wire					sd_cmd,
	inout			wire	[3:0]			sd_dat,

	//HPS UART
	input			wire					uart_rx,
	output		wire					uart_tx,

	//HPS TRACE
	output		wire					trace_clk,
	output		wire	[7:0]			trace_data,

	//HPS GPIO
	inout			wire	[3:0]			hps_button,
	
	//FPGA GPIO
	output		wire	[2:0]			fpga_led,
	input			wire	[2:0]			fpga_button
	);


 soc_hamming_hps uh0 (
 
	.clk_clk										(clock_100m),
	
	//HPS DDR3
	.hps_ddr3_mem_a							(ddr3_mem_a),
	.hps_ddr3_mem_ba							(ddr3_mem_ba),
	.hps_ddr3_mem_ck							(ddr3_mem_ck),
	.hps_ddr3_mem_ck_n						(ddr3_mem_ck_n),
	.hps_ddr3_mem_cke							(ddr3_mem_cke),
	.hps_ddr3_mem_cs_n						(ddr3_mem_cs_n),
	.hps_ddr3_mem_ras_n						(ddr3_mem_ras_n),
	.hps_ddr3_mem_cas_n						(ddr3_mem_cas_n),
	.hps_ddr3_mem_we_n						(ddr3_mem_we_n),
	.hps_ddr3_mem_reset_n					(ddr3_mem_reset_n),
	.hps_ddr3_mem_dq							(ddr3_mem_dq),
	.hps_ddr3_mem_dqs							(ddr3_mem_dqs),
	.hps_ddr3_mem_dqs_n						(ddr3_mem_dqs_n),
	.hps_ddr3_mem_odt							(ddr3_mem_odt),
	.hps_ddr3_mem_dm							(ddr3_mem_dm),
	.hps_ddr3_oct_rzqin						(ddr3_oct_rzqin),

	//HPS EMAC
	.hps_io_hps_io_emac1_inst_TX_CLK		(emac_tx_clk),
	.hps_io_hps_io_emac1_inst_TXD0		(emac_txd[0]),
	.hps_io_hps_io_emac1_inst_TXD1		(emac_txd[1]),
	.hps_io_hps_io_emac1_inst_TXD2		(emac_txd[2]),
	.hps_io_hps_io_emac1_inst_TXD3		(emac_txd[3]),
	.hps_io_hps_io_emac1_inst_MDIO		(emac_mdio),
	.hps_io_hps_io_emac1_inst_MDC			(emac_mdc),
	.hps_io_hps_io_emac1_inst_RX_CTL		(emac_rx_dv),
	.hps_io_hps_io_emac1_inst_TX_CTL		(emac_tx_en),
	.hps_io_hps_io_emac1_inst_RX_CLK		(emac_rx_clk),
	.hps_io_hps_io_emac1_inst_RXD0		(emac_rxd[0]),
	.hps_io_hps_io_emac1_inst_RXD1		(emac_rxd[1]),
	.hps_io_hps_io_emac1_inst_RXD2		(emac_rxd[2]),
	.hps_io_hps_io_emac1_inst_RXD3		(emac_rxd[3]),
 
 	//HPS SD
  	.hps_io_hps_io_sdio_inst_CLK			(sd_clk),	
	.hps_io_hps_io_sdio_inst_CMD			(sd_cmd),
	.hps_io_hps_io_sdio_inst_D0			(sd_dat[0]),
	.hps_io_hps_io_sdio_inst_D1			(sd_dat[1]),
	.hps_io_hps_io_sdio_inst_D2			(sd_dat[2]),
	.hps_io_hps_io_sdio_inst_D3			(sd_dat[3]),

	//HPS UART
	.hps_io_hps_io_uart0_inst_RX			(uart_rx),
	.hps_io_hps_io_uart0_inst_TX			(uart_tx),
	);	

endmodule




