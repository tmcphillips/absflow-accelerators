`include "testbench_defs.sv"

module test_program();

`include "testbench_classes.sv"


bfm_tasks bfm();

//local variables
Tester tester;
Driver driver;
Responder responder;
Predictor predictor;
Comparator comparator;
mailbox #(Transaction) driver_inbox, responder_inbox, predictor_inbox;
mailbox #(Response) comparator_actual_inbox, comparator_predicted_inbox;

initial begin

	set_verbosity(`VERBOSITY);

	
	driver_inbox = new();
	responder_inbox = new();
	predictor_inbox = new();
	comparator_actual_inbox = new();
	comparator_predicted_inbox = new();
	
//	tester = new(driver_inbox, responder_inbox, predictor_inbox);
	tester = new(driver_inbox, responder_inbox, comparator_predicted_inbox);
	driver = new(driver_inbox);
	predictor = new(predictor_inbox, comparator_predicted_inbox);
	comparator = new(comparator_predicted_inbox, comparator_actual_inbox);
	responder = new(responder_inbox, comparator_actual_inbox);


	
	fork
	  tester.run();
		driver.run();
		predictor.run();
		responder.run();
		comparator.run();		
	join

end

endmodule
