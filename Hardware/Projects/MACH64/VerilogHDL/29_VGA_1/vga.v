module vga( 
	input wire			vgaClock				/* synthesis LOC="P43"											*/,
	input wire 			reset_n					/* synthesis LOC="P16"											*/,
	output wire [1:0]	red						/* synthesis LOC="P34,P33"										*/,
	output wire [1:0]	green					/* synthesis LOC="P32,P31"										*/,
	output wire [1:0]	blue					/* synthesis LOC="P28,P27"										*/,
	output reg			hsync					/* synthesis LOC="P26"											*/,
	output reg			vsync					/* synthesis LOC="P24"											*/,
	output reg [1:0] 	hState					/* synthesis LOC="P23,P22"										*/,
	output reg [1:0] 	vState					/* synthesis LOC="P21,P20"										*/
);

	reg [5:0] video;
	assign {red, green, blue} = video;
	
	
	// scan coordinates
	reg [9:0] pixel;							/* range 800 (0-799), incremented every 39.72 ns				*/
	reg [9:0] line;								/* range 525 (0-524), incremented every 31.78 us				*/
	
	parameter VIDEO_BLACK			= 6'b000000;
	parameter VIDEO_BLUE			= 6'b010001;

	parameter VERT_SYNC				= 2'b00;	/*   2 lines (0-1)		duration = 63.56 us						*/
	parameter VERT_BACK_PORCH		= 2'b01;	/*  33 lines (2-34)		duration = 1.049 ms						*/
	parameter VERT_ACTIVE_VIDEO		= 2'b10;	/* 480 lines (35-514)	duration = 15.25 ms 					*/
	parameter VERT_FRONT_PORCH		= 2'b11;	/*  10 lines (515-524)	duration = 317.8 us						*/
	
 	parameter HORIZ_SYNC			= 2'b00;	/*  96 pixels (0-95)	duration =  3.773 us					*/
	parameter HORIZ_BACK_PORCH		= 2'b01;	/*  48 pixels (96-143)	duration =  1.907 us					*/
	parameter HORIZ_ACTIVE_VIDEO	= 2'b10;	/* 640 pixels (144-783)	duration = 25.143 us					*/
	parameter HORIZ_FRONT_PORCH		= 2'b11;	/*  16 pixels (784-799)	duration =  0.635 us					*/
		
	// line region boundaries
	parameter VERT_SYNC_END				=  1'd   1;
	parameter VERT_BACK_PORCH_END		=  6'd  34;
	parameter VERT_ACTIVE_VIDEO_END 	= 10'd 514;
	parameter VERT_FRONT_PORCH_END		= 10'd 524;

	// pixel region boundaries
	parameter HORIZ_SYNC_END			=  7'd  95;
	parameter HORIZ_BACK_PORCH_END		=  8'd 143;
	parameter HORIZ_ACTIVE_VIDEO_END	= 10'd 783;	
	parameter HORIZ_FRONT_PORCH_END		= 10'd 799;

	parameter PIXEL_MAX					= 10'd 799;
	parameter LINE_MAX					= 10'd 524;

	parameter ACTIVE					= 1'b0;
	parameter INACTIVE					= 1'b1;
	parameter FALSE						= 1'b0;
	parameter TRUE						= 1'b1;
	
	reg newLine;
	
	// scan across pixels on screen at NTSC frequency
	always @(negedge reset_n, posedge vgaClock)

		if (!reset_n) 	begin
							pixel = 0;
							line = 0;
							vState <= VERT_SYNC;
							hState <= HORIZ_SYNC;
							vsync <= INACTIVE;
							hsync <= INACTIVE;
							video <= VIDEO_BLACK;
						end
		
		else begin
		
			newLine = FALSE;
		
			if (pixel < PIXEL_MAX)
				pixel = pixel + 1;
			else 
				begin
					newLine = TRUE;
					pixel = 0;
					if (line < LINE_MAX)
						line = line + 1;
					else
						line = 0;
				end
				
			case(vState)

				VERT_SYNC:			begin
										vsync <= ACTIVE;
										hsync <= INACTIVE;
										if (newLine & (line == VERT_SYNC_END)) vState <= VERT_BACK_PORCH;
									end
								
				VERT_BACK_PORCH:	begin
										vsync <= INACTIVE;
										hsync <= INACTIVE;
										if (newLine & (line == VERT_BACK_PORCH_END)) 
											begin
												vState <= VERT_ACTIVE_VIDEO;
												hState <= HORIZ_SYNC;
											end
									end

				VERT_ACTIVE_VIDEO:	begin
				
										vsync <= INACTIVE;
										
										case(hState)
										
											HORIZ_SYNC:			begin
																	hsync <= ACTIVE;
																	video <= VIDEO_BLACK;
																	if (pixel == HORIZ_SYNC_END) hState <= HORIZ_BACK_PORCH;
																end

											HORIZ_BACK_PORCH:	begin
																	hsync <= INACTIVE;
																	video <= VIDEO_BLACK;
																	if (pixel == HORIZ_BACK_PORCH_END) hState <= HORIZ_ACTIVE_VIDEO;
																end

											HORIZ_ACTIVE_VIDEO:	begin
																	hsync <= INACTIVE;
																	video <= VIDEO_BLUE;
																	if (pixel == HORIZ_ACTIVE_VIDEO_END) hState <= HORIZ_FRONT_PORCH;
																end
																
											HORIZ_FRONT_PORCH:	begin
																	hsync <= INACTIVE;
																	video <= VIDEO_BLACK;
																	if (pixel == HORIZ_FRONT_PORCH_END)
																		begin
																			if (line == VERT_ACTIVE_VIDEO_END) 
																				vState <= VERT_FRONT_PORCH;
																			else
																				hState <= HORIZ_SYNC;
																		end
																end

										endcase
										
									end
									
				VERT_FRONT_PORCH:	begin
										vsync <= INACTIVE;
										hsync <= INACTIVE;
										if (newLine & (line == VERT_FRONT_PORCH_END)) vState <= VERT_SYNC;									
									end
								
			endcase	
			
		end

endmodule

