`include "b2g.sv"
module rp_hand #(parameter addr_bits = 8)
(
    input  logic [addr_bits:0] gsync_wptr,   // Gray-coded write pointer synchronized into the read clock domain
    input  logic               r_en,         // Read enable
    input  logic               rclk,         // Read clock
    input  logic               areset,       // Active-low asynchronous reset

    output logic [addr_bits:0] b_rptr,       // Binary read pointer (N+1 bits including wrap bit)
    output logic [addr_bits:0] g_rptr,     // Gray-coded read pointer
    output logic               empty     // FIFO empty flag we used it in simulation to observe the flag
);
   // logic empty; // FIFO empty flag declared internally

    
    //----------------------------------------------------------
    // Binary-to-Gray Converter
    //
    // Continuously converts the binary read pointer into
    // Gray code.
    //----------------------------------------------------------
    binary_gray #(addr_bits + 1) dut (
        .gray   (g_rptr),
        .binary (b_rptr)
    );



    //----------------------------------------------------------
    // Next Binary Read Pointer
    //
    // If the FIFO is NOT empty:
    //      next_b_rptr = b_rptr + 1
    //
    // If the FIFO IS empty:
    //      next_b_rptr = b_rptr
    //
    // !(empty) guarantees either a 1 or 0 is added.
    //----------------------------------------------------------
    logic [addr_bits:0] next_b_rptr;

    assign next_b_rptr = b_rptr + !(empty);



    //----------------------------------------------------------
    // Binary Read Pointer Register
    //
    // Reset:
    //      Clear pointer to zero.
    //
    // Otherwise:
    //      Increment pointer whenever a read occurs.
    //----------------------------------------------------------
    always_ff @(posedge rclk or negedge areset) begin

        if (~areset) begin
            b_rptr <= 'd0;

        end
        else begin

            if (r_en) begin
                b_rptr <= next_b_rptr;
            end

        end

    end



    //----------------------------------------------------------
    // Empty Detection
    //
    // FIFO is empty when the synchronized Gray-coded write
    // pointer equals the Gray-coded read pointer.
    //
    // This means the read pointer has caught up to the write
    // pointer, so there is no unread data remaining.
    //
    // Think of the FIFO like a basket:
    //   - Writing adds an apple to the basket.
    //   - Reading removes an apple from the basket.
    // Once all apples have been removed, the basket is empty.
    //----------------------------------------------------------
    assign empty = (gsync_wptr == g_rptr);

endmodule
