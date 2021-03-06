import bdb_tb_transactions_pkg::*;
import ovm_pkg::*;

module bdb_tb_generator(ref tlm_fifo #(bdb_operation) op_fifo);
  
  bdb_operation t;
    
  task run;
    
    for (int i = 6; i > 0; i--)
      repeat (1) begin
        t = new(press_op, i, 5);
        op_fifo.put(t.clone);
      end

    for (int i = 6; i > 0; i--)
      repeat (1) begin
        t = new(press_op, 4, i);
        op_fifo.put(t.clone);
      end
 /*

    for (int i = 6; i >= 0; i--)
      repeat (32) begin
        t = new(press_op, i, 3);
        op_fifo.put(t.clone);
      end

    
    repeat(1000) begin
      t.random();
      op_fifo.put(t.clone);      
    end

*/
    repeat(1000) begin
      t.random_short();
      op_fifo.put(t.clone);      
    end

   
    #5000;
		
		ovm_top.die();
				
		$stop;
    
  endtask
    
endmodule