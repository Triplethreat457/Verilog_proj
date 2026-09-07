// SPI Master Receive Register Module
// Captures MISO data bit-by-bit on each sclk_rising strobe (MSB first)
module rx_reg #(parameter int width = 8)(
    input  logic clk,                  // Primary system clock
    input  logic rst_n,                // Active-low asynchronous reset
    input  logic enable,               // Active transaction flag
    input  logic sclk_rising,          // 1-cycle strobe pulse for sample edge
    input  logic miso,                 // Master In Slave Out line
    output logic [width-1:0] rx_reg    // Deserialized parallel output byte
);

    always_ff @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin
            rx_reg <= 'd0;
        end else if (enable && sclk_rising) begin
            rx_reg <= {rx_reg[width-2:0], miso}; // Shift left to assemble MSB-first
        end
    end

endmodule