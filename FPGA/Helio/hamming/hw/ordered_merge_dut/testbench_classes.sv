
import verbosity_pkg::*;

typedef enum int { RESET, DATA_A, DATA_B, SOP_A, SOP_B, EOP_A, EOP_B } transaction_t;

class Response;
	logic [`DUT_DATA_W-1:0]	data;
 	logic							sop;
	logic							eop;

  function new(
	logic [`DUT_DATA_W-1:0]   data = '0,
	logic 							sop = '0,
	logic 							eop = '0
  );
    this.data 	= data;
    this.sop 	= sop;
    this.eop 	= eop;
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
  transaction_t 				transaction_type;
  logic [`DUT_DATA_W-1:0] 	payload;
  logic [31:0]  				idle_cycles;
  
  function new(
    transaction_t 				transaction_type, 
    logic [`DUT_DATA_W-1:0] 	payload 				= 0, 
    logic [31:0] 					idle_cycles 		= 0
  );
    this.transaction_type 	= transaction_type;
    this.payload 				= payload;
    this.idle_cycles 		= idle_cycles;
  endfunction

endclass

class Tester;

	mailbox #(Transaction) driver_inbox, responder_inbox, predictor_inbox;
	mailbox #(Response) comparator_inbox;
	
	function new(
		input mailbox  #(Transaction) driver_inbox, 
		input mailbox  #(Transaction) responder_inbox,
//		input mailbox  #(Transaction) predictor_inbox,
		mailbox #(Response) comparator_inbox
	);
		this.driver_inbox     = driver_inbox;
		this.responder_inbox  = responder_inbox;
//		this.predictor_inbox  = predictor_inbox;
		this.comparator_inbox = comparator_inbox;
	endfunction
	
	task run;
		begin

			Transaction t;
			Response r;
						
			t = new(RESET, 40, 20);
			send_transaction(t);

			t = new(DATA_A, 1);
			send_transaction(t);

			t = new(DATA_A, 2);
			send_transaction(t);

			t = new(DATA_B, 3);
			send_transaction(t);

			r = new(1);
			comparator_inbox.put(r);

			r = new(2);
			comparator_inbox.put(r);

			t = new(EOP_A);
			send_transaction(t);

			r = new(3);
			comparator_inbox.put(r);

//			t = new(EOP_B, 0, 0);
//			send_transaction(t);
//
//			r = new(255, 0, 1);
//			comparator_inbox.put(r);
//			
//			t = new(DATA_A, 1, 0);
//			send_transaction(t);
//
//			t = new(DATA_A, 2, 0);
//			send_transaction(t);
//
//			t = new(DATA_B, 3, 0);
//			send_transaction(t);
//
//			r = new(1, 0, 0);
//			comparator_inbox.put(r);
//
//			r = new(2, 0, 0);
//			comparator_inbox.put(r);
//
//			r = new(3, 0, 0);
//			comparator_inbox.put(r);
//			
//			t = new(EOP_A, 251, 0);
//			send_transaction(t);
//
//			t = new(EOP_B, 252, 0);
//			send_transaction(t);
//
//			r = new(255, 0, 1);
//			comparator_inbox.put(r);
			
		end
	endtask

	task send_transaction(Transaction t);
			driver_inbox.put(t);
			responder_inbox.put(t);
//			predictor_inbox.put(t);
	endtask
	
endclass

class Driver;
	mailbox #(Transaction) inbox;
	
	function new(input mailbox #(Transaction) inbox);
		this.inbox = inbox;
	endfunction
	
	task run;
		Transaction	t;
	 
		bfm.initialize();
		
		forever begin
			inbox.get(t);

			case(t.transaction_type)
			
				RESET:			begin
										#(t.idle_cycles);
										bfm.reset_system(t.payload);
									end
									
			   DATA_A:			bfm.write_st_sink_a(t.payload, 0, 0, t.idle_cycles);
			   
				DATA_B:			bfm.write_st_sink_b(t.payload, 0, 0, t.idle_cycles);

				EOP_A:			bfm.write_st_sink_a(t.payload, 0, 1, t.idle_cycles);

				EOP_B:			bfm.write_st_sink_b(t.payload, 0, 1, t.idle_cycles);

			endcase
		end
	endtask

endclass

class Responder;
	mailbox #(Transaction) inbox;
	mailbox #(Response) outbox;
	
  function new(input mailbox #(Transaction) inbox, input mailbox #(Response) outbox);
		this.inbox = inbox;	
		this.outbox = outbox;
	endfunction
	
	task run;
		Response response;
		Transaction	t;
		
		forever begin
			inbox.get(t);
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
		cutoff = 0;
	endfunction
	
	task run;
	
		Transaction 	t;
		bit 				cutoff_exceeded_eop_sent;
	
		forever begin
			Response response;
			inbox.get(t);
//			unique case(t.transaction_type)
//				CUTOFF_WRITE:	cutoff = t.payload;
//
//			   DATA_SEND:		if (t.payload <= cutoff) begin
//										response = new(t.payload);
//										cutoff_exceeded_eop_sent = '0;
//										outbox.put(response);
//									end
//									else if (~cutoff_exceeded_eop_sent) begin
//										response = new(255, 0, 1);
//										cutoff_exceeded_eop_sent = 1'b1;
//										outbox.put(response);
//									end
//
//			   SOP_SEND:		begin
//										response = new(t.payload, 1, 0);
//										outbox.put(response);
//									end
//
//			   EOP_SEND:		begin
//										response = new(t.payload, 0, 1);
//										outbox.put(response);
//									end
//									
//				default:			;
//				
//			endcase
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
