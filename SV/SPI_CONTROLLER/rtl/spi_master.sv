module spi_master #(parameter int width = 8)(
  
  // General System Inputs
  input logic clk,
  input logic rst_n,
  input logic [width-1:0] tx_data,
  input logic start,
  
  // General System Outputs
  output logic done,
  output logic [width-1:0] rx_data,
  output logic ready,
  
  // Communication to SLAVE from MASTER
  output logic sclk, // Clk the Slave runs on
  output logic cs_n, // Chip select active low
  input logic miso, // Master input from SLAVE
  output logic mosi // Master output to SLAVE
  
);

  
  
  
  
  
endmodule



