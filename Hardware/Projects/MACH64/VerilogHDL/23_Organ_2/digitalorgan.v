`include "ripplecounter.v"
`include "clocksynthesizer.v"

module DigitalOrgan(
	input wire 			oneMHzClock		/* synthesis LOC="P43" 				*/,
	input wire [1:4]	button_n		/* synthesis LOC="P21,P22,P23,P24" 	*/,
	input wire [1:0]	octaveSelect_n	/* synthesis LOC="P16,P17"			*/,
	output wire 		noteOutC		/* synthesis LOC="P31"				*/,
	output wire 		noteOutD		/* synthesis LOC="P32"				*/,
	output wire 		noteOutE		/* synthesis LOC="P33"				*/,
	output wire 		noteOutF		/* synthesis LOC="P34"				*/
);

	wire note_c;
	wire note_d;
	wire note_e;
	wire note_f;
	
	wire [1:4] noteButton = ~button_n;
	wire [1:0] octaveSelect = ~octaveSelect_n;

	parameter CLOCK_FREQ = 1000000;
	
	parameter C6_FREQ = 1047;
	parameter D6_FREQ = 1175;
	parameter E6_FREQ = 1319;
	parameter F6_FREQ = 1397;

	wire[2:0] scaler;
	RippleCounter #(.SIZE(3)) u0rc (
		.up(oneMHzClock),
		.value(scaler)
	);
	
	wire [0:3] octaveClocks = { 
		scaler[2],		// octaveSelect 0 -> octave 3
		scaler[1],		// octaveSelect 1 -> octave 4
		scaler[0],		// octaveSelect 2 -> octave 5
		oneMHzClock		// octaveSelect 3 -> octave 6
	};
	
	wire noteClock = octaveClocks[octaveSelect];
				 
	ClockSynthesizer #(.IN_FREQ(CLOCK_FREQ), .OUT_FREQ(C6_FREQ), .BITS(9)) u1cs (
		.inclock(noteClock),
		.outclock(note_c)
	);

	ClockSynthesizer #(.IN_FREQ(CLOCK_FREQ), .OUT_FREQ(D6_FREQ), .BITS(9)) u2cs (
		.inclock(noteClock),
		.outclock(note_d)
	);

	ClockSynthesizer #(.IN_FREQ(CLOCK_FREQ), .OUT_FREQ(E6_FREQ), .BITS(9)) u3cs (
		.inclock(noteClock),
		.outclock(note_e)
	);

	ClockSynthesizer #(.IN_FREQ(CLOCK_FREQ), .OUT_FREQ(F6_FREQ), .BITS(9)) u4cs (
		.inclock(noteClock),
		.outclock(note_f)
	);

	assign noteOutC = noteButton[1] & note_c;
	assign noteOutD = noteButton[2] & note_d;
	assign noteOutE	= noteButton[3] & note_e;
	assign noteOutF = noteButton[4] & note_f;
	
endmodule

	