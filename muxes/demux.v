module demux #(parameter n = 3)
(input data_in , 
input [n - 1: 0] sel,
 output reg [ (1 << n) - 1: 0] out);
    integer i; 
    always @(*) begin  
    for(i = 0; i < ( 1 << n  ); i = i + 1) begin
        out[i] = 1'b0;
    end  // All the other inputs are driven low 

    out[sel] = data_in;
    end 


endmodule 