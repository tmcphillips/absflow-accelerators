
import verbosity_pkg::*;
import avalon_mm_pkg::*;

typedef enum int { RESET, CUTOFF_WRITE, CUTOFF_READ, DATA_SEND, SOP_SEND, EOP_SEND } transaction_t;

class Response;
	logic [`DUT_DATA_W-1:0]   	data;
 	logic								sop;
	logic								eop;

  function new(
	logic [`DUT_DATA_W-1:0]   data = '0,
	logic 							sop = '0,
	logic 							eop = '0
  );
    this.data = data;
    this.sop = sop;
    this.eop = eop;
  endfunction
  
	function string tostring;
		string message;
		$sformat(message, "Data: %d\tSOP: %d\tEOP: %d", data, sop, eop);
		return message;
	endfunction
	
	function equals(Response rhs);
		return 	(this.data == rhs.data) && 
					(this.sop == rhs.sop) &&
					(this.eop == rhs.eop);
	endfunction

endclass

class Transaction;
  transaction_t transaction_type;
  logic [`DUT_DATA_W-1:0]   payload;
  logic [31:0]  idle_cycles;
  
  function new(
    transaction_t transaction_type, 
    logic [`DUT_DATA_W-1:0] payload = 0, 
    logic [31:0] idle_cycles = 0
  );
    this.transaction_type = transaction_type;
    this.payload = payload;
    this.idle_cycles = idle_cycles;
  endfunction

endclass

