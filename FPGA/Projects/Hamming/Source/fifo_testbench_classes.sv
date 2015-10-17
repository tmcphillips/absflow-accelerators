package ppfifo_testbench_classes_pkg;
  
`include "constants.sv"

typedef enum {clear_op, put_op, get_op, no_op} operation_t;

class ppfifo_operation;
  
  operation_t             op;
  logic [`FIFO_WIDTH-1:0]  arg;
  logic [7:0]             waits;
  logic [7:0]             hold;
  
  function new (
    operation_t            iop     = no_op,
    logic [`FIFO_WIDTH-1:0] iarg    = 0,
    logic [7:0]            iwaits  = 1,
    logic [7:0]            ihold   = 1
    );
    
    op    = iop;
    arg   = iarg;
    waits = iwaits;
    hold  = ihold;

  endfunction
  
  function ppfifo_operation clone();
    ppfifo_operation c;
    c = new(op, arg, waits, hold);
    return c;  
  endfunction
 
  function bit comp(ppfifo_operation t);
    return ((t.op == op) && (t.arg == arg) && (t.waits == waits) && (t.hold == hold));
  endfunction;

  function string convert2string;
    string str;
    $sformat(str, "{ op: %7s   arg: %2d   waits: %3d   hold: %3d}",
              op, arg, waits, hold);
    return str; 
  endfunction;
  
endclass


class ppfifo_result;
  
  logic [`FIFO_WIDTH-1:0] result;
  
  function new(logic [`FIFO_WIDTH-1:0] iresult = 0);
    result = iresult;
  endfunction;
 
  function ppfifo_result clone();
    ppfifo_result c;
    c = new(result);
    return c;
  endfunction;
  
  function bit comp (ppfifo_result r);
    return (r.result == result);
  endfunction;  
  
  function string convert2string;
    string str;
    $sformat(str, "{ value = %d }", result);
    return str;
  endfunction; 
 
   static function string sequence2string(ppfifo_result result_sequence[$]);
    string s = "";
    string v = "";
    foreach(result_sequence[i]) begin
        $sformat(v, "%d ", result_sequence[i].result);
        s = {s , v};
    end
    return s;
  endfunction : sequence2string
 
endclass

typedef ppfifo_result ppfifo_result_queue_t[$];
typedef ppfifo_operation  ppfifo_operation_queue_t[$];


endpackage // ppfifo_testbench_classes_pkg



