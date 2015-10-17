
module soc_lowpass_filter_top (
	input		wire		clock_100m
);

 soc_lowpass_filter soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
