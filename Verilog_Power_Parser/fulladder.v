module full_adder( 
    input a, b, cin,
    output cout, sum );
    assign cout = (a & b) | (cin & (a | b));
    assign sum = cin ^ a ^ b;
        

endmodule