class Tester;

	mailbox #(Transaction) driver_inbox, predictor_inbox;
	
	function new(
		input mailbox  #(Transaction) driver_inbox, 
		input mailbox  #(Transaction) predictor_inbox
	);
		this.driver_inbox     = driver_inbox;
		this.predictor_inbox  = predictor_inbox;
	endfunction
	
	task run;
		begin

			Transaction t;
						
			t = new(RESET, 40, 20);
			send_transaction(t);
	
			t = new(CUTOFF_READ);
			send_transaction(t);
			
			t = new(DATA_SEND, 1);
			send_transaction(t);
      
			t = new(DATA_SEND, 10);
			send_transaction(t);

			t = new(DATA_SEND, 100);
			send_transaction(t);
			
			t = new(DATA_SEND, 255);
			send_transaction(t);

			t = new(CUTOFF_WRITE, 66);
			send_transaction(t);

			t = new(CUTOFF_READ);
			send_transaction(t);

			t = new(DATA_SEND, 9);
			send_transaction(t);
      
			t = new(DATA_SEND, 57);
			send_transaction(t);

			t = new(SOP_SEND, 33);
			send_transaction(t);			

			t = new(DATA_SEND, 62);
			send_transaction(t);
			
			t = new(DATA_SEND, 66);
			send_transaction(t);

			t = new(DATA_SEND, 67);
			send_transaction(t);

			t = new(DATA_SEND, 60);
			send_transaction(t);

			t = new(DATA_SEND, 70);
			send_transaction(t);

			t = new(EOP_SEND, 8'h00);
			send_transaction(t);
			
			t = new(CUTOFF_WRITE, 23);
			send_transaction(t);
			
			t = new(CUTOFF_READ);
			send_transaction(t);

			t = new(DATA_SEND, 9);
			send_transaction(t);
      
			t = new(DATA_SEND, 19);
			send_transaction(t);

			t = new(DATA_SEND, 18);
			send_transaction(t);
			
			t = new(DATA_SEND, 24);
			send_transaction(t);

			t = new(DATA_SEND, 1);
			send_transaction(t);

			t = new(DATA_SEND, 2);
			send_transaction(t);

			t = new(DATA_SEND, 3);
			send_transaction(t);

			t = new(EOP_SEND, 8'h00);
			send_transaction(t);			

			t = new(DATA_SEND, 9);
			send_transaction(t);
      
			t = new(DATA_SEND, 19);
			send_transaction(t);

			t = new(DATA_SEND, 18);
			send_transaction(t);
			
			t = new(DATA_SEND, 24);
			send_transaction(t);

			t = new(DATA_SEND, 1);
			send_transaction(t);

			t = new(DATA_SEND, 2);
			send_transaction(t);

			t = new(DATA_SEND, 3);
			send_transaction(t);

			t = new(RESET, 40, 50);
			send_transaction(t);
		
			t = new(DATA_SEND, 4);
			send_transaction(t);

			t = new(DATA_SEND, 5);
			send_transaction(t);

			t = new(DATA_SEND, 6);
			send_transaction(t);

		end
	endtask

	task send_transaction(Transaction t);
			driver_inbox.put(t);
			predictor_inbox.put(t);
	endtask
	
endclass

class Driver;
	mailbox #(Transaction) inbox;
	
	function new(input mailbox #(Transaction) inbox);
		this.inbox = inbox;
	endfunction
	
	task run;
		Transaction	t;
		logic [`DUT_DATA_W-1:0]	value;
		logic [`DUT_DATA_W-1:0] cutoff;
	 
		bfm.initialize();
		
		forever begin
			inbox.get(t);

			case(t.transaction_type)
			
				RESET:			begin
										#(t.idle_cycles);
										bfm.reset_system(t.payload);
										cutoff = -1;
									end
			
				CUTOFF_WRITE:	begin
										cutoff = t.payload;
										bfm.write_mm_slave(0, cutoff, 1, 0, 0);
									end
			
				CUTOFF_READ:	begin
										bfm.read_mm_slave(0, value, 1, 0, 0);
										assert(value == cutoff);
									end
									
			   DATA_SEND:		bfm.write_st_sink(t.payload, 0, 0, t.idle_cycles);

			   SOP_SEND:		bfm.write_st_sink(t.payload, 1, 0, t.idle_cycles);

			   EOP_SEND:		bfm.write_st_sink(t.payload, 0, 1, t.idle_cycles);	
	
			endcase
		end
	endtask

endclass

class Responder;
	mailbox #(Response) outbox;
	
  function new(input mailbox #(Response) outbox);
		this.outbox = outbox;
	endfunction
	
	task run;
		Response response;
		
		forever begin
			response = new();
			bfm.read_st_source(response.data, response.sop, response.eop);
			outbox.put(response);
		end
	endtask

endclass

class Predictor;

	mailbox #(Transaction) inbox;
	mailbox #(Response) outbox;
	logic [`DUT_DATA_W-1:0] cutoff;
	
	function new(
		input mailbox #(Transaction) inbox, 
		input mailbox #(Response) outbox
	);
		this.inbox = inbox;
		this.outbox = outbox;
		cutoff = top.tb.dut.lowpass_filter.DEFAULT_CUTOFF;
	endfunction
	
	task run;
	
		Transaction 	t;
		bit 				cutoff_exceeded;
		logic 						forward_delimiters =	top.tb.dut.lowpass_filter.FORWARD_DELIMITERS;
		logic 						eop_on_exceed = 		top.tb.dut.lowpass_filter.EOP_ON_EXCEED;
		logic [`DUT_DATA_W-1:0]	new_eop_value = 		top.tb.dut.lowpass_filter.NEW_EOP_VALUE;
	
		forever begin
			Response response;
			inbox.get(t);
			unique case(t.transaction_type)
			
				RESET:			begin
										cutoff = top.tb.dut.lowpass_filter.DEFAULT_CUTOFF;
										cutoff_exceeded = '0;
									end
									
				CUTOFF_WRITE:	cutoff = t.payload;

			   DATA_SEND:		if (!cutoff_exceeded) begin
										if (t.payload <= cutoff) begin
											response = new(t.payload);
											outbox.put(response);
										end
										else if (eop_on_exceed) begin
											cutoff_exceeded = '1;
											response = new(new_eop_value, 0, 1);
											outbox.put(response);
										end
									end

			   SOP_SEND:		if (forward_delimiters) begin
										response = new(t.payload, 1, 0);
										outbox.put(response);
									end

			   EOP_SEND:		begin
										if (cutoff_exceeded) 
											cutoff_exceeded = '0;
										else if (forward_delimiters) begin
											response = new(t.payload, 0, 1);
											outbox.put(response);
										end
									end
									
				default:			;
				
			endcase
		end
	endtask

endclass

class Comparator;
	mailbox #(Response) predicted_inbox;
	mailbox #(Response) actual_inbox;
	
	function new(
		input mailbox #(Response) predicted_inbox, 
		input mailbox #(Response) actual_inbox
	);
		this.predicted_inbox = predicted_inbox;
		this.actual_inbox = actual_inbox;
	endfunction
	
	task run;
		Response predicted;
		Response actual;
		string message  = "*uninitialized*";

 		forever begin
			
			predicted_inbox.get(predicted);
			actual_inbox.get(actual);
			
			assert(actual.equals(predicted)) begin
			   $sformat(message, "%m: Received: %s", actual.tostring());
				print(VERBOSITY_INFO, message);
		end 
			else begin
				$sformat(message, "%m:\n\t\t\tPredicted: %s\n\t\t\tReceived:  %s", 
					predicted.tostring(), actual.tostring());
				print(VERBOSITY_ERROR, message);
			end
			
		end
	endtask

endclass
