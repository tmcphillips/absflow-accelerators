
module complement_base_st_top (
	input			wire					clock_100m
);

	
 complement_base_st_soc soc (
	  .clk_clk 			(clock_100m)
 );

endmodule

