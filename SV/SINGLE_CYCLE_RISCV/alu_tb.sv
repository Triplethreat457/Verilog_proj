module testbench;
  
  logic [3:0] alu_op;
  logic [31:0] a, b, result;
  logic zero; //output Monitor
  
  
  
  
  
  task check(input logic [31:0] expected, input logic ez);  
        #1;
    if (expected === result && ez === zero)
      $display("PASSED: t:%0t alu_op:%h , a:%h, b:%h, result:%h, correct result was %h and zero flag was %b", time, alu_op, a,b,result,zero,expected, ez);
    else $error("ERROR: t:%0t alu_op:%h,  a:%h, b:%h, result:%h, correct result was %h and zero flag was %b", time,alu_op, a,b,result,zero,expected, ez);   
  endtask
  
  alu dut(.a(a), .b(b), .result(result), .zero(zero), .alu_op(alu_op));

  initial begin 
    //Add Test
    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);
    a = 32'd1;
    b = 32'd5;
    alu_op = 4'b0;
    $display("-----------------ADD TEST------------------");
    $display("Setted,d1\n ");





  end

  
  
 
    
    
  
  
  
  
  
endmodule
