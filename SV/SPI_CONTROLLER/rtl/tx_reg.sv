// SPI Master Transmit Register Module
// Parallel-loads tx_data and shifts out bits MSB-first on sclk_falling
module tx_reg #(parameter int width = 8)(
    input  logic             clk,          // Primary system clock
    input  logic             load,         // Asserted 1 cycle to load parallel tx_data
    input  logic             enable,       // Active transaction flag
    input  logic             sclk_falling, // 1-cycle strobe trigger for shift edge
    input  logic             rst_n,        // Active-low asynchronous reset
    input  logic [width-1:0] tx_data,      // Parallel data input byte from system/FSM
    output logic             mosi          // Master Out Slave In serial output pin
);

// Internal shift register holding active transmit payload
logic [width-1:0] data;

// Sequential logic handling parallel load and serial left-shift
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 'd0;                      // Reset internal data register
    end else if (load) begin
        data <= tx_data;                  // Parallel-load data byte before transfer
    end else if (enable && sclk_falling) begin
        data <= {data[width-2:0], 1'b0};  // Shift left: pushes bit [width-2] into MSB position
    end
end

// Continuously output current MSB directly onto MOSI line
assign mosi = data[width-1];

endmodule