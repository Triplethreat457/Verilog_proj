module spi_slave #(paramter int width = 8)(
//System Inputs
input logic clk,
input logic rst_n,

// From Master to Master
input logic mosi,
input logic cs_n,
input logic sclk, 
output logic miso,

// Local Parallel Interface

output logic [width-1:0] tx_data, // Data slave sends to Master
output logic [width-1:0] rx_data, // Data slave receives from Master
output rx_valid // Signal to denote ready for full byte is processed, ready for next


);




endmodule