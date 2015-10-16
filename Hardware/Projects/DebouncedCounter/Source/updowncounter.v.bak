`ifndef UP_DOWN_COUNTER
`define UP_DOWN_COUNTER

`include "macros.v"

`ifdef ASSERTIONS_ON
`include "std_ovl_defines.h"
`endif

module updowncounter #(parameter SIZE=8)(
	input wire 				up, 
	input wire 				down, 
	input wire				load,
	input wire				reset,
	input wire [SIZE-1:0]	data,
	input wire 				clock,
	output reg 			ack,
	output reg [SIZE-1:0]	counter
);

	localparam IDLE 	= 3'b000;
	localparam WAIT_UP_LOW     = 3'b001;
	localparam WAIT_DOWN_LOW   = 3'b010;
	localparam WAIT_LOAD_LOW   = 3'b011;
	localparam ACK_RESET       = 3'b100;
	localparam WAIT_RESET_LOW  = 3'b101;

	reg [2:0] state;
	
	always @(posedge reset, posedge clock)
  	
		if (reset)	begin
								counter <= 4'b0000;
								ack <= `LOW;
								state <= ACK_RESET;
							end
							
	  else case (state)
			
				IDLE:		         if (up) begin
									        counter <= counter + 1'b1;
									        ack <= `HIGH;
									        state <= WAIT_UP_LOW;
								        end
								
							          else if (down) begin
									        counter <= counter - 1'b1;
									        state <= WAIT_DOWN_LOW;
									        ack <= `HIGH;
							          end
								
							          else if (load)  begin
							            counter <= data;
									        ack <= `HIGH;
							            state <= WAIT_LOAD_LOW;
							          end
				
				WAIT_UP_LOW:    begin
				                  ack <= `LOW;
				                  if (!up) state <= IDLE;
				                end

				WAIT_DOWN_LOW:  begin
				                  ack <= `LOW;  
				                  if (!down) state <= IDLE;
                        end
                
				WAIT_LOAD_LOW:  begin
				                  ack <= `LOW;
				                  if (!load) state <= IDLE;
				                end
				
				ACK_RESET:      begin 
				                  ack <= `HIGH;
				                  state <= WAIT_RESET_LOW;
				                end
				
				WAIT_RESET_LOW: begin
				                  ack <= `LOW;
				                  if (!reset) state <= IDLE;
				                end
				                
				default:        state <= IDLE;
				
			endcase
	
		
	// instantiate firewall
	UpDownCounter_Firewall #(.SIZE(SIZE)) u0_firewall (
		.up(up), 
		.down(down), 
		.reset(reset),
		.data(data),
		.clock(clock),
		.upAck(upAck),
		.downAck(downAck),
		.counter(counter),
		.state(state)
	);
	
endmodule

module UpDownCounter_Firewall #(parameter SIZE=8)(
	input  				      up, 
	input  				      down, 
	input 			        reset,
	input [SIZE-1:0]	data,
	input  				      clock,
	input  				      upAck,
	input  				      downAck,
	input [SIZE-1:0]	counter,
	input [2:0]			   state
);

`ifdef ASSERTIONS_ON

	wire [`OVL_FIRE_WIDTH-1:0] fire;

	ovl_never #(.reset_polarity(`OVL_ACTIVE_HIGH)) u_never_up_and_down(
		.clock(clock),
		.reset(reset),
		.enable(~reset),
		.fire(fire),
		.test_expr((up & down))
	);

`endif

endmodule

`endif
