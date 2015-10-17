
module soc_multiply_by_two_top (
	input		wire		clock_100m
);

 soc_multiply_by_two soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
