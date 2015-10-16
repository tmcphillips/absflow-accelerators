//----------------------------------------------------------------------------------------------
// Test Program
//
// Ultra-simple program to do some writes and reads to our custom component
// There are two verilog Tasks written to aid in the repetitive "push" and "pop" of commands
//   to the avalon-mm master BFM
//----------------------------------------------------------------------------------------------

//timescale
`timescale 1ns/1ps

//-------------
// DEFINES TO EACH BFM
//-------------
`define CLK tb.dut_inst_mypwmled_0_clock_input_bfm
`define RST tb.dut_inst_mypwmled_0_reset_input_bfm
`define MSTR_BFM tb.dut_inst_mypwmled_0_avalon_mm_slave_bfm

// console messaging level for all BFMs
`define VERBOSITY VERBOSITY_INFO

// Paramters for MSTRBFM
`define AV_ADDRESS_W 16
`define AV_SYMBOL_W 8
`define AV_NUMSYMBOLS 4
`define INDEX_ZERO 0

// derived parameters
`define AV_DATA_W (`AV_SYMBOL_W * `AV_NUMSYMBOLS)

//-------------
// TEST_PROGRAM
//-------------

module test_program();

//import packages
import verbosity_pkg::*;
import avalon_mm_pkg::*;

//local variables
Request_t command_request, response_request;
reg [`AV_ADDRESS_W-1:0] command_addr, response_addr;
reg [`AV_DATA_W-1:0] command_data, response_data;
reg [`AV_NUMSYMBOLS-1:0] byte_enable;
reg [`AV_DATA_W-1:0] idle;  
integer init_latency;   
event start_test;

//start the clock and apply reset
initial
	begin
	`CLK.clock_start();
	`RST.reset_assert();
	#100 `RST.reset_deassert();
	end

//init the master BFM 
initial
  begin
    set_verbosity(`VERBOSITY);
    `MSTR_BFM.init();	
	//wait for reset to de-assert and trigger start_test event
    wait(`MSTR_BFM.reset == 0);
	-> start_test;
  end

//-------------
// TEST
//-------------
initial
	begin
	@start_test;
	byte_enable = '1;  //all byte lanes are used
	idle = 1;  //one idle cycle between each command of the master BFM
	init_latency = 0;  //the command is launched to Avalon bus with no delay
  
 	//read the control_reg (address 0) value after reset
 	command_addr = 16'h0;
	master_set_and_push_command(REQ_READ, command_addr, command_data, byte_enable, idle,init_latency);
   @(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data);
   
 	//read the scratch_reg (address 1) value after reset
 	command_addr = 16'h1;
	master_set_and_push_command(REQ_READ, command_addr, command_data, byte_enable, idle,init_latency);
   @(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data);  
 	
	//do a write-then-read of control_reg (address 0)
	command_addr = 16'b0;
 	master_set_and_push_command(REQ_WRITE, command_addr, 32'h12345678, byte_enable, idle, init_latency);
	@(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data);
	master_set_and_push_command(REQ_READ, command_addr, command_data, byte_enable, idle,init_latency);
   @(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data);    

	//do a write-then-read of scratch_reg (address 1)
	command_addr = 16'b0;
 	master_set_and_push_command(REQ_WRITE, command_addr, 32'h5555aaaa, byte_enable, idle, init_latency);
	@(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data);
	master_set_and_push_command(REQ_READ, command_addr, command_data, byte_enable, idle,init_latency);
   @(`MSTR_BFM.signal_all_transactions_complete)
   master_pop_and_get_response(response_request, response_addr, response_data); 

 	
	end
	
//-------------
// TASKS
//-------------

//this task sets the command descriptor for master BFM and push it to the queue
task master_set_and_push_command;
input Request_t request;
input [`AV_ADDRESS_W-1:0] addr;
input [`AV_DATA_W-1:0] data;
input [`AV_NUMSYMBOLS-1:0] byte_enable;
input [`AV_DATA_W-1:0] idle;
input [31:0] init_latency;

	begin
	`MSTR_BFM.set_command_request(request);
	`MSTR_BFM.set_command_address(addr);    
	`MSTR_BFM.set_command_byte_enable(byte_enable,`INDEX_ZERO);
	`MSTR_BFM.set_command_idle(idle, `INDEX_ZERO);
	`MSTR_BFM.set_command_init_latency(init_latency);
	if (request == REQ_WRITE)
		begin
		`MSTR_BFM.set_command_data(data, `INDEX_ZERO);      
		end
	`MSTR_BFM.push_command();
	end
	
endtask


//this task pops the response received by master BFM from queue
task master_pop_and_get_response;
output Request_t request;
output [`AV_ADDRESS_W-1:0] addr;
output [`AV_DATA_W-1:0] data;

	begin
	`MSTR_BFM.pop_response();
	request = Request_t' (`MSTR_BFM.get_response_request());
	addr = `MSTR_BFM.get_response_address();
	data = `MSTR_BFM.get_response_data(`INDEX_ZERO);	
	end
	
endtask

endmodule
