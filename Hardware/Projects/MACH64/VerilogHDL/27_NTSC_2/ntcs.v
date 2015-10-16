module ntsc( 
	input wire			ntscClock	/* synthesis LOC="P43"				*/,
	input wire 			left_n		/* synthesis LOC="P14" 				*/,
	input wire 			right_n		/* synthesis LOC="P15" 				*/,
	input wire 			up_n		/* synthesis LOC="P16" 				*/,
	input wire			down_n		/* synthesis LOC="P17" 				*/,
	output reg [2:0]	video		/* synthesis LOC="P34,P33,P32"		*/,
	output reg [1:0] 	hState		/* synthesis LOC="P23,P22"			*/,
	output reg [1:0] 	vState		/* synthesis LOC="P21,P20"			*/
);

	reg [5:0] ballX;
	reg [5:0] ballY;
	
	reg [7:0] scanX;
	reg [8:0] scanY;
	
	parameter VERT_VISIBLE		= 2'b00;
	parameter VERT_PRESYNC		= 2'b01;
	parameter VERT_SYNC			= 2'b10;
	parameter VERT_POSTSYNC		= 2'b11;
	
	parameter HORIZ_PRESYNC		= 2'b00;
	parameter HORIZ_SYNC		= 2'b01;
	parameter HORIZ_POSTSYNC	= 2'b10;
	parameter HORIZ_VISIBLE		= 2'b11;
		
	parameter VIDEO_ZERO		= 3'b000;
	parameter VIDEO_BLANKING	= 3'b001;
	parameter VIDEO_BLACK		= 3'b010;
	parameter VIDEO_GREY		= 3'b011;
	parameter VIDEO_WHITE		= 3'b110;
	
	
	// 3.58 MHZ clock --> 0.28 us per cycle
	parameter HORIZ_MIN_X			= 0;
	parameter HORIZ_SYNC_START_X	= 3'd6;
	parameter HORIZ_SYNC_END_X		= 5'd23;
	parameter HORIZ_VISIBLE_START_X	= 6'd40;
	parameter HORIZ_MAX_X			= 8'd225;
	
	parameter VERT_MIN_Y			= 0;
	parameter VERT_VISIBLE_END_Y	= 8'd244;
	parameter VERT_SYNC_START_Y		= 8'd250;
	parameter VERT_SYNC_END_Y		= 9'd256;
	parameter VERT_MAX_Y			= 9'd262;
	
	// scan across pixels on screen at NTSC frequency
	always @(posedge ntscClock)
		begin
		
			// update x scan coordinates
			scanX = scanX + 1;
				
			case(hState)

				HORIZ_PRESYNC:	begin
				
									case(vState)
									
										VERT_SYNC:		video <= VIDEO_ZERO;
										
										VERT_VISIBLE,
										VERT_PRESYNC,
										VERT_POSTSYNC: 	video <= VIDEO_BLANKING;
										
									endcase
									
									if (scanX == HORIZ_SYNC_START_X) hState <= HORIZ_SYNC;
									
								end
								
								
				HORIZ_SYNC:		begin
				
									case(vState)
									
										VERT_SYNC:		video <= VIDEO_BLANKING;
										
										VERT_VISIBLE,
										VERT_PRESYNC,
										VERT_POSTSYNC:	video <= VIDEO_ZERO;
										
									endcase
									
									if (scanX == HORIZ_SYNC_END_X) hState <= HORIZ_POSTSYNC;
									
								end
									
				HORIZ_POSTSYNC:	begin
				
									case(vState)
									
										VERT_SYNC:		video <= VIDEO_ZERO;
										
										VERT_VISIBLE,
										VERT_PRESYNC,
										VERT_POSTSYNC: 	video <= VIDEO_BLANKING;
										
									endcase
									
									if (scanX == HORIZ_VISIBLE_START_X) hState <= HORIZ_VISIBLE;
									
								end

				HORIZ_VISIBLE:	begin
				
									case(vState)
									
										VERT_VISIBLE:	if ((scanX[7:2] == ballX) & scanY[8:3] == ballY)
															video <= VIDEO_WHITE;
														else
															video <= VIDEO_BLACK;
															
										VERT_SYNC:		video <= VIDEO_ZERO;
										
										VERT_POSTSYNC,
										VERT_PRESYNC: 	video <= VIDEO_BLANKING;
										
									endcase
										
									if (scanX == HORIZ_MAX_X)

										begin
										
											scanX = HORIZ_MIN_X;
											scanY = scanY + 1;
											hState <= HORIZ_PRESYNC;
											
											case(vState)
											
												VERT_VISIBLE: 	if (scanY == VERT_VISIBLE_END_Y) 
																	vState <= VERT_PRESYNC;
												
												VERT_PRESYNC:	if (scanY == VERT_SYNC_START_Y) 
																	vState <= VERT_SYNC;
												
												VERT_SYNC:		if (scanY == VERT_SYNC_END_Y) 
																	vState <= VERT_POSTSYNC;
												
												VERT_POSTSYNC:	if (scanY == VERT_MAX_Y) 
																	begin 
																		scanY = VERT_MIN_Y; 
																		vState <= VERT_VISIBLE; 
																	end
											endcase	
											
										end
								
								end
				
			endcase	
			
		end

	// move cursor based on current pressed buttons
	always @(posedge scanY[8])
		begin
			if (!right_n) 	ballX = ballX + 1;
			if (!left_n)  	ballX = ballX - 1;
			if (!down_n)	ballY = ballY + 1;
			if (!up_n)		ballY = ballY - 1;
		end
		
endmodule

