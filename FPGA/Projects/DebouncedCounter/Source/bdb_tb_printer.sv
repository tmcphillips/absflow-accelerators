import ovm_pkg::*;
import bdb_tb_transactions_pkg::*;

module bdb_tb_printer (
  ref tlm_fifo #(bdb_result) result_fifo);
	
	bdb_result  result;
	string      filename;
	string      m;
	integer     file_handle;
	
	task run;
	 $sformat(m, "%m");
	 forever begin
	   result_fifo.get(result);
	   ovm_top.ovm_report_info(m, result.convert2string(), 400);
	 end  
	endtask
	 
endmodule
