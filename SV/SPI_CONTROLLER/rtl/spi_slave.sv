module spi_slave #(parameter int width = 8)(
// System Inputs
input logic clk,
input logic rst_n,

// From Master to Master

input logic mosi,
input logic cs_n,
input logic sclk, 
output logic miso,

// Local Parallel Interface

input logic [width-1:0] tx_data, // Data slave sends to Master
output  logic [width-1:0] rx_data, // Data slave receives from Master
output rx_valid // Signal to denote ready for full byte is processed, ready for next


);
logic sclk_d;
logic cs_up;
logic mosi_up;
logic sclk_up;
logic enable;
logic sclk_rising;
logic sclk_falling;
logic [$clog2(width):0] edge_count;
// FSM State Encoding
typedef enum logic [1:0] {IDLE, TRANSFER, DONE} state_e;
/*
IDLE state:
- Data is ready for next Transfer
- Only can leave once cs_up from Master is asserted low
- Goes here after every DONE STATE
- SCLK is IDLE LOW
TRANSFER


*/

state_e state, next_state;

edge_counter #(width) ec(
    .clk          (clk),
    .rst_n        (rst_n), 
    .enable       (enable),
    .sclk_falling (sclk_falling), 
    .sclk_rising  (sclk_rising),
    .edge_count   (edge_count)
);

syncronizer #(.RESET_VAL(1'b1))cs_n_sy(.clk(clk),.data_in(cs_n), .data_out(cs_up),rst_n(rst_n));
syncronizer #(.RESET_VAL(1'b0)) sclk_sy(.clk(clk),.data_in(sclk), .data_out(sclk_up),.rst_n(rst_n));
syncronizer #(.RESET_VAL(1'b0)) mosi_sy(.clk(clk),.data_in(mosi), .data_out(mosi_up), .rst_n(rst_n));

tx_reg #(width) tx (
    .clk          (clk), 
    .sclk_falling (sclk_falling),
    .rst_n        (rst_n),
    .enable       (enable),
    .load         (load),
    .mosi         (miso),
    .tx_data      (tx_data)
);

rx_reg #(width) rx ( // revieving as mosi master out slave in
    .clk (clk),
    .sclk_rising (sclk_rising),
    .rst_n(rst_n),
    .enable(enable),
    .miso(mosi),
    .rx_data(rx_data)
);


// Forcing IDLE 
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) sclk_d <= 1'b0;
    else sclk_d <= sclk_up;
end




assign sclk_rising = (sclk_d == 1'b1) & (sclk_up == 1'b0) & (cs_up == 1'b1);
assign sclk_falling = (sclk_d == 1'b0) & (sclk_up == 1'b1) & (cs_up == 1'b0);
assign miso = tx_data[7]; 
assign enable = ~cs_up; 
// We are going to base our enable signal cs_up is synced
assign load = (state == IDLE);

always_comb begin 
    case (state)
    IDLE: begin
    next_state = ~(cs_up) ? TRANSFER : IDLE;
    end
    TRANSFER: begin 
    next_state = ((edge_count == (width * 2 - 1)) && sclk_falling) ? DONE : TRANSFER;
    end
    DONE: begin 
    next_state = IDLE;
    end
    endcase

end 

always_ff @(posedge clk) begin
if (!rst_n) begin
    state <= IDLE;
end
else begin 
    state <= next_state;
end
end






endmodule