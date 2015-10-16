
module soc_mm_st_adapters_top (
	input		wire		clock_100m
);

 soc_mm_st_adapters soc_sys (
	.clk_clk				(clock_100m)
 );
 
endmodule
