module ntsc( 
	input wire			ntscClock	/* synthesis LOC="P43"				*/,
	input wire 			left_n		/* synthesis LOC="P14" 				*/,
	input wire 			right_n		/* synthesis LOC="P15" 				*/,
	input wire 			up_n		/* synthesis LOC="P16" 				*/,
	input wire			down_n		/* synthesis LOC="P17" 				*/,
	output reg [3:0]	video		/* synthesis LOC="P34,P33,P32,P31"	*/,
	output reg [3:0] 	state		/* synthesis LOC="P23,P22,P21,P20"	*/
);

	reg [4:0] xpos;
	reg [4:0] ypos;
	
	reg [7:0] x;
	reg [8:0] y;
	
	parameter HSYNC_FRONT 		= 4'b0001;
	parameter HSYNC_TIP 		= 4'b0010;
	parameter HSYNC_BACK 		= 4'b0011;
	parameter ACTIVE_VIDEO 		= 4'b0101;
	parameter PRE_VSYNC_FRONT	= 4'b0110;
	parameter PRE_VSYNC_TIP 	= 4'b0111;
	parameter PRE_VSYNC_BLANK 	= 4'b1000;
	parameter VSYNC_FRONT 		= 4'b1001;
	parameter VSYNC_TIP 		= 4'b1010;
	parameter VSYNC_BACK 		= 4'b1011;
	parameter POST_VSYNC_FRONT 	= 4'b1100;
	parameter POST_VSYNC_TIP 	= 4'b1101;
	parameter POST_VSYNC_BLANK 	= 4'b1110;
	
	parameter VIDEO_ZERO		= 4'b0000;
	parameter VIDEO_BLANKING	= 4'b0010;
	parameter VIDEO_BLACK		= 4'b0011;
	parameter VIDEO_GREY		= 4'b0110;
	parameter VIDEO_WHITE		= 4'b1010;
	
	// scan across pixels on screen at NTSC frequency
	always @(posedge ntscClock)
		begin
		
			// update x and y scan coordiantes
			x = x + 1;
			if (x == 224) 
				begin
					x = 0;				
					y = y + 1;
					if (y == 262) 
						y = 0;
				end
				
			case(state)

				HSYNC_FRONT:		begin
										video <= VIDEO_BLANKING;
										if (x == 3'd5) state = HSYNC_TIP;
									end
									
				HSYNC_TIP:			begin
										video <= VIDEO_ZERO;
										if (x == 5'd22) state = HSYNC_BACK;
									end
									
				HSYNC_BACK:			begin
										video <= VIDEO_BLANKING;
										if (x == 6'd39) state = ACTIVE_VIDEO;
									end
													
				ACTIVE_VIDEO:		begin
										if (x == 0)
											begin
												if (y == 8'd244)
													state = PRE_VSYNC_FRONT;
												else
													state = HSYNC_FRONT;
											end
										else
											if (x[6:2] == xpos & y[6:3] == ypos[4:1])
												video <= VIDEO_WHITE;
											else
												video <= VIDEO_GREY;
									end
				
				PRE_VSYNC_FRONT:	begin
										video <= VIDEO_BLANKING;
										if (x == 3'd5) state = PRE_VSYNC_TIP;			
									end
								
				PRE_VSYNC_TIP:		begin
										video <= VIDEO_ZERO;
										if (x == 5'd22) state = PRE_VSYNC_BLANK;
									end
				
				PRE_VSYNC_BLANK:	begin
										video <= VIDEO_BLANKING;
										if (x == 0)
											begin
												if (y == 8'd250)
													state = VSYNC_FRONT;
												else
													state = PRE_VSYNC_FRONT;
											end
									end
								
				VSYNC_FRONT:		begin
										video <= VIDEO_ZERO;
										if (x == 3'd5) state = VSYNC_TIP;
									end
									
				VSYNC_TIP:			begin
										video <= VIDEO_BLANKING;
										if (x == 5'd22) state = VSYNC_BACK;
									end
									
				VSYNC_BACK:			begin
										video <= VIDEO_ZERO;
										if (x == 0)
											begin
												if (y == 9'd256)
													state = POST_VSYNC_FRONT;
												else
													state = VSYNC_FRONT;
											end
									end
									
				POST_VSYNC_FRONT:	begin
										video <= VIDEO_BLANKING;
										if (x == 3'd5) state = POST_VSYNC_TIP;			
									end
								
				POST_VSYNC_TIP:		begin
										video <= VIDEO_ZERO;
										if (x == 5'd22) state = POST_VSYNC_BLANK;
									end
				
				POST_VSYNC_BLANK:	begin
										video <= VIDEO_BLANKING;
										if (x == 0)
											begin
												if (y == 0)
													state = HSYNC_FRONT;
												else
													state = POST_VSYNC_FRONT;
											end
									end
									
				default:			state = HSYNC_FRONT;
				
			endcase	
			
		end

	// move cursor based on current pressed buttons
	always @(posedge y[8])
		begin
			if (!right_n) 	xpos = xpos + 1;
			if (!left_n)  	xpos = xpos - 1;
			if (!down_n)	ypos = ypos + 1;
			if (!up_n)		ypos = ypos - 1;
		end
		
endmodule

