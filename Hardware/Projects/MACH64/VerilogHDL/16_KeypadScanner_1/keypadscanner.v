`ifndef KEYPAD_SCANNER
`define KEYPAD_SCANNER

module KeypadScanner(
	input wire [3:0] 	rowReceivers,
	input wire 			scanClock,
	output reg [2:0] 	columnDrivers_reg,
	output reg [3:0] 	key_reg
	);

	reg [3:0] pressed_reg [1:3];
	
	always @(posedge scanClock)
	
		begin	
			
			case(columnDrivers_reg)

				3'b001:	begin
							case(rowReceivers)
								4'b0001:	pressed_reg[1] <= 4'b0000;
								4'b0010:	pressed_reg[1] <= 4'b1001;
								4'b0100:	pressed_reg[1] <= 4'b0110;
								4'b1000:	pressed_reg[1] <= 4'b0011;
							endcase
							columnDrivers_reg <= 3'b010;
						end
						
				3'b010:	begin
							case(rowReceivers)
								4'b0001:	pressed_reg[1] <= 4'b0000;
								4'b0010:	pressed_reg[1] <= 4'b1000;
								4'b0100:	pressed_reg[1] <= 4'b0101;
								4'b1000:	pressed_reg[1] <= 4'b0010;
							endcase
							columnDrivers_reg <= 3'b100;
						end
			
				3'b100:	begin
							case(rowReceivers)
								4'b0001:	pressed_reg[1] <= 4'b0000;
								4'b0010:	pressed_reg[1] <= 4'b0111;
								4'b0100:	pressed_reg[1] <= 4'b0100;
								4'b1000:	pressed_reg[1] <= 4'b0001;
							endcase
							columnDrivers_reg <= 3'b001;
						end
							
				default: 	columnDrivers_reg <= 3'b001;

			endcase

			pressed_reg[2] <= pressed_reg[1];
			pressed_reg[3] <= pressed_reg[2];

			if (pressed_reg[1] == (pressed_reg[1] & pressed_reg[2] & pressed_reg[3]))
				key_reg <= pressed_reg[1];
			
		end
			
endmodule

`endif