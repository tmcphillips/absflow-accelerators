`include "ripplescaler.v"

module LcdDemo( 
	input wire reset_n			/* synthesis loc="P20"								*/,
	input wire start_n			/* synthesis loc="P21"								*/,
	inout wire [7:0] data		/* synthesis loc="P45,P40,P39,P38,P34,P33,P32,P31" 	*/,

	output wire e				/* synthesis loc="P28"								*/,
	output wire rw				/* synthesis loc="P27"								*/,
	output wire rs				/* synthesis loc="P26"								*/,
	output wire wack			/* synthesis loc="P46"								*/,
	output reg wreq				/* synthesis loc="P47"								*/,
	input wire clock			/* synthesis loc="P43" 								*/
);

	LCDWriter(
		.e(e),
		.rw(rw),
		.rs(rs),
		.clock(clock),
		.register(register),
		.req(wreq),
		.ack(wack),
		.data(data),
		.value(writeValue),
		.reset(~reset_n)
	);
	
	parameter STATE_0 = 5'b00000;
	parameter STATE_1 = 5'b00001;
	parameter STATE_2 = 5'b00010;
	parameter STATE_3 = 5'b00011;
	parameter STATE_4 = 5'b00100;
	parameter STATE_5 = 5'b00101;
	parameter STATE_6 = 5'b00110;
	parameter STATE_7 = 5'b00111;
	parameter STATE_8 = 5'b01000;
	parameter STATE_9 = 5'b01001;
	parameter STATE_A = 5'b01010;
	parameter STATE_B = 5'b01011;
	parameter STATE_C = 5'b01110;
	parameter STATE_D = 5'b01111;
	parameter STATE_E = 5'b10000;

	parameter LOW 	= 1'b0;
	parameter HIGH 	= 1'b1;

	reg register;
	reg [4:0] state;	
	reg [7:0] writeValue;
	
	always @(negedge reset_n, posedge clock)
		
		if (!reset_n)
			begin
				state <= STATE_0;
				wreq <= LOW;
				register <= LOW;
			end
			
		else

			case(state)
			
				STATE_0:	if (!start_n)
								begin
									writeValue <= 8'b00111000;
									register <= LOW;
									wreq <= HIGH;
									state <= STATE_1;
								end
						
				STATE_1:	begin
								wreq <= LOW;
								if (wack) state <= STATE_2;
							end
							
				STATE_2:	begin
								writeValue <= 8'b00000100;
								register <= LOW;
								wreq <= HIGH;
								state <= STATE_3;
							end

				STATE_3:	begin
								wreq <= LOW;
								if (wack) state <= STATE_4;
							end
							
				STATE_4:	begin
								writeValue <= 8'b00001111;
								register <= LOW;
								wreq <= HIGH;
								state <= STATE_5;
							end

				STATE_5:	begin
								wreq <= LOW;
								if (wack) state <= STATE_6;
							end
							
				STATE_6:	begin
								writeValue <= 8'b00000001;
								register <= LOW;
								wreq <= HIGH;
								state <= STATE_7;
							end

				STATE_7:	begin
								wreq <= LOW;
								if (wack) state <= STATE_8;
							end
							
				STATE_8:	begin
								writeValue <= 8'b01001000;
								register <= HIGH;
								wreq <= HIGH;
								state <= STATE_9;
							end
				
				STATE_9:	begin
								wreq <= LOW;
								if (wack) state <= STATE_A;
							end

				STATE_A:	begin
								writeValue <= "E";
								register <= HIGH;
								wreq <= HIGH;
								state <= STATE_B;
							end
				
				STATE_B:	begin
								wreq <= LOW;
								if (wack) state <= STATE_C;
							end
							
				STATE_C:	begin
								writeValue <= "L";
								register <= HIGH;
								wreq <= HIGH;
								state <= STATE_D;
							end
							
				STATE_D:	begin
								wreq <= LOW;
								if (wack) state <= STATE_E;
							end
							
				STATE_E:	if (start_n) state <= STATE_0;

				default:	state <= STATE_0;

			endcase
		
endmodule
	
module LCDWriter(
	output reg e,
	output reg rw,
	output reg rs,
	input wire clock,
	input wire req,
	input wire register,
	output reg ack,
	input wire [7:0] value,
	inout wire [7:0] data,
	input reset
	);
	
	parameter LOW 	= 1'b0;
	parameter HIGH 	= 1'b1;
	
	parameter WAIT_WRITE_REQ 	= 4'b0000;
	parameter WRITE_0 			= 4'b0001;
	parameter WRITE_1 			= 4'b0010;
	parameter WRITE_3 			= 4'b0011;
	parameter WRITE_4 			= 4'b0100;
	parameter WRITE_2 			= 4'b0101;
	parameter WRITE_5			= 4'b1101;
	parameter READ_BF_0 		= 4'b0110;
	parameter READ_BF_1 		= 4'b0111;
	parameter READ_BF_2 		= 4'b1000;
	parameter READ_BF_3 		= 4'b1001;
	parameter READ_BF_4 		= 4'b1010;
	parameter READ_BF_5 		= 4'b1011;
	parameter ACK_WRITE 		= 4'b1100;

	assign data = outData;
	
	reg [7:0] outData;
	reg [3:0] state;
	reg busyFlag;
	
	always @(posedge reset, posedge clock)
	
		if (reset)
		
			state <= WAIT_WRITE_REQ;
		
		else
		
			case (state)
			
				WAIT_WRITE_REQ:		begin
										outData <= 8'bzzzzzzzz;
										ack <= LOW;
										e <= LOW;
										rw <= LOW;
										rs <= LOW;
										if (req) state <= WRITE_0;
									end
								
				WRITE_0:			begin
										outData <= value;
										rs <= register;
										state <= WRITE_1;
									end	

				WRITE_1:			begin
										e <= HIGH;
										state <= WRITE_2;
									end
									
				WRITE_2:			state <= WRITE_3;
						
				WRITE_3:			begin
										e <= LOW;
										state <= WRITE_4;
									end
						
				WRITE_4:			begin
										outData <= 8'bzzzzzzzz;
										state <= WRITE_5;
									end
									
				WRITE_5:			state <= READ_BF_0;

				READ_BF_0:			begin
										rw <= HIGH;
										rs <= LOW;
										state <= READ_BF_1;
									end
				
				READ_BF_1:			begin
										e <= HIGH;
										state <= READ_BF_2;
									end

				READ_BF_2:			state <= READ_BF_3;
									
				READ_BF_3:			begin
										busyFlag <= data[7];
										state <= READ_BF_4;
									end
									
				READ_BF_4:			begin
										e <= LOW;
										state <= READ_BF_5;
									end
				
				READ_BF_5:			if (busyFlag == LOW) 
										state <= ACK_WRITE;
									else
										state <= READ_BF_1;

				ACK_WRITE:			begin
										ack <= HIGH;
										state <= WAIT_WRITE_REQ; 
									end
								
				default:			state <= WAIT_WRITE_REQ;
				
			endcase
			
endmodule

