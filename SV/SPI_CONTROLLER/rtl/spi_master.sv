// Top-Level Synchronous SPI Master Controller (Mode 0)
module spi_master #(
    parameter int width   = 8,
    parameter int CLK_DIV = 10
)(
  // System Signals
  input  logic             clk,       // Primary system clock
  input  logic             rst_n,     // Active-low asynchronous reset
  input  logic [width-1:0] tx_data,   // Parallel data payload to transmit
  input  logic             start,     // Pulse HIGH for 1 cycle to begin transfer
  
  // Handshake & RX Outputs
  output logic             done,      // Pulses HIGH for 1 cycle upon transfer completion
  output logic [width-1:0] rx_data,   // Parallel output byte received from slave
  output logic             ready,     // HIGH when controller is idle and ready for start
  
  // Physical SPI Bus Lines
  output logic             sclk,      // Generated SPI bus clock
  output logic             cs_n,      // Active-low Chip Select
  input  logic             miso,      // Master In Slave Out line
  output logic             mosi       // Master Out Slave In line
);

// Internal Datapath Interconnects
logic enable;
logic load;
logic sclk_rising;
logic sclk_falling;
logic [$clog2(width):0] edge_count; // 4-bit bus for width=8 (values 0-15)

// FSM State Encoding
typedef enum logic [1:0] {IDLE, TRANSFER, DONE} state_e;
state_e state_t, next_state;

// Submodule Instantiations
clock_divider #(CLK_DIV) sk (
    .clk          (clk), 
    .rst_n        (rst_n), 
    .sclk         (sclk), 
    .enable       (enable), 
    .sclk_falling (sclk_falling), 
    .sclk_rising  (sclk_rising)
);

edge_counter #(width) ec (
    .clk          (clk),
    .rst_n        (rst_n), 
    .enable       (enable),
    .sclk_falling (sclk_falling), 
    .sclk_rising  (sclk_rising),
    .edge_count   (edge_count)
);

tx_reg #(width) tx (
    .clk          (clk), 
    .sclk_falling (sclk_falling),
    .rst_n        (rst_n),
    .enable       (enable),
    .load         (load),
    .mosi         (mosi),
    .tx_data      (tx_data)
);

rx_reg #(width) rx (
    .clk          (clk),
    .sclk_rising  (sclk_rising),
    .rst_n        (rst_n),
    .miso         (miso),
    .enable       (enable),
    .rx_reg       (rx_data)
);

// FSM Combinational Next-State Logic
always_comb begin
    case (state_t)
        IDLE: begin
            next_state = start ? TRANSFER : IDLE;
        end
        TRANSFER: begin
            // Hold transfer until edge 15 finishes on final sclk_falling strobe
            next_state = ((edge_count == (width * 2 - 1)) && sclk_falling) ? DONE : TRANSFER;
        end
        DONE: begin 
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

// FSM Sequential Register
always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) state_t <= IDLE;
    else        state_t <= next_state;
end

// Output Control Assignments
assign enable = (state_t == TRANSFER);
assign load   = (state_t == IDLE);
assign cs_n   = (state_t != TRANSFER);
assign done   = (state_t == DONE);
assign ready  = (state_t == IDLE); // Fixed syntax operator

endmodule