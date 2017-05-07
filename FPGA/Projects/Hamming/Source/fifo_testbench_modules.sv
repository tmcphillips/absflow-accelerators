import ovm_pkg::*;
import ppfifo_testbench_classes_pkg::*;

`timescale 1ns / 1ps

/*****************   C L O C K   G E N E R A T O R   ***************/

module clock_generator(output bit clock);

    initial clock <= 0;
    always #5 clock = ~ clock;
    
endmodule : clock_generator


/*************************   D R I V E R  **************************/
module ppfifo_tb_driver #(parameter FIFO_WORD_SIZE=1) (

    ref tlm_fifo #(ppfifo_operation_queue_t)    gen2drv_operation_fifo,
    ref tlm_fifo #(ppfifo_operation_queue_t)    drv2prd_operation_fifo,

    ppfifo_if.WRITER    ppfifo
);
	
	// declare local variables
	ppfifo_operation_queue_t    operations;
	ppfifo_operation            request;
	string                      module_name;
	
	// store name of module for use in report messages
	initial $sformat(module_name, "%m");
	
	// initialize signals to DUT
	initial begin : init_signals
        ppfifo.clear                <= 0;
        ppfifo.writer_cb.put_value  <= 0;
        ppfifo.writer_cb.put_req    <= 0;
	end : init_signals
  
    always @ppfifo.writer_cb begin : drive_transactions
          
        // get the next transaction request
        if (gen2drv_operation_fifo.try_get(operations)) begin :  handle_operation_queue
        
            // forward current operation bundle to predictor
            drv2prd_operation_fifo.put(operations);
            
            foreach (operations[i]) begin : handle_operation

                // get next operation from the list
                request = operations[i];
          
                // print request to the log
                ovm_top.ovm_report_info(module_name,"*******************************************************", 400);
                ovm_top.ovm_report_info(module_name, request.convert2string(), 300);

                // validate request
                //if (request.hold < 1) ovm_top.ovm_report_fatal(module_name, "Hold time must be greater than zero"); 
                if (request.waits < 1) ovm_top.ovm_report_fatal(module_name, "Wait time must be greater than zero"); 

                ovm_top.ovm_report_info(module_name, "Waiting to drive signals...", 300);

                // keep signals to DUT low for requested number of clock cycles
                repeat(request.waits) @ppfifo.writer_cb;
      
                ovm_top.ovm_report_info(module_name, "Driving signals...", 300);

                // drive the operation-specific control signal on the DUT until acknowledged
                case (request.op)
              
                    clear_op:    begin
                                    ppfifo.clear <= 1;
                                    repeat(request.hold) @ppfifo.writer_cb;
                                    ppfifo.clear <= 0;
                                 end
                                 
                    put_op:     begin
                                    ppfifo.writer_cb.put_req   <= 1; 
                                    ppfifo.writer_cb.put_value <= request.arg;
                                    wait(ppfifo.writer_cb.put_ack);
                                    repeat(request.hold) @ppfifo.writer_cb;
                                    ppfifo.writer_cb.put_value  <= 0;
                                    ppfifo.writer_cb.put_req    <= 0;
                                end 
         
                    no_op:      begin 
                                end
              
                endcase
            
                // report transaction complete on driver side
                ovm_top.ovm_report_info(module_name, "Finished operation", 300);
            
            end : handle_operation
      
        end : handle_operation_queue

  end : drive_transactions

endmodule : ppfifo_tb_driver


/*************************   R E S P O N D E R  *************************/
module ppfifo_tb_responder #(parameter FIFO_WORD_SIZE=1) (

    ref tlm_fifo #(ppfifo_operation_queue_t)    gen2rsp_operation_fifo,
    ref tlm_fifo #(ppfifo_result_queue_t)       rsp2prn_result_fifo,
    ref tlm_fifo #(ppfifo_result_queue_t)       rsp2cmp_result_fifo,

    ppfifo_if.READER    ppfifo     
);
	
    // declare local variables
    ppfifo_operation_queue_t    operations;
    ppfifo_operation     	    operation;
    ppfifo_result_queue_t       result_bundle;
    ppfifo_result               result;
    string                      module_name;
    string                      message;

    // store name of module for use in report messages
    initial $sformat(module_name, "%m");
    	// initialize signals to DUT
	
    initial begin : init_signals
        ppfifo.reader_cb.get_req  <= 0;
	end : init_signals
    
    always @ppfifo.reader_cb begin : handle_operation_queue
  	   
        // get the next transaction request
        if (gen2rsp_operation_fifo.try_get(operations)) begin : handle_operations_in_queue
            
            result_bundle.delete();
            
            foreach (operations[i]) begin: handle_operation

                // get next operation from the list
                operation = operations[i];
            
                // print request to the log
                ovm_top.ovm_report_info(module_name,"*******************************************************", 400);
                ovm_top.ovm_report_info(module_name, operation.convert2string(), 300);
                
                
                // keep signals to DUT low for requested number of clock cycles
                repeat(operation.waits - 2) @ppfifo.reader_cb;
      
                // make get request and wait for acknowledgement
                ppfifo.reader_cb.get_req <= 1;
                wait(ppfifo.reader_cb.get_ack);
                
                // hold signals on DUT for the requested number of positive clock edges
                repeat(operation.hold) @ppfifo.reader_cb;

                // store the returned value  
                result = new(ppfifo.reader_cb.get_value);
                
                ppfifo.reader_cb.get_req <= 0;
                
                // add result to result bundle
                result_bundle.push_back(result);
              
                $sformat(message, "Actual: %s", result.convert2string);
                ovm_top.ovm_report_info(module_name, message, 300);
            
            end : handle_operation
              
            //assert(rsp2prn_result_fifo.try_put(result_bundle));
            assert(rsp2cmp_result_fifo.try_put(result_bundle));
        
	    end : handle_operations_in_queue
	    
	end : handle_operation_queue

endmodule : ppfifo_tb_responder


/*************************   P R E D I C T E R  *************************/
module ppfifo_tb_predictor #(parameter FIFO_WORD_SIZE=1) (
  ref tlm_fifo #(ppfifo_operation_queue_t)  drv2prd_operation_fifo,
  ref tlm_fifo #(ppfifo_result_queue_t)  	prd2cmp_result_fifo
);
	
	// declare module scope variables
	string       				message;
	string    				    module_name;
	ppfifo_operation_queue_t    operation_sequence;
	ppfifo_operation            operation;
	ppfifo_result               predicted_result;
	bit [FIFO_WORD_SIZE-1:0] 	predicted_value;
	ppfifo_result_queue_t       result_sequence;

	// store name of module for use in report messages
	initial $sformat(module_name, "%m");
  
	task run;
	  
        // iteratively handle each incoming operation sequence
        forever begin : handle_operation_sequence
	   
            // receive the next operation sequence
            drv2prd_operation_fifo.get(operation_sequence);
                         
            // clear the result sequence
            result_sequence.delete();
           
            // handle each operation in the received sequence
            foreach (operation_sequence[i]) begin: handle_operation

                // access the next operation from the sequence
                operation = operation_sequence[i];
                    
                // predict a result for each put operation
                if (operation.op == put_op) begin : handle_put_op
                    
                    // store the predicted value at the end of the result sequence
                    predicted_value = operation.arg;
                    predicted_result = new(predicted_value);
                    result_sequence.push_back(predicted_result);

                    // print the predicted value to the log
                    $sformat(message, "Predicted: %s", predicted_result.convert2string);
                    ovm_top.ovm_report_info(module_name, message, 300);
                    
                end : handle_put_op

            end : handle_operation

            // send the result sequence to the comparator
			assert(prd2cmp_result_fifo.try_put(result_sequence));
	
		end : handle_operation_sequence
	 
    endtask : run
 
endmodule : ppfifo_tb_predictor


/*************************   C O M P A R A T O R  *************************/
module  ppfifo_tb_comparator (
  ref tlm_fifo #(ppfifo_result_queue_t)  rsp2cmp_result_fifo,
  ref tlm_fifo #(ppfifo_result_queue_t)  prd2cmp_result_fifo
);

    // declare local variables	
    ppfifo_result_queue_t actual_result_sequence;
    ppfifo_result_queue_t predicted_result_sequence;
    ppfifo_result   actual_result;
    ppfifo_result   predicted_result;
    int             actual_value;
    int             predicted_value;
    string          message;
    string          module_name;

    function string comparison2string( ppfifo_result_queue_t predicted, ppfifo_result_queue_t actual);
        string s;
        $sformat(s, "Predicted sequence:   %s \nActual sequence:      %s",
                    ppfifo_result::sequence2string(actual_result_sequence),
                    ppfifo_result::sequence2string(predicted_result_sequence));
        return s;
    endfunction : comparison2string
    
	task run;
	  
        // store module name for use in log messages
        $sformat(module_name, "%m");
        
        // handle all incoming results
        forever begin : handle_result_sequence_pair
	   
            // get the actual result from the responder
            rsp2cmp_result_fifo.get(actual_result_sequence);
            
            // get the predicted result from the predictor
            prd2cmp_result_fifo.get(predicted_result_sequence);
           
            if ($size(actual_result_sequence) != $size(predicted_result_sequence)) 
                begin
                    $sformat(   message,  
                                "Actual and predicted sequences differ in length: \n%s",
                                comparison2string(predicted_result_sequence, actual_result_sequence)
                            );
                    ovm_top.ovm_report_error(module_name, message, 200);
                end 
            else 
                // compare each result in the actual and predicted sequences
                foreach (actual_result_sequence[i]) begin : handle_result_pair

                    actual_value    = actual_result_sequence[i].result;
                    predicted_value = predicted_result_sequence[i].result;
                
                    if (actual_value != predicted_value) begin                
                        $sformat(message,  "Actual and predicted sequence differ at element %d.  actual = %d  predicted = %d\n%s", 
                            i, actual_value, predicted_value, comparison2string(predicted_result_sequence, actual_result_sequence));
                        ovm_top.ovm_report_error(module_name, message, 200);
                        break;
                    end
                    
                    ovm_top.ovm_report_info(module_name, "Actual and predicted values match", 300);
                    
                end : handle_result_pair

/*            // create the log message dissplaying the predicted and actual results
            $sformat(message, "Predicted: %s   Actual: %s",
               predicted_result.convert2string, actual_result.convert2string);
           
            // print the message to the log as info or an error depending on whether the results are the same
            if (actual_result.comp(predicted_result))
                ovm_top.ovm_report_info(module_name, message, 300);
            else 
*/
                
        end : handle_result_sequence_pair
	 
	endtask : run
	 
endmodule : ppfifo_tb_comparator


/*************************   P R I N T E R  *************************
module ppfifo_tb_printer (
  ref tlm_fifo #(dbctr_result)  res2prn_result_fifo
);
	
	// declare local variables
	dbctr_result  result;
	string        module_name;
	
	// define the transaction level task
	task run;
	  
	 // store name of module for use in report messages
	 $sformat(module_name, "%m");
	 
	 // receive each result from the responder and print to log
	 forever begin
	   res2prn_result_fifo.get(result);
	   ovm_top.ovm_report_info(module_name, result.convert2string(), 400);
	 end
	 
	endtask
	 
endmodule // dbctr_tb_printer

*/
