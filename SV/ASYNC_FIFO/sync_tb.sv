// Code your testbench here
// or browse Examples


 module testbench;
   localparam width = 16;
   logic clk;
   logic reset_n;
   logic[width-1:0] async_in;
   logic[width-1:0] async_out;
   syncronizer #(16) dut(
       .clk(clk),
       .reset_n(reset_n),
       .async_in(async_in),
       .async_out(async_out)
     );
   
   
   
   initial begin
   $dumpfile("dump.vcd");
   $dumpvars(0, testbench);
     
  
   #20;
   clk = 'd0;
   reset_n = 'd1;
   async_in = 'd0;
   
   #20;
   async_in = 'd20;
   #30;
   toggle_clk;
   async_in = 'd30;
   
   toggle_clk;
   toggle_clk;
   #40;
   reset_n = 0;
   
    
     
     
     
     
     
 
   end 
   
   
   
   
   
   
   
   
   task toggle_clk;
     begin
     #10 clk = ~clk;
     #10 clk = ~clk;
     end
   endtask
 endmodule
