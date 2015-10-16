`include "ripplescaler.v"

module CylonLEDs( 
	input wire 			oneMHzClock		/* synthesis LOC="P43" 								*/,
	input wire			reset_n			/* synthesis LOC="24" 								*/,
	output reg [7:0] 	LED				/* synthesis LOC="P28,P40,P39,P38,P34,P33,P32,P31"	*/
	);
	
	RippleScaler #(.BITS(16)) u1rs (
		.inclock(oneMHzClock),
		.outclock(shiftClock)
	);
	
	parameter LEFT 	= 1'b0;
	parameter RIGHT = 1'b1;
	parameter HIGH = 15;
	parameter MEDIUM = 4;
	parameter LOW = 1;
	
	reg 		direction;
	reg [3:0] 	center;
	reg [3:0] 	brightness [0:11];
	integer 	i;
	
	always @(negedge reset_n, posedge shiftClock)
	
		if (!reset_n) 		begin
		
								center = 1;
								direction = LEFT;

							end
		
		else

			begin

				for(i = 2; i <= 9; i = i + 1) 
					brightness[i] = 0;
		
				case(direction) 

					LEFT:	begin
					
								center = center + 1;
					
								brightness[center-2] 	= LOW;
								brightness[center-1] 	= MEDIUM;
								brightness[center] 		= HIGH;
								
								if (center == 9) direction = RIGHT;

							end
						
					RIGHT:	begin

								center = center - 1;
								
								brightness[center] 		= HIGH;
								brightness[center+1] 	= MEDIUM;
								brightness[center+2] 	= LOW;
								
								if (center == 2) direction = LEFT;

							end

				endcase
				
			end
	
	
	parameter OFF	= 1'b0;
	parameter ON 	= 1'b1;	
	reg [3:0] duty;	
	integer j;

	always @(posedge oneMHzClock)
	
		begin

			for(j = 0; j <= 7; j = j + 1)
				if (duty < brightness[j+2])
					LED[j] <= ON; 
				else 
					LED[j] <= OFF;
			
			duty <= duty + 1;
			
		end
			
endmodule

