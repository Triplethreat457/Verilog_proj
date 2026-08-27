module clock_divider #(parameter int CLK_DIV = 10)
// CLK divsion how much do you want to make the period longer
// Example 10 clk_period per one cycles so 5 cycles would be oscillation starts 

(
    
    input logic clk,
    input logic enable, //Signal to keep shifting and 
    input logic rst_n,
    output logic sclk_rising,
    output logic sclk_falling
);
int clk_cnt = 0;
always_ff @(posedge clk) begin 
   if (enable) begin
    clk_cnt = clk_cnt + 1;
    if((CLK_DIV/2 - 1) == clk_cnt) begin


    end
   end else begin 


   end


end



endmodule