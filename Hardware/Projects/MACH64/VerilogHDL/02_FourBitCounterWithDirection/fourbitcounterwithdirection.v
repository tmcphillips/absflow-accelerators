module FourBitCounterWithDirection(counter, clock, reset, direction);

	input wire clock 			/* synthesis loc="P18" 		   		*/;
	input wire reset 			/* synthesis loc="P20" 		   		*/;
	input wire direction		/* synthesis loc="P21" 		   		*/;
	
	output reg [3:0] counter	/* synthesis loc="P14,P15,P16,P17" 	*/;

	always @(negedge clock, negedge reset)
		if (!reset) 
			counter = 4'b000;
		else
			if (direction) 
				counter = counter + 1;
			else 
				counter = counter - 1;
endmodule

