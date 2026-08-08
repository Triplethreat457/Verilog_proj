module mux(input sel, input a, input b, output out);  // 2 by 1 bit mux module  
    assign out = sel ? b : a; // if sel == 1, out = b , sel = 0, out = b
endmodule 