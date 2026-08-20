module test; 
  
  localparam D_WIDTH = 32;
  localparam A_WIDTH = 6;
  localparam A_MAX   = 64;

  reg write_en;
  reg [A_WIDTH-1:0] write_addr;
  reg write_clk;
  reg [D_WIDTH-1:0] data_input;
  
  reg [A_WIDTH-1:0] read_addr;
  reg read_clk;
  reg [D_WIDTH-1:0] read_data;
  
  ram #(D_WIDTH, A_WIDTH, A_MAX) dut (
    .write_en(write_en),
    .write_addr(write_addr),
    .write_clk(write_clk), 
    .data_input(data_input), 
    .read_addr(read_addr), 
    .read_clk(read_clk), 
    .read_data(read_data)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test);
    
    write_en  = 0;
    read_clk  = 0;
    write_clk = 0;
    
    write_addr = 6'b011011;
    read_addr  = write_addr;
    
    #20;
    
    // Write Operation
    data_input = 32'hFA2B;
    write_en   = 1'b1;
    toggle_clk_write();
    write_en   = 1'b0;
    
    // Read Operation
    toggle_clk_read();
    $display("Address %b contains data: %h", read_addr, read_data);
    
  end
    
  task toggle_clk_read;
    begin
      #10 read_clk = ~read_clk;
      #10 read_clk = ~read_clk;     
    end    
  endtask
    
  task toggle_clk_write;
    begin
      #10 write_clk = ~write_clk;
      #10 write_clk = ~write_clk; 
    end
  endtask
    
endmodule