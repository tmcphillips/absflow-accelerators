`include "ripplescaler.v"
`include "bcddigittosevensegment.v"
`include "keypadscanner.v"
`include "stablevaluedetector.v"

module KeypadScannerDemo(
	input wire 			oneMHzClock		/* synthesis loc="P19"							*/,
	input wire  [3:0] 	keypadRows		/* synthesis loc="P28,P27,P26,P24"				*/,
	output wire [2:0] 	keypadColumns	/* synthesis loc="P22,P21,P20"					*/,
	output wire [6:0]   segments		/* synthesis loc="P31,P32,P33,P34,P38,P39,P40"	*/				
	);

	/*synthesis PULL_DEFAULT="DOWN" */
	
	wire oneKHzClock;
	wire [3:0] keyPress;
	wire [3:0] activeKey;
	
	RippleScaler #(.BITS(10)) u0rs (
		.inclock(oneMHzClock),
		.outclock(oneKHzClock)
	);
	
	KeypadScanner u1ks (
		.scanClock(oneKHzClock),
		.activeRow(keypadRows),
		.activeColumn_reg(keypadColumns),
		.activeKey_reg(activeKey)
	);
	
	StableValueDetector #(.SIZE(4)) u2slpf (
		.samplingClock(oneKHzClock),
		.rawValue(activeKey),
		.stableValue_reg(keyPress),
		.isStable(),
		.ack(1'b1)
	);
	
	BcdDigitToSevenSegment u3bdtss (
		.digit(keyPress),
		.segments(segments)
	);
	
endmodule

