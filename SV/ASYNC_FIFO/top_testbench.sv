module testbench;
  
logic w_en;
logic r_en;
logic wclk;
logic rclk;
logic full;
logic empty;

logic areset;
logic wp_reset_n;
logic rp_reset_n;
logic [7:0] expected;

logic [7:0] write_data;
logic [7:0] read_data;


  event read_done;
  event write_done;
  
  always  #10 wclk = ~wclk;
  
  logic [7:0] write_q[$];   
  
  
  always #20 rclk = ~rclk;
  
  async_FIFO why(
    .w_en(w_en),
    .r_en(r_en),
    .wclk(wclk),
    .rclk(rclk),
    .wp_reset_n(wp_reset_n),
    .rp_reset_n(rp_reset_n),
    .write_data(write_data),
    .read_data(read_data),
    .empty(empty),
    .full(full)
);
  
  clocking w_cb @(posedge wclk);
    default input #1step output #0;
    
    
    output w_en;
    output write_data;
    input  full;  
  endclocking
  
  clocking r_cb @(posedge rclk);
    default input #1step output #0;
    
    output r_en;
    input read_data;
    input empty;
    
    
  endclocking
  
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);
    $dumpvars(0,testbench.why.rm.memory);
    wclk = 1'b0; // start clk
    w_cb.w_en <= 1'b0;
    wp_reset_n = 1'b0; // Turn on reset at t = 0
    
    repeat(10)
      @(w_cb);
    
    wp_reset_n = 1'b1;
    
    repeat(2)
    	begin 
          for(int i = 0; i < 30; i++) begin
            @(w_cb iff !w_cb.full);
            w_cb.w_en <= ((i % 2) == 0);
            if (w_en) begin 
              w_cb.write_data <= $urandom;
              write_q.push_back(write_data);     
            end // end if 
          end  // end for loop 
          #50; // 50 ns delay
        
        end //end repeat (2)
    
    
   -> write_done;
  end 
  
  initial begin 
    rclk = 1'b0;
    r_en = 1'b0;
    rp_reset_n = 1'b0;
    
    repeat(10)
      @(posedge rclk);
    
    rp_reset_n = 1'b1;
    
    repeat(2) 
      begin
        for(int i = 0; i < 30; i++) begin 
          @(r_cb iff !r_cb.empty);
          r_cb.r_en <= (i % 2 == 0);
          if (r_en) begin
            expected = write_q.pop_front();
          if(expected !== read_data) 
  $error("Time = %0t: Comparison Failed: expected w_data = %h, rd_data = %h", $time, expected, read_data);
            else $display("Time = %0t: Comparison Passed: expected w_data = %h and rd_data = %h",$time, expected, read_data);
            
          end // end r_en
          
          
        end // end for 
        
        
        
      end // end repeat(2)
    
   -> read_done;
  end // end intial
      
  initial begin // Test for Reset and FULL
    
    @write_done;
    @read_done;
    
    // TEST RESET.... 
    
    wp_reset_n = 1'b0;
    rp_reset_n = 1'b0;
    w_cb.w_en <= 1'b0;
    r_cb.r_en <= 1'b0;
    
    repeat(2)
      @(r_cb);
    
    wp_reset_n = 1'b1;
    rp_reset_n = 1'b1;
    r_cb.r_en <= 1;
    
    repeat(3)
      @(r_cb);
    
    
    if(r_cb.empty !== 1'b1) $error("ERROR: Empty should be asserted where the RP and WP should be reset");
    else $display("SUCCESS: EMPTY was asserted after reset on syncronizers, and dosen't incr RPTR");
    
    @(w_cb);
    w_en <= 1'b1;
    r_en <= 1'b0;
      
    
    repeat(256) 
      begin 
      @(w_cb) begin 
        if(w_en & !full) begin 
        	w_cb.write_data <= $urandom;      
        end
      end
      
    end  //end repeat 256 
    
    @(w_cb);
    if (w_cb.full !== 1'b1) $error("ERROR: FULL should be asserted where WPTR can't be incremented");
    else $display("SUCCESS: FULL is Asserted, we incremented the WPTR enough to fill the FIFO");    
    
    
    
    
    
    
    
    
    
    
    $finish;
    
  end
  
  

  
endmodule 
