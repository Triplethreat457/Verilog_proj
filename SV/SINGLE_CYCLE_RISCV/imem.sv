`include "code.hex"
module imem ( //Supports 256 Insructions so (1KB of memmory) , word_addressable 
  
  input  logic [31:0] baddr, // 2^32 bytes of memory (BYTE-ADDRESS)
  output logic [31:0] instr // instructions are 32 bits, ONE WORD LONG!!
  
); 
  logic [31:0] mem [0:31];
  
  initial $readmemh("code.hex", mem);
  
  
  assign instr = mem[baddr[31:2]]; //Dividing the byte address by 4 to get WORD ADDRESS 1 = BYTE ADDRESS 7
  
  
  
endmodule