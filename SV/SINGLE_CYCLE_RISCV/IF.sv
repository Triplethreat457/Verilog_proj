`include "imem.sv"
`include "PC.sv"
module IF (
input logic clk,
input logic reset,
input logic [31:0] pc_next,
output logic [31:0] pc, 
output logic [31:0] instr
);
  
  PC PC_reg(.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
  imem im(.baddr(pc), .instr(instr));
  

endmodule
  
  
  
  
  