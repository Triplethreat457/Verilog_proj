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

input logic [width-1:0] tx_data, // Data slave sends to Master
input  logic [width-1:0] rx_data, // Data slave receives from Master
output rx_valid // Signal to denote ready for full byte is processed, ready for next


);
logic sclk_d;
logic cs_up;
logic mosi_up;
logic sclk_up;

logic sclk_rising;
logic sclk_falling;
syncronizer #(.RESET_VAL(1'b1))cs_n_sy(.clk(clk),.data_in(cs_n), .data_out(cs_up),rst_n(rst_n));
syncronizer #(.RESET_VAL(1'b0)) sclk_sy(.clk(clk),.data_in(sclk), .data_out(sclk_up),.rst_n(rst_n));
syncronizer #(.RESET_VAL(1'b0)) mosi_sy(.clk(clk),.data_in(mosi), .data_out(mosi_up), .rst_n(rst_n));

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) sclk_d <= 1'b0;
    else sclk_d <= sclk_up;
end



assign sclk_rising = (sclk_d == 1'b1) & (sclk_up == 1'b0) & (cs_up == 1'b1);
assign sclk_falling = (sclk_d == 1'b0) & (sclk_up == 1'b1) & (cs_up == 1'b0);

always_ff @(negedge c_up) begin
    miso <= tx_data[7];
end

always_ff @(posedge clk )










endmodule