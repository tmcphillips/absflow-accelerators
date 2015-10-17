

module top ();

	//instance the simulation model of dut_tb.qsys 
	ordered_merge_dut_tb tb();
	
	//instance the test program
	test_program pgm();
	
endmodule
