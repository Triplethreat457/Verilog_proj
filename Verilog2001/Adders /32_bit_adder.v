module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire [15:0] sum1;
    wire [15:0] sum2;
    wire cout_1;
    
    add16 inoi(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .cout(cout_1), .sum(sum1));
    add16 inoi2(.a(a[31:16]), .b(b[31:16]), .cin(cout_1), .sum(sum2), .cout());
    assign sum = {sum2, sum1};

endmodule

module add1( input a, input b, input cin,   output sum, output cout );
    assign sum = (a ^ b) ^ cin;
    assign cout = ((a & b) | ((a ^ b) & cin));
// Full adder module here

endmodule
module add16( input [15:0] a, input [15:0] b, output [15:0] sum, input cin, output cout);
    wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
    wire sum0,sum_1,sum_bit_2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15;
    add1 dut(.cin(cin),.a(a[0]), .b(b[0]), .sum(sum0), .cout(c1));
    add1 dut1(.cin(c1),.a(a[1]), .b(b[1]), .sum(sum_1), .cout(c2));
    add1 dut2(.cin(c2),.a(a[2]), .b(b[2]), .sum(sum_bit_2), .cout(c3));
    add1 dut3(.cin(c3),.a(a[3]), .b(b[3]), .sum(sum3), .cout(c4));
    add1 dut4(.cin(c4),.a(a[4]), .b(b[4]), .sum(sum4), .cout(c5));
    add1 dut5(.cin(c5),.a(a[5]), .b(b[5]), .sum(sum5), .cout(c6));
    add1 dut6(.cin(c6),.a(a[6]), .b(b[6]), .sum(sum6), .cout(c7));
    add1 dut7(.cin(c7),.a(a[7]), .b(b[7]), .sum(sum7), .cout(c8));
    add1 dut8(.cin(c8),.a(a[8]), .b(b[8]), .sum(sum8), .cout(c9));
    add1 dut9(.cin(c9),.a(a[9]), .b(b[9]), .sum(sum9), .cout(c10));
    add1 dut10(.cin(c10),.a(a[10]), .b(b[10]), .sum(sum10), .cout(c11));
    add1 dut11(.cin(c11),.a(a[11]), .b(b[11]), .sum(sum11), .cout(c12));
    add1 dut12(.cin(c12),.a(a[12]), .b(b[12]), .sum(sum12), .cout(c13));
    add1 dut13(.cin(c13),.a(a[13]), .b(b[13]), .sum(sum13), .cout(c14));
    add1 dut14(.cin(c14),.a(a[14]), .b(b[14]), .sum(sum14), .cout(c15));
    add1 dut15(.cin(c15),.a(a[15]), .b(b[15]), .sum(sum15), .cout(cout));
    assign sum = ({sum15, sum14, sum13, sum12, sum11, sum10, sum9, sum8, sum7, sum6, sum5, sum4, sum3, sum_bit_2, sum_1, sum0});
    

endmodule

