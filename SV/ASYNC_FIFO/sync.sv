module syncronizer #(
    parameter int width = 4
)
(
    input  logic                 clk,
    input  logic                 reset_n,
    input  logic [width-1:0]     async_in,
    output logic [width-1:0]     async_out
);

    //----------------------------------------------------------
    // Stage 1 Register
    //
    // Captures the asynchronous input on the first clock edge.
    // This stage may become metastable, but the signal is given
    // an entire clock period to settle before being sampled
    // again.
    //----------------------------------------------------------
    logic [width-1:0] stage_1_reg;



    //----------------------------------------------------------
    // Two-Flip-Flop Synchronizer
    //
    // Reset:
    //      Clear both synchronization stages.
    //
    // Operation:
    //      Stage 1 samples the asynchronous input.
    //      Stage 2 samples Stage 1 on the next clock edge.
    //
    // The second flip-flop greatly reduces the probability of
    // metastability propagating into the rest of the design.
    //----------------------------------------------------------
    always_ff @(posedge clk or negedge reset_n) begin

        if (!reset_n) begin

            stage_1_reg <= 'd0;
            async_out   <= 'd0;

        end
        else begin

            stage_1_reg <= async_in;
            async_out   <= stage_1_reg;

        end

    end

endmodule