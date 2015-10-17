import dbctr_testbench_classes_pkg::*;
import ovm_pkg::*;

/*************************   T O P  **************************/

module dbctr_testbench_top;

  tlm_fifo #(dbctr_operation)  gen2drv_fifo;
  tlm_fifo #(dbctr_operation)  drv2prd_fifo;
  tlm_fifo #(dbctr_result)     prd2cmp_fifo;
  tlm_fifo #(dbctr_result)     rsp2prn_fifo;
  tlm_fifo #(dbctr_result)     rsp2cmp_fifo;

  wire       clock;
  wire       up;
  wire       down;
  wire       load;
  wire       reset;
  wire       ack;
  wire [3:0] load_value;
  wire [3:0] counter_value;
  
  dbctr_testbench_generator generator(
    .gen2drv_operation_fifo(gen2drv_fifo)
  );
  
   dbctr_tb_driver driver(
    .gen2drv_operation_fifo(gen2drv_fifo),
    .drv2prd_operation_fifo(drv2prd_fifo),
    .clock(clock),
 	  .up(up),
	  .down(down),
	  .load(load),
	  .reset(reset),
	  .value(load_value)
	);
	
	 dbctr_tb_predictor predictor (
    .drv2prd_operation_fifo(drv2prd_fifo),
    .prd2cmp_result_fifo(prd2cmp_fifo)
  );
	
 	fourbitcounterwithload dut (
		.upButton(up),
		.downButton(down),
		.loadButton(load),
		.resetButton(reset),
		.switches(load_value),
		.clock(clock),
		.counter(counter_value),
		.ack(ack)
	);
	
	 dbctr_tb_responder responder (
    .rsp2prn_result_fifo(rsp2prn_fifo),
    .rsp2cmp_result_fifo(rsp2cmp_fifo),
    .clock(clock),
	  .reset(reset),
	  .ack(ack),
	  .counter(counter_value)
	);
	
	 dbctr_tb_comparator comparator (
    .rsp2cmp_result_fifo(rsp2cmp_fifo),
    .prd2cmp_result_fifo(prd2cmp_fifo)
  );

   dbctr_tb_printer printer (
    .res2prn_result_fifo(rsp2prn_fifo)
  );

  initial begin
    
    ovm_top.set_report_verbosity_level(400);
    ovm_top.set_report_max_quit_count(1);
    
    gen2drv_fifo = new("gen2drv_fifo");
    drv2prd_fifo = new("drv2prd_fifo");
    prd2cmp_fifo = new("prd2cmp_fifo");
    rsp2prn_fifo = new("rsp2prn_fifo");
    rsp2cmp_fifo = new("rsp2cmp_fifo");
    
    fork
      generator.run();
      predictor.run();
      comparator.run();
      printer.run();
    join_none
    
  end

endmodule

/*************************  G E N E R A T O R  **************************/

module dbctr_testbench_generator(ref tlm_fifo #(dbctr_operation) gen2drv_operation_fifo);
  
  dbctr_operation t;
  integer seed = 42;
    
  task run;

    t = new(reset_op, 0, 5, 4);
    gen2drv_operation_fifo.put(t.clone);

  `include "testbody.sv"
    
    wrapup;
    
  endtask // run
  
  
  task wrapup;
    #500 ovm_top.die();
  endtask
    
endmodule // dbctr_testbench_generator 


