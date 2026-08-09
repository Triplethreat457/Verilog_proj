`include "sync.sv"
`include "rp_hand.sv"
`include "ram.sv"
`include "wp_hand.sv"

module async_FIFO #(parameter int addr_bits = 8,
                   parameter int d_width = 8,
                   parameter int a_max = 256 //2^8 possible address locations
                   )(
  
    input  logic                    w_en,
    input  logic                    r_en,
    input  logic                    rclk,
    input  logic                    wclk,
 
    
    input  logic                    wp_reset_n,
    input  logic                    rp_reset_n,
  
  input  logic [d_width-1:0]      write_data,
    
    // Outputs
  output logic [d_width-1:0]      read_data,
  // output logic [d_width-1:0] memory [0:a_max-1], //For Simulation only and debugging
  output logic full,
  output logic empty
  
);

    //==========================================================
    // Top-Level Asynchronous FIFO
    //
    // This module will eventually contain:
    //   - FIFO memory
    //   - Write pointer logic
    //   - Read pointer logic
    //   - Pointer synchronizers
    //   - Full and empty detection
    //==========================================================
  
  // These get fed into the ram to read and an output of the pointer hander
  // These will get truncated when we feed it to the ram port
  
  logic [addr_bits:0] rptr;
  logic [addr_bits:0] wptr; 
  
 
  logic [addr_bits:0] gsync_rptr;
  logic [addr_bits:0] gsync_wptr;
  
  
  logic [addr_bits:0] g_wptr;
  logic [addr_bits:0] g_rptr;
 // logic [d_width-1:0] memory [0:a_max-1];
  
  ram  #(.A_WIDTH(addr_bits), 
         .A_MAX(a_max),
         .D_WIDTH(d_width)) 
  rm (.write_clk(wclk),
     .read_clk(rclk),
     .write_en(w_en), 
     .read_en(r_en),
     .data_input(write_data),
     .read_data(read_data),
     .read_addr(rptr[addr_bits-1:0]),
      .write_addr(wptr[addr_bits-1:0])
    );
 
  
  wp_hand #(.addr_bits(addr_bits)) 
  wp(.gsync_rptr(gsync_rptr), 
     .w_en(w_en), 
     .wclk(wclk),
     .areset(wp_reset_n),
     .b_wptr(wptr),
     .g_wptr(g_wptr),
     .full(full)
    );
  
  
  rp_hand #(.addr_bits(addr_bits))
  rp(.gsync_wptr(gsync_wptr),
     .rclk(rclk),
     .r_en(r_en),
     .areset(rp_reset_n),
     .b_rptr(rptr),
     .g_rptr(g_rptr),
     .empty(empty)
    );
  // sync on writing pointer handler to sync incoming gray read pointer 
  syncronizer  #(addr_bits + 1) syncw(.clk(wclk), .reset_n(wp_reset_n), .async_in(g_rptr), .async_out(gsync_rptr));
  // sync on reading pointer handler to sync incoming gray write pointer 
  syncronizer  #(addr_bits + 1) syncr(.clk(rclk), .reset_n(rp_reset_n), .async_in(g_wptr), .async_out(gsync_wptr));
  
  
  
  
  

endmodule




