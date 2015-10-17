@set XILINX=C:\Xilinx\10.1\ISE
@set PATH=C:\Xilinx\10.1\ISE\bin\nt
@C:\Xilinx\10.1\ISE\bin\nt\netgen.exe -w -sim -ofmt verilog -pcf "FourBitCounterWithLoad.pcf"  -s  5  -sdf_anno true  -sdf_path  C:\Users\tmcphillips\Designs\Projects\BASYS250\VerilogHDL\01_CounterWithLoad\design\implement  -insert_glbl true "FourBitCounterWithLoad.ncd" "time_sim.v"
