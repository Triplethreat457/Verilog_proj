module binary_gray #(parameter int width = 8)
(
    input  logic [width-1:0] binary,
    output logic [width-1:0] gray
);

    integer i;

    //----------------------------------------------------------
    // Binary-to-Gray Conversion
    //
    // MSB remains unchanged.
    //
    // Every remaining Gray bit is:
    //
    //      Gray[i] = Binary[i+1] XOR Binary[i]
    //----------------------------------------------------------
    always_comb begin

        for (i = 0; i < width; ++i) begin

            if (i == width - 1) begin
                gray[i] = binary[i];
            end
            else begin
                gray[i] = binary[i + 1] ^ binary[i];
            end

        end

    end

endmodule