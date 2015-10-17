/*
	                 ****  Wiring  *****
	1. 	Connect pin 43 (ntscClock) to a 3.58 MHz clock source.
	2. 	Connect P34, P33, P32 (video[2], video[1], and video[0] to 
		to the 220 ohm, 470 ohm, and 1K ohm resister inputs of 
		a 3-bit DAC.
	3.  Connect the output of the 3-bit DAC to the signal wire of
		of a composite video cable (central pin of an RCA connector).
		
					  **** Notes ****
	1. Resistor values in DAC design assume a 75 ohm impedance on
	   the part of the video receiver (75 ohm resistance between the
	   input connector and ground) and this system will yield a maximum 
	   of ~1V when connected to such an input.
*/

module ntscPong( 
	input wire			ntscClock				/* synthesis LOC="P43"											*/,
	input wire 			reset_n					/* synthesis LOC="P16"											*/,
	output reg [2:0]	video					/* synthesis LOC="P34,P33,P32"									*/,
	output reg [1:0] 	hState					/* synthesis LOC="P23,P22"										*/,
	output reg [1:0] 	vState					/* synthesis LOC="P21,P20"										*/
);

	parameter VERT_VISIBLE			= 2'b00;	/* scan is in 244 visible vertical scan lines					*/
	parameter VERT_PRESYNC			= 2'b01;	/* scan is in the six pre-equalization scan lines				*/
	parameter VERT_SYNC				= 2'b10;	/* scan is in the six vertical sync scan lines					*/
	parameter VERT_POSTSYNC			= 2'b11;	/* scan is in the six post-equalization scan lines				*/
	
	parameter HORIZ_PRESYNC			= 2'b00;	/* scan is in the front-porch of horizontal scan				*/
	parameter HORIZ_SYNC			= 2'b01;	/* scan is in the sync tip of horizontal scan					*/
	parameter HORIZ_POSTSYNC		= 2'b10;	/* scan is between sync tip and visible part of horizontal scan	*/
	parameter HORIZ_VISIBLE			= 2'b11;	/* scan is in the visible of the horizontal scan				*/
		
	// video output signal levels
	parameter VIDEO_ZERO			= 3'b000;	/* output signal = 0.00 V										*/
	parameter VIDEO_BLANKING		= 3'b001;	/* output signal = 0.15 V										*/
	parameter VIDEO_BLACK			= 3'b010;	/* output signal = 0.32 V										*/
	parameter VIDEO_WHITE			= 3'b110;	/* output signal = 1.00 V										*/
		
	// horizontal scan line region boundaries
	parameter HORIZ_MIN_X			= 1'd0;		/* start of horizontal scan line								*/	
	parameter HORIZ_SYNC_START_X	= 3'd6;		/* beginning of horizontal sync tip =  1.7 us					*/
	parameter HORIZ_SYNC_END_X		= 5'd23;	/* end of horizontal sync tip		=  6.4 us (width = 4.7 us)	*/
	parameter HORIZ_VISIBLE_START_X	= 6'd40;	/* start of active video region		= 11.1 us 					*/
	parameter HORIZ_MAX_X			= 8'd225;	/* end of horizontal scan line 		= 62.9 us			 		*/

	// vertical scan region boundaries
	parameter VERT_MIN_Y			= 1'd0;		/* first vertical scan line										*/
	parameter VERT_VISIBLE_END_Y	= 8'd244;	/* first pre-equalization scan line								*/
	parameter VERT_SYNC_START_Y		= 8'd250;	/* first vertical scan line										*/
	parameter VERT_SYNC_END_Y		= 9'd256;	/* first post-equalization scan line							*/
	parameter VERT_MAX_Y			= 9'd262;	/* last vertical scan line										*/
	
	// scan coordinates
	reg [7:0] scanX;							/* range  0 - 225 												*/
	reg [8:0] scanY;							/* range  0 - 262												*/
	
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
		
	parameter BALL_MIN_X	= 11;
	parameter BALL_MAX_X 	= 55;
	parameter BALL_MIN_Y 	= 2;
	parameter BALL_MAX_Y	= 30;
	
	parameter LEFT			= 1'b0;
	parameter RIGHT			= 1'b1;
	parameter UP			= 1'b0;
	parameter DOWN			= 1'b1;

	reg [5:0] ballX;
	reg [5:0] ballY;
	reg ballDirectionX;
	reg ballDirectionY;
	
	// move cursor based on current pressed buttons
	always @(negedge reset_n, posedge scanY[8])
	
		if (!reset_n)
		
			begin
				// start ball at center of screen
				ballX = (BALL_MIN_X + BALL_MAX_X) / 2;
//				ballY = (BALL_MIN_Y + BALL_MAX_Y) / 2;
			
				// start ball moving in positive horizontal and vertical directions
				ballDirectionX = RIGHT;
				ballDirectionY = DOWN;
			end

		else 

			begin
			
				// move ball horizontally according to current direction
				if (ballDirectionX == RIGHT) 
					ballX = ballX + 1;
				else 
					ballX = ballX - 1;
					
				// move ball vertically according to current direction
				if (ballDirectionY == DOWN)
					ballY = ballY + 1;
				else
					ballY = ballY - 1;
				
				// reverse horizontal direction of ball if at max or min horizontal position
				if (ballX == BALL_MAX_X)
					ballDirectionX = LEFT;
				else if (ballX == BALL_MIN_X)  	
					ballDirectionX = RIGHT;
				
				// reverse vertical direction of ball if at max or min vertical position
				if (ballY == BALL_MAX_Y) 
					ballDirectionY = UP;
				else if (ballY == BALL_MIN_Y)
					ballDirectionY = DOWN;
				
			end
		
endmodule

