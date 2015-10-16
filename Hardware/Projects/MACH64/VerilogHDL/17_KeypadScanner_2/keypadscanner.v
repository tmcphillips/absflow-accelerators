`ifndef KEYPAD_SCANNER
`define KEYPAD_SCANNER

module KeypadScanner(
	output reg [3:0] 	rowDrivers_reg,
	input wire 			scanClock,
	input wire [2:0] 	columnReceivers,
	output reg [3:0] 	key_reg
	);

	reg [3:0] pressed_reg [1:3];
	
	always @(posedge scanClock)
	
		begin	
			
			case(rowDrivers_reg)

				4'b0001:	begin
								case(columnReceivers)
									3'b001:		pressed_reg[1] <= 4'b0000;
									3'b010:		pressed_reg[1] <= 4'b0000;
									3'b100:		pressed_reg[1] <= 4'b0000;
								endcase
								rowDrivers_reg <= 4'b0010;
						end
						
				4'b0010:	begin
								case(columnReceivers)
									3'b001:		pressed_reg[1] <= 4'b1001;
									3'b010:		pressed_reg[1] <= 4'b1000;
									3'b100:		pressed_reg[1] <= 4'b0111;
								endcase
								rowDrivers_reg <= 3'b0100;
							end
			
				4'b0100:	begin
								case(columnReceivers)
									3'b001:		pressed_reg[1] <= 4'b0110;
									3'b010:		pressed_reg[1] <= 4'b0101;
									3'b100:		pressed_reg[1] <= 4'b0100;
								endcase
								rowDrivers_reg <= 4'b1000;
							end

				4'b1000:	begin
								case(columnReceivers)
									3'b001:		pressed_reg[1] <= 4'b0011;
									3'b010:		pressed_reg[1] <= 4'b0010;
									3'b100:		pressed_reg[1] <= 4'b0001;
								endcase
								rowDrivers_reg <= 4'b0001;
							end

							
				default: 	rowDrivers_reg <= 4'b0001;

			endcase

			pressed_reg[2] <= pressed_reg[1];
			pressed_reg[3] <= pressed_reg[2];

			if (pressed_reg[1] == (pressed_reg[1] & pressed_reg[2] & pressed_reg[3]))
				key_reg <= pressed_reg[1];
			
		end
			
endmodule

`endif