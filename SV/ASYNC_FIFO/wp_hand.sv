`include "b2g.sv"
module wp_hand #(parameter addr_bits = 8)
(
    input  logic [addr_bits:0] gsync_rptr,   // Gray-coded read pointer synchronized into the write clock domain
    input  logic               w_en,         // Write enable
    input  logic               wclk,         // Write clock
    input  logic               areset,       // Active-low asynchronous reset only reset the pointer dosen't 

    output logic [addr_bits:0] b_wptr,       // Binary write pointer (N+1 bits including wrap bit)
  output logic [addr_bits:0] g_wptr,      // Gray-coded write pointer
    output logic               full          // FIFO full flag we had it in the output to observe the waveform
);
    // logic full; // FIFO full flag declared internally we don't to output it for now

    //----------------------------------------------------------
    // Binary-to-Gray Converter
    //
    // Continuously converts the binary write pointer into
    // Gray code.
    //----------------------------------------------------------
    binary_gray #(addr_bits + 1) dut (
        .gray   (g_wptr),
        .binary (b_wptr)
    );



    //----------------------------------------------------------
    // Next Binary Write Pointer
    //
    // If the FIFO is NOT full:
    //      next_b_wptr = b_wptr + 1
    //
    // If the FIFO IS full:
    //      next_b_wptr = b_wptr
    //
    // !(full) guarantees either a 1 or 0 is added.
    //----------------------------------------------------------
    logic [addr_bits:0] next_b_wptr;

    assign next_b_wptr = b_wptr + !(full);



    //----------------------------------------------------------
    // Binary Write Pointer Register
    //
    // Reset:
    //      Clear pointer to zero.
    //
    // Otherwise:
    //      Increment pointer whenever a write occurs.
    //----------------------------------------------------------
    always_ff @(posedge wclk or negedge areset) begin

        if (~areset) begin
            b_wptr <= 'd0;

        end
        else begin

            if (w_en) begin
                b_wptr <= next_b_wptr;
            end

        end

    end



    //----------------------------------------------------------
    // Full Detection
    //
    // FIFO is full when:
    //
    // 1. Upper two Gray bits are inverted.
    // 2. Remaining Gray bits are equal.
    //
    // This indicates the write pointer has wrapped around and
    // caught up to the read pointer.
    //----------------------------------------------------------
    assign full =
        (gsync_rptr[addr_bits:addr_bits-1] ==
         (~g_wptr[addr_bits:addr_bits-1])) &&

        (gsync_rptr[addr_bits-2:0] ==
         g_wptr[addr_bits-2:0]);

endmodule





