
module soc_multiply_by_thirty_top (
	input		wire		clock_100m
);

 soc_multiply_by_thirty soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
