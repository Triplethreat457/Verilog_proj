module encoder #(parameter num = 3)(input [(1 << num) - 1:0] in , output reg [num - 1 : 0] out);
      integer i; 
      integer j = 0;
      always@(*) begin 
        for( i = 0; i <  1 << num; i = i + 1) begin
            if(in[i] == 1'b1) begin 
                if(j == 1) begin
                    out = 'd0;
                end 
                else begin
                out = i;
                j = 1;
                end 
            end 
        end 



      end 



endmodule