module decoder #(parameter num = 8)(input en, input [num - 1: 0] in , output reg [(1 << num) - 1 : 0] out);
integer i;
always @(*) begin 
    if(en) begin
    for(i = 0; i < (1 << num); i = i + 1) begin // for loop going through all of the bits 
        out[i] = 1'b0;
    end
    out[in] = 1'b1; // make the selected bit zero (one-hot-encoding )

    end  
    else begin // when enable is equal to zero make every bit equal to zero 
        out = 'd0;

    end 
end 

endmodule 
