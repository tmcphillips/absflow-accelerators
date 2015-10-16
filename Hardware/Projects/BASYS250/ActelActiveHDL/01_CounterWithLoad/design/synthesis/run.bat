set XILINX=C:\Xilinx\10.1\ISE
call "C:\Xilinx\10.1\ISE\bin\nt\xst.exe" -ifn FourBitCounterWithLoad.xst >> synthesize.plg
call "C:\Xilinx\10.1\ISE\bin\nt\netgen.exe" -ofmt verilog -intstyle silent -w FourBitCounterWithLoad.ngc  FourBitCounterWithLoad.v >> synthesize.plg
