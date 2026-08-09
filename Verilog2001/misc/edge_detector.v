module edge_detect( // Module to detect an edge for 
    input clk, // clock
    input [7:0] in,  // 8-bit binary number     
    output [7:0] pedge //signal for positive edge detected in[j] = 0 -> 1 or compare pedge 
);
    integer i;
    reg [7:0] cmp; 
    initial begin
        cmp <= in;   //in      
    end 
    always@(posedge clk) begin
        for(i = 0; i < 8; i = i + 1)begin // just want to compare pedge and in bit 
            if((pedge[i] == 1)) begin // assuming pedge is initalized to zero, if pedge was set to one from last clk edge
                pedge[i] = 1'b0; // set the pedge to be low               
            end  else begin
                if((cmp[i] == 0) & (in[i] == 1'b1)) begin // if the compare register is zero{off last clk edge} is low.. and in is high
                    pedge[i] = 1'b1;   //make positive edge high  
                end                         
            end             
        end 
        cmp <= in; // copy what was the number is in binary was before to compare to later for CLK edge        
    end 
    
    

endmodule
