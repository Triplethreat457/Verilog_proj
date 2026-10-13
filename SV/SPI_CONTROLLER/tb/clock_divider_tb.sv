module testbench;
logic clk;
logic enable;
logic rst_n;
logic sclk_rising;  // 1-cycle strobe pulse BEFORE sclk rises (0 -> 1)
logic sclk_falling; // 1-cycle strobe pulse BEFORE sclk falls (1 -> 0)
logic sclk;         // SPI generated bus clock (Mode 0: idle LOW)


clock_divider dut(clk,enable,rst_n, sclk_rising, sclk_falling, sclk);

always #5 ~clk = clk;
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,testbench);
clk = 1'b0;
enable = 1'b0;
rst_n = 1'b0;

repeat(5);
@(posedge clk);

rst_n = 1'b1;
#30;

enable = 1'b1;

repeat(20)
@(posedge clk);

repeat(10)
@(posedge clk);

enable = 1'b0; // Testing IDLE state after Transfer

















end





endmodule