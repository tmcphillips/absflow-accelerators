`include "ripplescaler.v"

module CylonLEDs( 
	input wire 			oneMHzClock		/* synthesis LOC="P43" 								*/,
	input wire			reset_n			/* synthesis LOC="24" 								*/,
	output reg [7:0] 	LEDs			/* synthesis LOC="P28,P40,P39,P38,P34,P33,P32,P31"	*/
	);
	
	RippleScaler #(.BITS(16)) u1rs (
		.inclock(oneMHzClock),
		.outclock(shiftClock)
	);
	
	parameter LEFT 	= 1'b0;
	parameter RIGHT = 1'b1;

	reg direction;
	reg [7:0] center;
	
	reg [3:0] f [0:7];
	
	reg [3:0] pulse;

	integer i;
				
	always @(posedge oneMHzClock)
	
		begin

			for(i = 0; i < 8; i = i + 1)
				if (pulse < f[i]) LEDs[i] <= 1; else LEDs[i] <= 0;
			
			pulse = pulse + 1;
		
		end
	
	always @(negedge reset_n, posedge shiftClock)
	
		if (!reset_n) 
						begin
							center = 8'b00000001;
							direction = LEFT;
						end
		
		else

			begin
		
				case(direction) 

					LEFT:	begin
								center = (center << 1);
								if (center[7]) direction = RIGHT;
							end
						
					RIGHT:	begin
								center = (center >> 1);
								if (center[0]) direction = LEFT;
							end

				endcase
				
				
				case (center)
				
					8'b00000001:	begin
										f[0] = 0;
										f[1] = 0;
										f[2] = 0;
										f[3] = 0;
										f[4] = 0;
										f[5] = 1;
										f[6] = 3;
										f[7] = 15;
									end
					
					8'b00000010:	begin
										f[0] = 0;
										f[1] = 0;
										f[2] = 0;
										f[3] = 0;
										f[4] = 1;
										f[5] = 3;
										f[6] = 15;
										f[7] = 3;
									end

					8'b00000100:	begin
										f[0] = 0;
										f[1] = 0;
										f[2] = 0;
										f[3] = 1;
										f[4] = 3;
										f[5] = 15;
										f[6] = 3;
										f[7] = 1;
									end
									
					8'b00001000:	begin
										f[0] = 0;
										f[1] = 0;
										f[2] = 1;
										f[3] = 3;
										f[4] = 15;
										f[5] = 3;
										f[6] = 1;
										f[7] = 0;
									end
				
					8'b00010000:	begin
										f[0] = 0;
										f[1] = 1;
										f[2] = 3;
										f[3] = 15;
										f[4] = 3;
										f[5] = 1;
										f[6] = 0;
										f[7] = 0;
									end
				
					8'b00100000:	begin
										f[0] = 1;
										f[1] = 3;
										f[2] = 15;
										f[3] = 3;
										f[4] = 1;
										f[5] = 0;
										f[6] = 0;
										f[7] = 0;
									end

					8'b01000000:	begin
										f[0] = 3;
										f[1] = 15;
										f[2] = 3;
										f[3] = 1;
										f[4] = 0;
										f[5] = 0;
										f[6] = 0;
										f[7] = 0;
									end
									
					8'b10000000:	begin
										f[0] = 15;
										f[1] = 3;
										f[2] = 1;
										f[3] = 0;
										f[4] = 0;
										f[5] = 0;
										f[6] = 0;
										f[7] = 0;
									end
				endcase
				
			end
			
			
endmodule

