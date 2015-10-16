
module soc_ordered_merge_top (
	input		wire		clock_100m
);

 soc_ordered_merge soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
