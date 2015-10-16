`include "ripplescaler.v"
`include "bcddigittosevensegment.v"
`include "keypadscanner.v"

module KeypadScannerDemo(
	output wire [3:0] 	rows			/* synthesis loc="P28,P27,P26,P24"				*/,
	input wire 			oneMHzClock		/* synthesis loc="P19"							*/,
	input wire [2:0] 	columns			/* synthesis loc="P22,P21,P20"					*/,
	output wire [6:0]   segments		/* synthesis loc="P31,P32,P33,P34,P38,P39,P40"	*/				
	);

	/*synthesis PULL_DEFAULT="DOWN" */
	
	wire oneKHzClock;
	wire [3:0] digit;
	
	RippleScaler #(.BITS(10)) u0rs (
		.inclock(oneMHzClock),
		.outclock(oneKHzClock)
	);
	
	KeypadScanner u1ks (
		.rowDrivers_reg(rows),
		.scanClock(oneKHzClock),
		.columnReceivers(columns),
		.key_reg(digit)
	);
	
	BcdDigitToSevenSegment u2bdtss(
		.digit(digit), 
		.segments(segments)
	);
	
endmodule

