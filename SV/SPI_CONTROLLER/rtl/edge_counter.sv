// SPI Master Edge Counter Module
// Tracks total clock transitions (2 * width = 16 edges for an 8-bit transfer)
// continuously synchronized to the primary system clock domain.
module edge_counter #(parameter int width = 8)(
    input logic clk,           // Primary system clock
    input logic rst_n,         // Active-low asynchronous reset
    input logic enable,        // High during active SPI transaction
    input logic sclk_rising,   // 1-cycle strobe pulse prior to sclk rising edge
    input logic sclk_falling,  // 1-cycle strobe pulse prior to sclk falling edge
    output logic [$clog2(width):0] edge_count // Counter output (4 bits for width=8: values 0 to 15)
);

// Synchronous sequential block handling edge count updates
always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) edge_count <= 'd0; // Asynchronous reset clears edge count
    else if (enable) begin
        // Only advance counter when an sclk strobe pulse fires
        if (sclk_rising || sclk_falling) begin
            // Rollover back to 0 at terminal count (15 for 8-bit mode)
            if (edge_count == width * 2 - 1) edge_count <= 'd0;
            else edge_count <= edge_count + 1;
        end
        
    end
    else edge_count <= 'd0; // enable = 0 (IDLE STATE)

    
end


endmodule