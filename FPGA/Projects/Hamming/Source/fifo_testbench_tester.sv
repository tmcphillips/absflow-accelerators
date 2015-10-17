import ppfifo_testbench_classes_pkg::*;
import ovm_pkg::*;

`include "constants.sv"

interface ppfifo_if(input bit clock);

    logic 					clear;    
	logic					put_req;
	logic					put_ack;
	logic [`FIFO_WIDTH-1:0] put_value;

	logic					get_req;
	logic					get_ack;
	logic [`FIFO_WIDTH-1:0]	get_value;
    
    clocking writer_cb @(posedge clock);
        output  put_req;
        output  put_value;
        input   put_ack;
    endclocking

    clocking reader_cb @(posedge clock);
        output  get_req;
        input   get_value;
        input   get_ack;
    endclocking

    
    modport WRITER(clocking writer_cb, clear);
    modport READER(clocking reader_cb);

endinterface : ppfifo_if



/*************************   T O P  **************************/

module ppfifo_testbench_top;

    tlm_fifo #(ppfifo_operation_queue_t)  gen2drv_fifo;
    tlm_fifo #(ppfifo_operation_queue_t)  gen2rsp_fifo;
    tlm_fifo #(ppfifo_operation_queue_t)  drv2prd_fifo;
    tlm_fifo #(ppfifo_result_queue_t)     prd2cmp_fifo;
    tlm_fifo #(ppfifo_result_queue_t)     rsp2prn_fifo;
    tlm_fifo #(ppfifo_result_queue_t)     rsp2cmp_fifo;

    wire					clock;
	wire					clear_req;
	wire					clear_ack;
	wire					put_req;
	wire					put_ack;
	wire					get_req;
	wire					get_ack;
	wire [`FIFO_WIDTH-1:0]  put_value;
	wire [`FIFO_WIDTH-1:0]	get_value;
 
    clock_generator clock_gen(clock);
 
    ppfifo_if ppfifo(.*);
 
    ppfifo_testbench_generator #(`FIFO_WIDTH) generator(
        .gen2drv_operation_fifo(gen2drv_fifo),
        .gen2rsp_operation_fifo(gen2rsp_fifo)
    );
  
    ppfifo_tb_driver #(`FIFO_WIDTH) driver(
        .gen2drv_operation_fifo(gen2drv_fifo),
        .drv2prd_operation_fifo(drv2prd_fifo),
        .ppfifo(ppfifo)
	);
	
	ppfifo_tb_predictor #(`FIFO_WIDTH) predictor (
        .drv2prd_operation_fifo(drv2prd_fifo),
        .prd2cmp_result_fifo(prd2cmp_fifo)
    );
	
	PushPullFIFO #(.FIFO_WORD_SIZE(`FIFO_WIDTH), .FIFO_POINTER_BITS(2)) dut (
		.clock(clock),
		.clear(ppfifo.clear),
		.put_req(ppfifo.put_req),
		.put_ack(ppfifo.put_ack),
		.put_value(ppfifo.put_value),
		.get_req(ppfifo.get_req),
		.get_value(ppfifo.get_value),
		.get_ack(ppfifo.get_ack)
	);
	
	 ppfifo_tb_responder #(`FIFO_WIDTH) responder (
		.gen2rsp_operation_fifo(gen2rsp_fifo),
        .rsp2prn_result_fifo(rsp2prn_fifo),
        .rsp2cmp_result_fifo(rsp2cmp_fifo),
        .ppfifo(ppfifo)
	);
	

	ppfifo_tb_comparator comparator (
        .rsp2cmp_result_fifo(rsp2cmp_fifo),
        .prd2cmp_result_fifo(prd2cmp_fifo)
    );

/*
    dbctr_tb_printer printer (
        .res2prn_result_fifo(rsp2prn_fifo)
    );
*/
	
    initial begin : initialize_testbench
    
        ovm_top.set_report_verbosity_level(400);
        ovm_top.set_report_max_quit_count(5);
        
        gen2drv_fifo = new("gen2drv_fifo");
        gen2rsp_fifo = new("gen2rsp_fifo");
        drv2prd_fifo = new("drv2prd_fifo");
        prd2cmp_fifo = new("prd2cmp_fifo");
        rsp2prn_fifo = new("rsp2prn_fifo");
        rsp2cmp_fifo = new("rsp2cmp_fifo");
        
        fork
            generator.run();
            predictor.run();
            comparator.run();
    //      printer.run();
        join_none
    
    end : initialize_testbench

endmodule : ppfifo_testbench_top


/*************************  G E N E R A T O R  **************************/

module ppfifo_testbench_generator #(parameter FIFO_WORD_SIZE=1) (
	ref tlm_fifo  #(ppfifo_operation_queue_t) gen2drv_operation_fifo,
	ref tlm_fifo  #(ppfifo_operation_queue_t) gen2rsp_operation_fifo
);
  
    ppfifo_operation t;
	ppfifo_operation_queue_t  driver_sequence;
	ppfifo_operation_queue_t  responder_sequence;
    
    task run;

        driver_sequence.delete();
        responder_sequence.delete();
        
        t = new(clear_op, 0, 1, 5);
        driver_sequence.push_back(t);
        
        /*
        for (int waits = 5; waits > 0; waits--) begin

            t = new(put_op, waits+1, waits, 6);
            driver_sequence.push_back(t);
        
            t = new(get_op, 0, 20, 2);
            responder_sequence.push_back(t); 

        end
        */

        for (int holds = 5; holds >= 0; holds--) begin

            t = new(put_op, holds+1, 2, holds);
            driver_sequence.push_back(t);
        
            t = new(get_op, 0, 10, 2);
            responder_sequence.push_back(t); 

        end

        
        gen2drv_operation_fifo.put(driver_sequence);
        gen2rsp_operation_fifo.put(responder_sequence);
        
        wrapup;
        
    endtask : run
  
  
    task wrapup;
        #5000 ovm_top.die();
    endtask : wrapup
    
endmodule : ppfifo_testbench_generator


