package dbctr_testbench_classes_pkg;
  
typedef enum {reset_op, up_op, down_op, load_op, no_op} operation_t;

class dbctr_operation;
  
  rand operation_t op;
  rand logic [3:0] arg;
  rand logic [3:0] hold;
  rand logic [3:0] waits;
  
  function new (
    operation_t iop     = no_op,
    logic [3:0] iarg    = 0,
    logic [3:0] ihold   = 1,
    logic [3:0] iwaits   = 1
    );
    
    op    = iop;
    arg   = iarg;
    hold  = ihold;
    waits  = iwaits;
  
  endfunction
  
  function dbctr_operation clone();
    dbctr_operation c;
    c = new(op, arg, hold, waits);
    return c;  
  endfunction
 
  function bit comp(dbctr_operation t);
    return ((t.op == op) && (t.arg == arg) && (t.hold == hold) && (t.waits == waits));
  endfunction;

  function string convert2string;
    string str;
    $sformat(str, "{ op: %7s   arg: %2d   hold: %3d   waits: %3d }",
              op, arg, hold, waits);
    return str; 
  endfunction;
  
  task random(integer seed);
    
    op =  operation_t'($dist_uniform(seed,0,4));
    arg = $random;
    hold = $dist_uniform(seed,1,15);
    
    if (op == reset_op)
      waits = $dist_uniform(seed,3,15);
    else 
      waits = $dist_uniform(seed,1,15);
    
  endtask;    

  task smallrandom(integer seed);
    
    op =  operation_t'($dist_uniform(seed,0,4));
    arg = $random;
    hold = $dist_uniform(seed,1,6);
    
    if (op == reset_op)
      waits = $dist_uniform(seed,3,6);
    else 
      waits = $dist_uniform(seed,1,6);
    
  endtask;    


endclass



class dbctr_result;
  
  logic [3:0] result;
  
  function new(logic [3:0] iresult = 0);
    result = iresult;
  endfunction;
 
  function dbctr_result clone();
    dbctr_result c;
    c = new(result);
    return c;
  endfunction;
  
  function bit comp (dbctr_result r);
    return (r.result == result);
  endfunction;  
  
  function string convert2string;
    string str;
    $sformat(str, "{ counter = %d }", result);
    return str;
  endfunction;
  
endclass

endpackage // dbctr_testbench_classes_pkg


