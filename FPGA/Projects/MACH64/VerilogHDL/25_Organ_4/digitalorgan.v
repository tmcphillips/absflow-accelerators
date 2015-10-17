`include "ripplecounter.v"
`include "ripplescaler.v"
`include "clocksynthesizer.v"

module DigitalOrgan(
	input wire 			oneMHzClock		/* synthesis LOC="P43" 				*/,
	output reg [1:4]	toneOut			/* synthesis LOC="P31,P32,P33,P34"	*/
);

	// scale down the 1 MHz system clock to yield a base clock
	// for synthesizing the four note tones.  This saves having
	// to scale down by a factor of 16 in each of the four 
	// clock synthesizers, for a total saving of 12 registers and 
	// associated adder logic.
	RippleScaler #(.BITS(4)) u0rs (
		.inclock(oneMHzClock),
		.outclock(toneBaseClock)
	);

	// define parameters for synthesizing (octave 5) C, D, F, and G notes
	parameter C5_TONE_FREQ 		= 523;
	parameter D5_TONE_FREQ 		= 587;
	parameter E5_TONE_FREQ 		= 659;
	parameter G5_TONE_FREQ 		= 784;
	parameter TONE_BASE_FREQ 	= 62500;
	
	wire [1:4] noteTone;
				 
	ClockSynthesizer #(.IN_FREQ(TONE_BASE_FREQ), .OUT_FREQ(C5_TONE_FREQ), .BITS(6)) u3cs (
		.inclock(toneBaseClock),
		.outclock(noteTone[1])
	);

	ClockSynthesizer #(.IN_FREQ(TONE_BASE_FREQ), .OUT_FREQ(D5_TONE_FREQ), .BITS(6)) u4cs (
		.inclock(toneBaseClock),
		.outclock(noteTone[2])
	);

	ClockSynthesizer #(.IN_FREQ(TONE_BASE_FREQ), .OUT_FREQ(E5_TONE_FREQ), .BITS(6)) u5cs (
		.inclock(toneBaseClock),
		.outclock(noteTone[3])
	);

	ClockSynthesizer #(.IN_FREQ(TONE_BASE_FREQ), .OUT_FREQ(G5_TONE_FREQ), .BITS(6)) u6cs (
		.inclock(toneBaseClock),
		.outclock(noteTone[4])
	);

	// scale down the 62.5 KHz tone base clock to yield the base
	// clock for the metronome clock
	RippleScaler #(.BITS(12)) u1rs (
		.inclock(toneBaseClock),
		.outclock(metronomeBaseClock)
	);

	// exposing the final three bits of the metronome clock allows
	// the final 1/8 of a quarter note to be tagged as silent thus 
	// yielding a break between distinct notes in the song
	wire [2:0] metronomeCounter;
	RippleCounter #(.SIZE(3)) u2rc (
		.up(metronomeBaseClock),
		.value(metronomeCounter)
	);

	// declare variables used to decode each line of the song
	reg [4:0] 	songLineIndex;
	reg [1:5]	songLine;
	reg [1:4] 	currentNote;
	reg 		breakAfterNote;
	
	// decode next line of song when the metronome counter 
	// transitions to 3'b111 to 3'b000, i.e. on negedge metronomeCounter[2]
	always @(negedge metronomeCounter[2])
		begin
			songLine		=  	song[songLineIndex];
			currentNote 	= 	songLine[1:4];
			breakAfterNote 	= 	songLine[5];
			songLineIndex	= 	songLineIndex + 1;
		end

	// no tone should be emitted if there is a break after the current note 
	// and the metronome counter is in the last eighth of its cycle
	wire inBreakAfterNote = breakAfterNote & (metronomeCounter == 3'b111);
		
	// enable emission of the four tones whenever corresponding notes are specified 
	// by the current line of the song and if not currently in break between notes
	integer i;
	always @(currentNote, noteTone, inBreakAfterNote)
		for(i = 1; i <= 4; i = i + 1)
			toneOut[i] = currentNote[i] & noteTone[i] & !inBreakAfterNote;

	// Define a song 8 full notes in length, specifying the 
	// notes to play during each quarter note of time, for
	// a song program length of 32 lines. 
	// Each line of the song comprises 4 bits indicating
	// which tones are to be active, and 1 bit indicating
	// if there should be a brief break at the end of the current
	// quarter note of tones.

	wire [1:5] song [0:31];
	parameter C 	= 4'b1000;
	parameter D 	= 4'b0100;
	parameter E 	= 4'b0010;
	parameter G 	= 4'b0001;
	parameter HOLD 	= 1'b0;
	parameter BREAK	= 1'b1;

	// Mary Had a Little Lamb
	
	assign song[0] 	=	{E, BREAK};
	assign song[1] 	= 	{D, BREAK};
	assign song[2] 	= 	{C, BREAK};
	assign song[3] 	= 	{D, BREAK};
	
	assign song[4] 	= 	{E, BREAK};
	assign song[5]	= 	{E, BREAK};
	assign song[6] 	= 	{E, HOLD};
	assign song[7] 	= 	{E, BREAK};
	
	assign song[8] 	= 	{D, BREAK};
	assign song[9] 	= 	{D, BREAK};
	assign song[10] = 	{D, HOLD};
	assign song[11] = 	{D, BREAK};
	
	assign song[12] = 	{E, BREAK};
	assign song[13] = 	{G, BREAK};
	assign song[14] = 	{G, HOLD};
	assign song[15] = 	{G, BREAK};

	assign song[16]	= 	{E, BREAK};
	assign song[17]	= 	{D, BREAK};
	assign song[18]	= 	{C, BREAK};
	assign song[19]	= 	{D, BREAK};
	
	assign song[20]	= 	{E, BREAK};
	assign song[21]	= 	{E, BREAK};
	assign song[22]	= 	{E, BREAK};
	assign song[23]	= 	{E, BREAK};
	
	assign song[24]	= 	{D, BREAK};
	assign song[25]	= 	{D, BREAK};
	assign song[26] = 	{E, BREAK};
	assign song[27] = 	{D, BREAK};
	
	assign song[28] = 	{C, HOLD};
	assign song[29] = 	{C, HOLD};
	assign song[30] = 	{C, HOLD};
	assign song[31] = 	{C, BREAK};
						
endmodule

	