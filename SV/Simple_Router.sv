module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  input  din_en,
  input  [1:0] addr,
  output logic [DATA_WIDTH-1:0] dout0,
  output logic [DATA_WIDTH-1:0] dout1,
  output logic [DATA_WIDTH-1:0] dout2,
  output logic [DATA_WIDTH-1:0] dout3
);
always_comb begin
  dout0 = 'd0;
  dout1 = 'd0;
  dout2 = 'd0;
  dout3 = 'd0;

if(din_en)begin 
  case(addr) 
    2'b00: begin 
    dout0 = din;
    end 
    2'b01: begin 
    dout1 = din;
    end 
    2'b10: begin 
    dout2 = din;
    end 
    2'b11: begin 
    dout3 = din; 
    end 
     endcase 
end 
end 

endmodule