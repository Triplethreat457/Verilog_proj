module sycronizer #(parameter int RESET_VAL = 1'b0)( // 2-Stage syncronizer to handle cs_n, mosi, and miso
    input logic clk,
    input logic data_in,
    input logic rst_n,
    output logic data_out
);

logic d_int;

always_ff @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin
        data_out <= RESET_VAL;
        d_int <= RESET_VAL;
    end else begin
        d_int <= data_in;
        data_out <= d_int;
    end
end




endmodule