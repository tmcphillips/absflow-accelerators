
module soc_hamming_top (
	input		wire		clock_100m
);

 soc_hamming soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
