
`include "testbench_defs.sv"

module bfm_tasks;

//import packages
import verbosity_pkg::*;

task automatic initialize;
		`CLK_BFM.clock_start();
		`ST_SOURCE_BFM.init();
		`ST_SINK_A_BFM.init();
		`ST_SINK_B_BFM.init();
endtask

task automatic reset_system(input logic [7:0] reset_duration);
  `RST_BFM.reset_assert();
  #(reset_duration) `RST_BFM.reset_deassert();
  wait(`ST_SINK_A_BFM.reset == 0); 
  wait(`ST_SINK_A_BFM.reset == 0); 
  wait(`ST_SOURCE_BFM.reset == 0);
endtask

task automatic write_st_sink_a(
	input logic			[`ST_SINK_DATA_W-1:0] 	data,
	input bit											sop 			= '0,
	input bit											eop 			= '0,
	input bit			[31:0] 						idle_cycles = '0
);
	`ST_SINK_A_BFM.set_transaction_idles(idle_cycles);
	`ST_SINK_A_BFM.set_transaction_data(data); 
	`ST_SINK_A_BFM.set_transaction_sop(sop);
	`ST_SINK_A_BFM.set_transaction_eop(eop);
	`ST_SINK_A_BFM.push_transaction();
	@(`ST_SINK_A_BFM.signal_src_transaction_complete);
endtask

task automatic write_st_sink_b(
	input logic			[`ST_SINK_DATA_W-1:0] 	data,
	input bit											sop 			= '0,
	input bit											eop 			= '0,
	input bit			[31:0] 						idle_cycles = '0
);
	`ST_SINK_B_BFM.set_transaction_idles(idle_cycles);
	`ST_SINK_B_BFM.set_transaction_data(data); 
	`ST_SINK_B_BFM.set_transaction_sop(sop);
	`ST_SINK_B_BFM.set_transaction_eop(eop);
	`ST_SINK_B_BFM.push_transaction();
	@(`ST_SINK_B_BFM.signal_src_transaction_complete);
endtask


task automatic read_st_source(
	output logic		[`ST_SOURCE_DATA_W:0] 	data,
	output bit											sop,
	output bit											eop
);
	`ST_SOURCE_BFM.set_ready(1'b1);
	@(`ST_SOURCE_BFM.signal_transaction_received);
	`ST_SOURCE_BFM.pop_transaction();
	data	= `ST_SOURCE_BFM.get_transaction_data();
	eop 	= `ST_SOURCE_BFM.get_transaction_eop();
	sop 	= `ST_SOURCE_BFM.get_transaction_sop();
endtask

endmodule