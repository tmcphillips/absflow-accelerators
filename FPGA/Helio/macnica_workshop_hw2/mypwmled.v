
module mypwmled (
	input		wire						clock,
	input		wire						reset,
	input		wire						read,
	input		wire						write,
	input									address,
	output	wire	[31:0]			readdata,
	input		wire	[31:0]			writedata,
	output	wire						pwmled	
	);

	reg 		[31:0]	controlreg;
	reg		[31:0]	scratchreg;
	reg		[31:0]	rdata;
	reg		[31:0]   pwmcnt;
	reg					led;


parameter [31:0] scratchreg_on_reset = 32'b0;

//1 bit address space
always @(posedge clock)
begin
if (reset)
	begin
	controlreg <= 32'b0;
	scratchreg <= scratchreg_on_reset;	
	end
else
	begin
	
	//writes
	if (write && (address == 0))
		begin
		controlreg <= writedata;
		end
	if (write && (address == 1))
		begin
		scratchreg <= writedata;
		end
	
	//reads
	if (read && (address == 0))
		begin
		rdata <= controlreg;
		end
	if (read && (address == 1))
		begin
		rdata <= scratchreg;
		end	
	
	end
end

//the pwm
always @(posedge clock)
begin
if (reset)
	begin
	pwmcnt = 32'b0;
	led = 1'b0;
	end
else
	begin
	
	//toggle control
	if (pwmcnt == controlreg)
		begin
		led <= ~led;
		end
		
	//counter control	
	if (pwmcnt >= controlreg)
		begin
		pwmcnt <= 32'b0;
		end
	else
		begin
		pwmcnt <= pwmcnt + 1'b1;
		end
	end
	
end


//assign outputs
assign readdata = rdata;
assign pwmled = led;

	
endmodule
