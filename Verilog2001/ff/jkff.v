module jkff(input j, input k, output reg Q);
wire Q_hold;
assign Q_hold = Q;
if(j) begin 
    if(k) begin  
        Q <= ~Q_hold;        
   end 
   else begin     
        Q <= 1'b1;
    end
end  else begin 

    if(k) begin 
         Q <= 1'b0;
    end else begin
        Q <= Q_hold;
    end 
end

endmodule