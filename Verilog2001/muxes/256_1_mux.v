module twohundred56_mux( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    //select one bit form vector in[]. The bit is being selected...
    assign out = in[sel];

endmodule
