
`timescale 1ns/1ps

`define CLK_BFM 		  	tb.clk_bfm
`define RST_BFM 		  	tb.rst_bfm
`define MM_CSR_BFM 		tb.csr_bfm
`define MM_MAX_BFM 		tb.max_bfm
`define ST_SOURCE_BFM 	tb.out_bfm

`define VERBOSITY VERBOSITY_INFO

`define DUT_DATA_W 32

`define MM_SLAVE_ADDRESS_W		1
`define MM_SLAVE_SYMBOL_W   	`DUT_DATA_W
`define MM_SLAVE_NUMSYMBOLS 	1
`define MM_SLAVE_DATA_W 		`DUT_DATA_W

`define ST_SOURCE_DATA_W 		`DUT_DATA_W