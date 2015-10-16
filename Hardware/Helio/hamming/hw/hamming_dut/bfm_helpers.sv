
`include "testbench_defs.sv"

module bfm_tasks;

//import packages
import verbosity_pkg::*;
import avalon_mm_pkg::*;

task automatic initialize;
	`CLK_BFM.clock_start();
	`MM_CSR_BFM.init();	
	`MM_MAX_BFM.init();	
	`ST_SOURCE_BFM.init();
endtask

task automatic reset_system(input logic [7:0] reset_duration);
	`RST_BFM.reset_assert();
	#(reset_duration) `RST_BFM.reset_deassert();
	wait(`MM_CSR_BFM.reset == 0);
	wait(`MM_MAX_BFM.reset == 0);
	wait(`ST_SOURCE_BFM.reset == 0);
endtask

task automatic write_mm_csr(
	input	logic			[`MM_SLAVE_ADDRESS_W-1:0] 	addr,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		data,
	input logic			[`MM_SLAVE_NUMSYMBOLS-1:0] byte_enable,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		idle,
	input logic			[31:0] 					init_latency
);
	`MM_CSR_BFM.set_command_request(REQ_WRITE);
	`MM_CSR_BFM.set_command_address(addr);    
	`MM_CSR_BFM.set_command_byte_enable(byte_enable,0);
	`MM_CSR_BFM.set_command_idle(idle, 0);
	`MM_CSR_BFM.set_command_init_latency(init_latency);
	`MM_CSR_BFM.set_command_data(data, 0);      
	`MM_CSR_BFM.push_command();
	 @(`MM_CSR_BFM.signal_all_transactions_complete);
	`MM_CSR_BFM.pop_response();
endtask

task automatic read_mm_csr(
	input	logic			[`MM_SLAVE_ADDRESS_W-1:0] 	addr,
	output logic		[`MM_SLAVE_DATA_W-1:0] 		data,
	input logic			[`MM_SLAVE_NUMSYMBOLS-1:0] byte_enable,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		idle,
	input logic			[31:0] 					init_latency
);
	`MM_CSR_BFM.set_command_request(REQ_READ);
	`MM_CSR_BFM.set_command_address(addr);    
	`MM_CSR_BFM.set_command_byte_enable(byte_enable,0);
	`MM_CSR_BFM.set_command_idle(idle, 0);
	`MM_CSR_BFM.set_command_init_latency(init_latency);
	`MM_CSR_BFM.push_command();
	 @(`MM_CSR_BFM.signal_all_transactions_complete);
	`MM_CSR_BFM.pop_response();
	data = `MM_CSR_BFM.get_response_data(0);	
endtask

task automatic write_mm_max(
	input	logic			[`MM_SLAVE_ADDRESS_W-1:0] 	addr,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		data,
	input logic			[`MM_SLAVE_NUMSYMBOLS-1:0] byte_enable,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		idle,
	input logic			[31:0] 					init_latency
);
	`MM_MAX_BFM.set_command_request(REQ_WRITE);
	`MM_MAX_BFM.set_command_address(addr);    
	`MM_MAX_BFM.set_command_byte_enable(byte_enable,0);
	`MM_MAX_BFM.set_command_idle(idle, 0);
	`MM_MAX_BFM.set_command_init_latency(init_latency);
	`MM_MAX_BFM.set_command_data(data, 0);      
	`MM_MAX_BFM.push_command();
	 @(`MM_MAX_BFM.signal_all_transactions_complete);
	`MM_MAX_BFM.pop_response();
endtask

task automatic read_mm_max(
	input	logic			[`MM_SLAVE_ADDRESS_W-1:0] 	addr,
	output logic		[`MM_SLAVE_DATA_W-1:0] 		data,
	input logic			[`MM_SLAVE_NUMSYMBOLS-1:0] byte_enable,
	input logic			[`MM_SLAVE_DATA_W-1:0] 		idle,
	input logic			[31:0] 					init_latency
);
	`MM_MAX_BFM.set_command_request(REQ_READ);
	`MM_MAX_BFM.set_command_address(addr);    
	`MM_MAX_BFM.set_command_byte_enable(byte_enable,0);
	`MM_MAX_BFM.set_command_idle(idle, 0);
	`MM_MAX_BFM.set_command_init_latency(init_latency);
	`MM_MAX_BFM.push_command();
	 @(`MM_MAX_BFM.signal_all_transactions_complete);
	`MM_MAX_BFM.pop_response();
	data = `MM_MAX_BFM.get_response_data(0);	
endtask

task automatic read_st_source(
	output logic		[`ST_SOURCE_DATA_W:0] 	data,
	output bit											sop,
	output bit											eop
);
	`ST_SOURCE_BFM.set_ready(1'b1);
	@(`ST_SOURCE_BFM.signal_transaction_received);
	`ST_SOURCE_BFM.pop_transaction();
	data = `ST_SOURCE_BFM.get_transaction_data();
	eop = `ST_SOURCE_BFM.get_transaction_eop();
	sop = `ST_SOURCE_BFM.get_transaction_sop();
endtask

endmodule