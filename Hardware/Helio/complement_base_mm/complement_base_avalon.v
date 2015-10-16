
module complement_base_avalon (
	input		wire					csi_clock,
	input		wire					rsi_reset,
	input		wire					avs_s0_write,
	output	wire	[0:7]			avs_s0_readdata,
	input		wire	[0:7]			avs_s0_writedata
);

	complement_base complement_base_0 (
		.clock						(csi_clock),
		.reset						(rsi_reset),
		.write						(avs_s0_write),
		.in_base						(avs_s0_writedata),
		.out_complement			(avs_s0_readdata)
	);	

endmodule
