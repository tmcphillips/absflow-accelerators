
import verbosity_pkg::*;
import avalon_mm_pkg::*;

typedef enum int { RESET, MAX_WRITE, INIT_WRITE, START, WAIT } transaction_t;

typedef logic unsigned [35:0]  uint36;

function uint36 min(uint36 a, uint36 b);
	return a <= b ? a : b;
endfunction

class Response;
	logic [`DUT_DATA_W-1:0]   	data;
 	logic								sop;
	logic								eop;

  function new(
	logic [`DUT_DATA_W-1:0]   	data = '0,
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
  logic [`DUT_DATA_W-1:0] 	payload;
  logic [31:0]  				idle_cycles;
  
  function new(
    transaction_t 				transaction_type, 
    logic [`DUT_DATA_W-1:0] 	payload = 0, 
    logic [31:0] 					idle_cycles = 0
  );
    this.transaction_type	= transaction_type;
    this.payload 				= payload;
    this.idle_cycles 		= idle_cycles;
  endfunction

  	function string tostring;
		string message;
		string t;
		
		case(this.transaction_type)
			RESET:			t = "RESET";
			MAX_WRITE:		t = "MAX_WRITE";
			INIT_WRITE:		t = "INIT_WRITE";
			START:			t = "START";
			WAIT:				t = "WAIT";
		endcase
		
		$sformat(message, "Type: %s\tPayload: %d\tIdles: %d", t, this.payload, this.idle_cycles);
		return message;
	endfunction
	
endclass

class Tester;

	mailbox #(Transaction) driver_inbox, responder_inbox, predictor_inbox;
	mailbox #(bit) tester_inbox;
	
	function new(
		input mailbox  #(bit)			tester_inbox,
		input mailbox  #(Transaction) driver_inbox, 
		input mailbox  #(Transaction) responder_inbox,
		input mailbox  #(Transaction) predictor_inbox
	);
		this.tester_inbox = tester_inbox;
		this.driver_inbox     = driver_inbox;
		this.responder_inbox  = responder_inbox;
		this.predictor_inbox  = predictor_inbox;
	endfunction
	
	task run;
			
		Transaction t;
		int i;
		
		t = new(RESET, 40, 20);
		send_transaction(t);

		t = new(MAX_WRITE, 10);
		send_transaction(t);

		t = new(INIT_WRITE, 1);
		send_transaction(t);
		
		t = new(START);
		send_transaction(t);

		t = new(WAIT);
		send_transaction(t);

		for (i = 0; i < 1; ++i) begin
		
			t = new(MAX_WRITE, 4271484375);
			send_transaction(t);

			t = new(START);
			send_transaction(t);

			t = new(WAIT);
			send_transaction(t);

		end
		
		t = new(MAX_WRITE, 30);
		send_transaction(t);

		t = new(START);
		send_transaction(t);

		t = new(WAIT);
		send_transaction(t);
		
	endtask

	task send_transaction(Transaction t);
		bit r;
		driver_inbox.put(t);
		responder_inbox.put(t);
		predictor_inbox.put(t);
		tester_inbox.get(r);
	endtask
	
endclass

class Driver;
	mailbox #(Transaction) inbox;
	
	function new(input mailbox #(Transaction) inbox);
		this.inbox = inbox;
	endfunction
	
	task run;
		Transaction	t;
		string message;
		logic [`DUT_DATA_W-1:0]  csr;
		
		bfm.initialize();
		
		forever begin
			inbox.get(t);

			$sformat(message, "%m:    handling transaction %s", t.tostring());
			print(VERBOSITY_INFO, message);
			
			case(t.transaction_type)
			
				RESET:			begin
										#(t.idle_cycles);
										bfm.reset_system(t.payload);
									end
			
				MAX_WRITE:		begin
										bfm.write_mm_max(0, t.payload, 1, 0, 0);
									end

				INIT_WRITE:		begin
										bfm.write_mm_csr(1, t.payload, 1, 0, 0);
									end
									
			   START:			begin
										bfm.write_mm_csr(0, 1, 1, 0, 0);
										bfm.read_mm_csr(0, csr, 1, 0, 0);
										while (csr == 0) begin 
											bfm.read_mm_csr(0, csr, 1, 0, 0);
										end
									end
									
				WAIT:				begin 
										bfm.read_mm_csr(0, csr, 1, 0, 0);
										while (csr != 1) begin 
											bfm.read_mm_csr(0, csr, 1, 0, 0);
										end
									end

			endcase
		end
	endtask

endclass

class Responder;
	mailbox #(Transaction) 	inbox;
	mailbox #(Response) 		outbox;
	mailbox #(bit)				tester_inbox;
	
  function new(
		input mailbox #(Transaction) 	inbox, 
		input mailbox #(Response) 		outbox,
		input mailbox #(bit) 			tester_inbox);
		this.inbox = inbox;	
		this.outbox = outbox;
		this.tester_inbox = tester_inbox;
	endfunction
	
	task run;
		Response response;
		Transaction	t;
		bit last_eop;
		
		forever begin
			inbox.get(t);

			$sformat(message, "%m: handling transaction %s", t.tostring());
			print(VERBOSITY_INFO, message);
			
			response = new();
			case(t.transaction_type)
			   
			   START:		begin
									last_eop = '0;
									while (~last_eop) begin
										bfm.read_st_source(response.data, response.sop, response.eop);
										outbox.put(response);
										last_eop = response.eop;
									end

								end
							
				default:	;
				
			endcase
				
			tester_inbox.put(1);

		end
	endtask

endclass

class Predictor;

	mailbox #(Transaction) inbox;
	mailbox #(Response) outbox;
	
	function new(
		input mailbox #(Transaction)	inbox, 
		input mailbox #(Response) 		outbox
	);
		this.inbox = inbox;
		this.outbox = outbox;
	endfunction
	
	task run;
	
		Transaction 	t;
		bit 				cutoff_exceeded_eop_sent;
		int unsigned	n;
		logic [`DUT_DATA_W-1:0] max;
		logic [`DUT_DATA_W-1:0] init_value;
		
		max = '0;
		init_value = '0;
		
		forever begin
			Response response;
			inbox.get(t);
			unique case(t.transaction_type)
			
				MAX_WRITE:		max = t.payload;
				
				INIT_WRITE:		init_value = t.payload;

			   START:			begin
										uint36 h[2000];
										uint36 last_2 = 0;
										uint36 last_3 = 0;
										uint36 last_5 = 0;
										uint36 next;
										int i = 0;
										h[0] = 1;
										while(1) begin
												response = new(h[i] * init_value);
												outbox.put(response);
												next = min(min(2 * h[last_2], 3 * h[last_3]), 5 * h[last_5]);
												if (next > max) break;
												++i;
												h[i] = next;
												while (h[last_2] * 2 <= next) ++last_2;
												while (h[last_3] * 3 <= next) ++last_3;
												while (h[last_5] * 5 <= next) ++last_5;
										end
										response = new(0, 0, 1);
										outbox.put(response);
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
		int unsigned count = 0;
		string message  = "*uninitialized*";
				
 		forever begin
			
			predicted_inbox.get(predicted);
			actual_inbox.get(actual);
			
			// count the data items in this packet
			if (actual.eop)
				count = 0;
			else
				++count;
				
			assert(actual.equals(predicted)) begin
			   $sformat(message, "%m: Received: %s   Count: %d", actual.tostring(), count);
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
