module ram
#(
    parameter D_WIDTH = 16, // means each data is 16 bits long
    parameter A_WIDTH = 4, // means 4 bits of addresses 
    parameter A_MAX   = 16 // there only can be 16 posiible address
)

(
    //----------------------------------------------------------
    // Write Channel
    //----------------------------------------------------------
    input  logic                  write_en,      // Enables a write operation
    input  logic [A_WIDTH-1:0]    write_addr,    // Address to write to
    input  logic                  write_clk,     // Write clock
    input  logic [D_WIDTH-1:0]    data_input,    // Data being written

    //----------------------------------------------------------
    // Read Channel
    //----------------------------------------------------------
    input  logic [A_WIDTH-1:0]    read_addr,     // Address to read from
    input  logic                  read_clk,      // Read clock
    input logic                   read_en,       // Enables an read operation
    output logic [D_WIDTH-1:0]    read_data     // Data read from memory
    //output logic [D_WIDTH-1:0] memory [0:A_MAX-1] // I'm going to use this for debugging
);

    //----------------------------------------------------------
    // Memory Array
    //
    // Creates A_MAX memory locations.
    //
    // Each location stores D_WIDTH bits.
    //
    // Example (default parameters):
    //   16 memory locations
    //   Each location stores 16 bits
    //----------------------------------------------------------
   logic [D_WIDTH-1:0] memory [0:A_MAX-1]; 



    //----------------------------------------------------------
    // Write Logic
    //
    // On every rising edge of the write clock:
    //
    // If write_en is asserted,
    // write the input data into the selected memory address.
    //----------------------------------------------------------
    always_ff @(posedge write_clk) begin

        if (write_en) begin
            memory[write_addr] <= data_input;
        end

    end



    //----------------------------------------------------------
    // Read Logic
    //
    // On every rising edge of the read clock,
  
    // if read_en is asserted then,
    
    // output the contents stored at the selected read address.
    //
    // This is a synchronous read because the data is registered
    // on the read clock.
    //----------------------------------------------------------
    always_ff @(posedge read_clk) begin
      
      if(read_en) begin 
      	read_data <= memory[read_addr];
      end

    end

endmodule