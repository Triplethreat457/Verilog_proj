
// testbench for binary to gray convertor
module tb_binary_gray;

    parameter WIDTH = 8;

    logic [WIDTH-1:0] binary;
    logic [WIDTH-1:0] gray;

    // Instantiate the DUT
    binary_gray #(WIDTH) dut (
        .binary(binary),
        .gray(gray)
    );
  

  
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,tb_binary_gray);
      
        $display(" Time    Binary        Gray");
        $display("------------------------------");

        // Test a few values
        binary = 8'b00000000; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b00000001; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b00000010; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b00000011; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b00000100; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b10101010; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b11110000; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        binary = 8'b11111111; #10;
        $display("%4t    %b    %b", $time, binary, gray);

        
    end

endmodule