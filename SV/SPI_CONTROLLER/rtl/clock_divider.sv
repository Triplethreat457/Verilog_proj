// Parameterized Clock Divider for SPI Master Controller
module clock_divider #(parameter int CLK_DIV = 10)
// CLK divsion how much do you want to make the period longer
// Example 10 clk_period per one cycles so 5 cycles would be oscillation starts 

(
    input logic clk,           // Primary system clock
    input logic enable,        // Signal to keep shifting and running the divider
    input logic rst_n,         // Active-low asynchronous reset
    output logic sclk_rising,  // 1-cycle strobe pulse BEFORE sclk rises (0 -> 1)
    output logic sclk_falling, // 1-cycle strobe pulse BEFORE sclk falls (1 -> 0)
    output logic sclk          // SPI generated bus clock (Mode 0: idle LOW)

);

// Internal 8-bit counter tracking system clock cycles within each half-period
logic [31:0] clk_cnt;
// Made clk_cnt same 32 bits as a INT for Verilator
// Sequential block: Handles clock division counting and sclk register updates
always_ff @(posedge clk or negedge rst_n) begin 
    // Asynchronous Reset: Guarantees SPI Mode 0 defaults upon system startup
    if(!rst_n) begin
        sclk <= 1'b0;      // Force sclk LOW for SPI Mode 0 idle state
        clk_cnt <= 'd0;    // Reset internal cycle count to 0
    end
    // Active Operation: Execute division logic while FSM asserts enable
    else if (enable) begin
        clk_cnt <= clk_cnt + 1; // Increment counter every system clock edge
        
        // Terminal Count Reached: Triggers every half-period (e.g., count 4 for CLK_DIV = 10)
        if((CLK_DIV/2  - 1) == clk_cnt) begin
            clk_cnt <= 'd0; // Overrides increment: resets counter to 0 to loop
            sclk <= ~sclk;  // Toggle generated SPI clock state (0 -> 1 or 1 -> 0)
        end
   end 
   // IDLE State: Forces clock divider to a clean state when enable is deasserted
   else begin  //enable = 0 or IDLE state
       sclk <= 1'b0;   // Keep sclk LOW during idle cycles
       clk_cnt <= 'd0; // Hold counter at 0
   end

end

// Combinational Strobe Generators:
// sclk_falling: High for 1 system clk cycle when enable is 1, counter is at max, and sclk is currently HIGH
assign sclk_falling = sclk && (clk_cnt == CLK_DIV/2- 1) && enable;

// sclk_rising: High for 1 system clk cycle when enable is 1, counter is at max, and sclk is currently LOW
assign sclk_rising = !sclk && (clk_cnt == CLK_DIV/2 -1) && enable;

endmodule