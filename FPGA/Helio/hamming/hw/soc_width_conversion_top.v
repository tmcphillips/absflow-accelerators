
module soc_width_conversion_top (
	input		wire		clock_100m
);

 soc_width_conversion soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
