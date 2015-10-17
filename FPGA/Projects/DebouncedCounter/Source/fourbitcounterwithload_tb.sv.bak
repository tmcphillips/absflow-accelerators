`include "macros.v"
`include "fourbitcounterwithload.v"

import ovm_pkg::*;

module fourbitcounterwithload_tb();
	
	string m;
  int inData;
  int outData;
	tlm_fifo #(int) fifo;
	
	initial begin
	  fifo = new("fifo");
	  $sformat(m, "%m");
	  ovm_top.set_report_verbosity_level(200);
	  ovm_top.ovm_report_info(m, "Normal error", 100, `__FILE__, `__LINE__);
    inData = 3;
	  fifo.put(inData);
	  fifo.get(outData);
	  $write("%d", outData);
	end
	
	
	reg upButton;
	reg downButton;
	reg loadButton;
	reg resetButton;
	reg [3:0] switches;
	reg clock;
	wire [3:0] counter;
	
	fourbitcounterwithload #(.CLOCK_SCALER_BITS(2)) u0dut (
		.upButton(upButton),
		.downButton(downButton),
		.loadButton(loadButton),
		.resetButton(resetButton),
		.switches(switches),
		.systemClock(clock),
		.counter(counter)
	);
	
	// generate system clock signal
	always #1 clock = ~clock;
	
	initial begin

		// set time format
		$timeformat(-6, 10, "", 10);

		// initialize system input signals
		clock 		= `LOW;
		upButton		= `LOW;
		downButton	= `LOW;
		loadButton	= `LOW;
		resetButton = `LOW;
		switches		= 4'b0000;

		#20	resetButton = `HIGH;
		#10	resetButton = `LOW;
				assert(counter == 0);

		#20	upButton = `HIGH;
		#40	upButton = `LOW;
				assert(counter == 1);
										
		#20	upButton = `HIGH;
		#40	upButton = `LOW;
				assert(counter == 2); 

		#20	switches = 11;
		#10	loadButton = `HIGH;
		#20	loadButton = `LOW;
				assert(counter == 11);

		#20	downButton = `HIGH;
		#5		downButton = `LOW;
				assert(counter == 11);
				
		#20	downButton = `HIGH;
		#40	downButton = `LOW;
				assert(counter == 10);

		#20;

		$write("*** SUCCESS ***  Simulation ended succesfully at t = %t \n", $realtime);
		
		ovm_top.report_summarize();
		
		$stop;

	end
	
endmodule

