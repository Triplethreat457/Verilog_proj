// Code your testbench here
// or browse Examples
module gray_binary#(parameter int width = 8)(
  input logic[width-1:0] gray,
  output logic[width-1:0] binary
);
  

  always_comb begin
    binary[width-1] = gray[width-1];
    for(int i = width -2 ; i >= 0; i = i - 1) begin
      binary[i] = binary[i+1] ^ binary[i];
    end
  end 
  
  
endmodule


module pointer_handler_write_tb;

    //----------------------------------------------------------
    // Parameters
    //----------------------------------------------------------
    parameter ADDR_BITS = 8;

    //----------------------------------------------------------
    // DUT Inputs
    //----------------------------------------------------------
  logic [ADDR_BITS:0] gsync_wptr;
  logic               r_en;
  logic               rclk;
  logic               areset;
  

    //----------------------------------------------------------
    // DUT Outputs
    //----------------------------------------------------------
  logic [ADDR_BITS:0] b_rptr;
  logic [ADDR_BITS:0]   g_rptr;
  logic                 empty;

    //----------------------------------------------------------
    // Instantiate Device Under Test (DUT)
    //----------------------------------------------------------
    pointer_handler_read #(ADDR_BITS) dut (
      .gsync_wptr(gsync_wptr),
      .r_en(r_en),
      .rclk(rclk),
        .areset(areset),
      .b_rptr(b_rptr),
      .g_rptr(g_rptr),
      .empty(empty)
    );

    
    //----------------------------------------------------------
    // Test Stimulus
    // This is where you drive the inputs.
    //----------------------------------------------------------
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,pointer_handler_write_tb);

        //----------------------------
        // Initialize all inputs
        //----------------------------
        areset     = 'd0;
        r_en       = 'd0;
        gsync_wptr = 'd40;
        rclk = 'd0;

        //----------------------------
        // Hold reset for a few cycles
        //----------------------------
        // TODO
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        #50;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        
       

        //----------------------------
        // Release reset
        //----------------------------
        areset = 1'b1;
        r_en = 1'b1;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
       

        //----------------------------
        // Test 1:
        // READ disabled
        //----------------------------
        #100;
        r_en = 1'b0;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        // Expect:
        // b_rptr should remain constant
        // TODO
        #100;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;

        //----------------------------
        // Test 2:
        // Enable reading (Was 'writing' in comment)
        r_en = 1;
        //----------------------------
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        // Expect:
        // b_rptr increments every clock
        // TODO

        //----------------------------
        // Test 3:
        // Disable reading again
        //----------------------------
        r_en = 1'b0;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        // Expect:
        // Pointer stops incrementing
        // TODO
         
        
        
        

        //----------------------------
        // Test 4:
        // Force FIFO empty condition 
        //-------------------------
      r_en = 1'b1; // ADDED: Must enable reading to empty the FIFO
      
      #300;
        
        // Change gsync_wptr so that
        // empty becomes asserted.
        //
       gsync_wptr = g_rptr;
        // Expect:
        // Pointer should NOT increment.
        // TODO

        //----------------------------
        // Test 5:
        // Leave empty condition
        //----------------------------
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
          
        // Expect:
        // Pointer resumes incrementing.
        // TODO
      
        
        gsync_wptr = gsync_wptr + 'd10; // Empty is unassserted 
        
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        toggle_clk; 
        toggle_clk;
        toggle_clk;
      
        
        // Expect:
        // Pointer resumes incrementing.
        // TODO

        //----------------------------
        // Now reset.....
        areset = 1'b0;
      
        // Finish simulation
        //----------------------------
        #100;
        $finish; // ADDED: to successfully stop simulation

    end

    //----------------------------------------------------------
    // Monitor
    // Prints values whenever one changes.
    //----------------------------------------------------------
  
  
    // Monitor
    // Prints values whenever one changes.
    //----------------------------------------------------------
//       initial begin
//         // FIXED labels: changed b_wptr to b_rptr and gsync_rptr to gsync_wptr
//         $monitor(
//             "Time=%0t Reset= %b Enable = %b b_rptr= %0d g_rptr = %b gsync_wptr = %b empty = %b",
//             $time,
//             areset,
//             r_en,
//             b_rptr,
//             g_rptr,
//             gsync_wptr,
//             empty
//         );
//     end
  
  task toggle_clk;
    begin
         #10 rclk = ~rclk;
         #10 rclk = ~rclk;
    end    
  endtask
    

endmodule