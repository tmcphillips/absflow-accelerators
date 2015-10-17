`ifndef UP_DOWN_COUNTER
`define UP_DOWN_COUNTER

module UpDownCounter #(parameter SIZE=8)(
	input wire 				up, 
	input wire 				down, 
	input wire				load,
	input wire				reset,
	input wire [SIZE-1:0]	data,
	input wire 				clock,
	output wire 			upAck,
	output wire 			downAck,
	output reg [SIZE-1:0]	counter
);

	parameter IDLE 		= 2'b00;
	parameter UP_ACK 	= 2'b01;
	parameter DOWN_ACK 	= 2'b10;

	assign upAck 	= (state == UP_ACK);
	assign downAck 	= (state == DOWN_ACK);

	reg [1:0] state;
	
	always @(posedge reset, posedge load, posedge clock)
	
		if (reset)			counter <= 0;
			
		else if (load)		counter <= data;
			
		else
		
			case (state)
			
				IDLE:		if (up)
				
								begin
									counter <= counter + 1;
									state <= UP_ACK;
								end
								
							else if (down)
							
								begin
									counter <= counter - 1;
									state <= DOWN_ACK;
								end
								
				UP_ACK:		state <= IDLE;
				
				DOWN_ACK:	state <= IDLE;
				
				default:	state <= IDLE;
				
			endcase
	
endmodule

`endif
