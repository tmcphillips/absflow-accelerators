`include "macros.v"
`include "buttonpressdetector.v"

module buttonpressdetector_tb;

	reg buttonDown;
	reg ackPress;
	reg clock;
	reg reset;
	wire wasPressed;	
	wire [2:0] state = u0dut.state;


	// Instantiate the Unit Under Test (UUT)
	buttonpressdetector u0dut (
		.buttonDown(buttonDown), 
		.ackPress(ackPress), 
		.clock(clock), 
		.reset(reset), 
		.wasPressed(wasPressed)
	);

	// generate system clock signal
	always #1 clock = ~clock;
		
	initial begin

		// set time format
		$printtimescale;
		$timeformat(-6, 10, "", 10);

		// Initialize Inputs
		buttonDown 	= `LOW;
		ackPress		= `LOW;
		clock			= `LOW;
		reset			= `LOW;
        
		resetSystem();
		testLongButtonPress();
		testShortButtonPress();
		testShortButtonBounce();
		testShorterButtonBounce();
		testShortestButtonBounce();
		
		$write("*** SUCCESS ***  Simulation ended succesfully at t = %t \n", $realtime);
		$finish;

	end

	task resetSystem();
		begin

			#2		reset = `HIGH;
			#2		reset = `LOW;
					assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);
		end
	endtask

	task testLongButtonPress(); 
		begin
	
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_1	);
					assert(	wasPressed 	== 	`LOW					);

			#2	 assert(	state 		== 	u0dut.DEBOUNCE_2	);
					assert(	wasPressed 	== 	`LOW);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_3	);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);

			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		ackPress = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		ackPress = `LOW;
			
					assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `LOW;
			
					assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
		
		end		
	endtask

	task testShortButtonPress(); 
		begin
	
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_1	);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_2	);
					assert(	wasPressed 	== 	`LOW);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_3	);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);

			#2		buttonDown = `LOW;
					
					assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);

			#2		ackPress = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_PRESSED	);
					assert(	wasPressed 	== 	`HIGH					);
			
			#2		assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		ackPress = `LOW;
			
					assert(	state 		== 	u0dut.WAIT_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
		
		end		
	endtask
	
		task testShortButtonBounce(); 
		begin
	
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_1	);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_2	);
					assert(	wasPressed 	== 	`LOW					);

			#2		buttonDown = `LOW;
			
					assert(	state 		== 	u0dut.DEBOUNCE_3	);
					assert(	wasPressed 	== 	`LOW					);
								
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
					
		end		
	endtask
	
	task testShorterButtonBounce(); 
		begin
	
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.DEBOUNCE_1	);
					assert(	wasPressed 	== 	`LOW					);

			#2		buttonDown = `LOW;
			
					assert(	state 		== 	u0dut.DEBOUNCE_2	);
					assert(	wasPressed 	== 	`LOW					);
								
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
					
		end		
	endtask
	

	task testShortestButtonBounce(); 
		begin
	
			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
			
			#2		buttonDown = `HIGH;
			
					assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);

			#2		buttonDown = `LOW;
					assert(	state 		== 	u0dut.DEBOUNCE_1	);
					assert(	wasPressed 	== 	`LOW					);

			#2		assert(	state 		== 	u0dut.BTN_UP		);
					assert(	wasPressed 	== 	`LOW					);
					
		end		
	endtask

endmodule



