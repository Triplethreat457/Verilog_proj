module three_bit_rca(
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum);
    
   
    full_adder dut(.cin(cin), .a(a[0]), .b(b[0]), .cout(cout[0]), .sum(sum[0]));
    full_adder dut1(.cin(cout[0]), .a(a[1]), .b(b[1]), .cout(cout[1]), .sum(sum[1]));
    full_adder dut2(.cin(cout[1]), .a(a[2]), .b(b[2]), .cout(cout[2]), .sum(sum[2]));










endmodule

module full_adder(input cin, input a, input b, output cout, output sum );

assign cout = (a & b) | (cin & (a | b));
assign sum = a ^ b ^ cin;


endmodule 
