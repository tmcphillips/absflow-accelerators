`include "bcddigittosevensegment.v"
`include "hexdigittosevensegment.v"

module DIPsTo7SegmentDisplay #(ENABLE_HEX=1) (
	input wire [3:0] 	dipSwitches_n 	/* synthesis loc="P14,P15,P16,P17"	*/,
	output wire	 		a				/* synthesis loc="P20"				*/,
	output wire	 		b				/* synthesis loc="P21"				*/,
	output wire	 		c				/* synthesis loc="P22"				*/,
	output wire	 		d				/* synthesis loc="P23"				*/,
	output wire	 		e				/* synthesis loc="P24"				*/,
	output wire	 		f				/* synthesis loc="P26"				*/,
	output wire	 		g				/* synthesis loc="P27"				*/
);
	generate

		if (ENABLE_HEX)
			HexDigitToSevenSegment u1hdtss (~dipSwitches_n, {a,b,c,d,e,f,g});
		else
			BcdDigitToSevenSegment u1bdtss (~dipSwitches_n, {a,b,c,d,e,f,g});
	
	endgenerate
endmodule

	
