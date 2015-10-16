module LcdDemo( 
	input wire reset_n			/* synthesis loc="P20"								*/,
	input wire start_n			/* synthesis loc="P21"								*/,
	inout wire [7:0] lcd_data	/* synthesis loc="P45,P40,P39,P38,P34,P33,P32,P31" 	*/,

	output wire lcd_e			/* synthesis loc="P28"								*/,
	output wire lcd_rw			/* synthesis loc="P27"								*/,
	output wire lcd_rs			/* synthesis loc="P26"								*/,
	output wire wack			/* synthesis loc="P46"								*/,
	output reg wreq				/* synthesis loc="P47"								*/,
	input wire clock			/* synthesis loc="P43" 								*/
);

	parameter LOW 			= 1'b0;
	parameter HIGH 			= 1'b1;
	parameter RS_DATA 		= 1'b1;
	parameter RS_CONTROL 	= 1'b0;
	parameter STATE_0 		= 1'b0;
	parameter STATE_1 		= 1'b1;
	parameter STOP 			= 9'b11xxxxxxx;
	
	parameter SF_8BIT		= 1'b1;
	parameter SF_LINES_2	= 1'b1;
	parameter SF_FONT_5x8	= 1'b1;
	parameter SM_CURSOR_FWD	= 1'b1;
	parameter SM_SHIFT_OFF  = 1'b0;
	parameter DC_LCD_OFF 	= 1'b0;
	parameter DC_LCD_ON		= 1'b1;
	parameter DC_CURSOR_OFF	= 1'b0; // disables unblinking cursor underscore
	parameter DC_CURSOR_ON  = 1'b1; // enables unblinking cursor underscore
	parameter DC_BLINK_OFF	= 1'b0; // disables blinking character-sized cursor
	parameter DC_BLINK_ON	= 1'b1;	// enables blinking character-sized cursor

	parameter SET_FUNCTION	= { 3'b001, 
								SF_8BIT, 
								SF_LINES_2, 
								SF_FONT_5x8, 
								2'bxx	
							  };

	parameter SET_MODE	 	= { 6'b000001, 
								SM_CURSOR_FWD, 
								SM_SHIFT_OFF 
							  };
	
	
	parameter DISPLAY_CTRL	= { 5'b00001, 
								DC_LCD_ON, 
								DC_CURSOR_OFF, 
								DC_BLINK_OFF
							  };	

	parameter CLEAR_LCD		= 8'b00000001;
	
	
	reg	state;	
	reg	[4:0] 	pc;
	wire [8:0] 	program [0:17];
	
	assign program[0]  	= { RS_CONTROL, SET_FUNCTION	};
	assign program[1]  	= { RS_CONTROL, SET_MODE 		};
	assign program[2]  	= { RS_CONTROL, DISPLAY_CTRL	};
	assign program[3]  	= { RS_CONTROL,	CLEAR_LCD		};
	assign program[4]	= { RS_CONTROL, SET_POS(4,0)	};
	assign program[5]  	= { RS_DATA, 	"H" 			};
	assign program[6]  	= { RS_DATA, 	"e" 			};
	assign program[7]  	= { RS_DATA, 	"l" 			};
	assign program[8]  	= { RS_DATA, 	"l" 			};
	assign program[9]  	= { RS_DATA, 	"o" 			};
	assign program[10]	= { RS_CONTROL, SET_POS(6,1)	};
	assign program[11]  = { RS_DATA, 	"W" 			};
	assign program[12]	= { RS_DATA, 	"o" 			};
	assign program[13] 	= { RS_DATA, 	"r" 			};
	assign program[14] 	= { RS_DATA, 	"l" 			};
	assign program[15] 	= { RS_DATA, 	"d"				};
	assign program[16] 	= { RS_DATA, 	"!" 			};
	assign program[17] 	= { STOP 						};

	wire [8:0] statement 	= program[pc];
	wire [7:0] writeValue 	= statement[7:0];
	wire registerSelect		= statement[8];
	wire stop 				= registerSelect & statement[7];

	always @(negedge reset_n, posedge clock)
	
		if (!reset_n)
			begin
				pc 		<= 	5'b00000;
				state 	<= STATE_0;
				wreq	<= LOW;
			end
			
		else

			case(state)
			
				STATE_0:	if (!start_n & !stop)
								begin
									wreq <= HIGH;
									state <= STATE_1;
								end
						
				STATE_1:	begin
								wreq <= LOW;
								if (wack)
									begin
										pc <= pc + 1;
										state <= STATE_0;
									end
							end

				default:	state <= STATE_0;

			endcase		
		
	LCDWriter u0lcdw (
		.e(lcd_e),
		.rw(lcd_rw),
		.rs(lcd_rs),
		.clock(clock),
		.register(registerSelect),
		.req(wreq),
		.ack(wack),
		.data(lcd_data),
		.value(writeValue),
		.reset(~reset_n)
	);
	
	function [7:0] SET_POS;
		input integer x;
		input integer y;
		reg [6:0] coord;
		begin
			coord	=  x + 40 * y;
			SET_POS	= { 1'b1, coord };
		end
	endfunction
	
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
			
			begin
				e <= LOW;
				rw <= LOW;
				rs <= LOW;
				ack <= LOW;
				busyFlag <= LOW;
				outData <= 8'bzzzzzzzz;
				
				state <= WAIT_WRITE_REQ;
			end
			
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
										state <= READ_BF_0;
									end
									
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

