module clock_divider #(parameter int CLK_DIV = 10)(
    input logic clk,
    input logic enable, //Signal to keep shifting and 
    input logic rst_n,
    output logic sclk_rising,
    output logic sclk_falling
);

always_ff @(posedge clk) begin 
   if(enable) begin

   end


end

always_ff @(negedge clk) begin


end





endmodule