// Code your testbench here
// or browse Examples
module tb;

    //----------------------------------------------------------
    // Parameters
    //----------------------------------------------------------
    parameter ADDR_BITS = 8;

    //----------------------------------------------------------
    // DUT Inputs
    //----------------------------------------------------------
    logic [ADDR_BITS:0] gsync_rptr;
    logic               w_en;
    logic               wclk;
    logic               areset;

    //----------------------------------------------------------
    // DUT Outputs
    //----------------------------------------------------------
    logic [ADDR_BITS:0] b_wptr;
    logic [ADDR_BITS:0]   g_wptr;
    logic                 full;

    //----------------------------------------------------------
    // Instantiate Device Under Test (DUT)
    //----------------------------------------------------------
  pointer_handler_write #(ADDR_BITS) dut (
        .gsync_rptr(gsync_rptr),
        .w_en(w_en),
        .wclk(wclk),
        .areset(areset),
        .b_wptr(b_wptr),
        .g_wptr(g_wptr),
        .full(full)
    );

    
    //----------------------------------------------------------
    // Test Stimulus
    // This is where you drive the inputs.
    //----------------------------------------------------------
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,tb);
        //----------------------------
        // Initialize all inputs
        //----------------------------
        areset     = 0;
        w_en       = 0;
        wclk = 1'b0;
        gsync_rptr = '0;
        toggle_clk;
        toggle_clk;

        //----------------------------
        // Hold reset for a few cycles
        //----------------------------
        // TO DO
        #100;
        toggle_clk;
        toggle_clk;
        toggle_clk;
        
        
        //----------------------------
        // Release reset
        //----------------------------
        areset = 1'b1;

        //----------------------------
        // Test 1:
        // Write disabled
        //----------------------------
        // Expect:
        // b_wptr should remain constant
        // TODO
        #100;
        w_en = 1'b1;
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
        // Test 2:
        // Enable writing
        
        //----------------------------
        // Expect:
        // b_wptr increments every clock
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
        

        //----------------------------
        // Test 3:
        // Disable writing again
        //----------------------------
        w_en = 1'b0;
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
        // Pointer stops incrementing
        // TODO

        //----------------------------
        // Test 4:
        // Force FIFO full condition
        //----------------------------
        // Change gsync_rptr so that
        // full becomes asserted.
        //
        #100; 
      gsync_rptr[ADDR_BITS:ADDR_BITS-1] = ~b_wptr[ADDR_BITS:ADDR_BITS-1];
     gsync_rptr[ADDR_BITS-2:0] = g_wptr[ADDR_BITS-2:0];
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
        // Pointer should NOT increment.
        // TODO
      #100;
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
        //----------------------------
        // Test 5:
        // Leave full condition
        //----------------------------
      gsync_rptr[0]  =  ~gsync_rptr[0];
        // Expect:
        // Pointer resumes incrementing.
        // TODO
       toggle_clk;
       toggle_clk;
       toggle_clk;
       toggle_clk;
       toggle_clk;
        //----------------------------
        // Finish simulation
        //----------------------------
       #100;
       toggle_clk;
      
    

    end

    // Monitor
    // Prints values whenever one changes.
    //----------------------------------------------------------
      initial begin
        $monitor(
            "Time=%0t Reset= %b Enable = %b b_wptr= %0d g_wptr = %b gsync_rptr = %b Full = %b",
            $time,
            areset,
            w_en,
            b_wptr,
            g_wptr,
            gsync_rptr,
            full
        );
    end
  
  task toggle_clk;
    begin
         #10 wclk = ~wclk;
         #10 wclk = ~wclk;        
    end    
  endtask
    

endmodule