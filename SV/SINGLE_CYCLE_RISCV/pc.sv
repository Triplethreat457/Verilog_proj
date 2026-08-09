module PC( // Register to hold PC and update the PC to be next_PC blindly at POSEDGE 
       input logic clk, 
       input reset, 
       output logic [31:0] pc, // Is a BYTE address in PC gets trunicated to become a Word address in IMEM
       input logic [31:0] next_pc //PC to set after CLK edge be after jump,branch, or PC + 4 
);
  
  
  
  always_ff @(posedge clk) begin
    if (reset) pc <= 32'd0;
    else pc <= next_pc;  
  end 
  
  
  
  
  
  
  
  
  
endmodule
