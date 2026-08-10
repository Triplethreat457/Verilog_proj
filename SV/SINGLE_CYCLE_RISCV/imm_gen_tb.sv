module testbench;

  logic [31:0] instr;
  logic [2:0]  imm_sel;
  logic [31:0] imm;

  imm_gen dut (
    .instr(instr),
    .sel(imm_sel),
    .imm(imm)
  );

  task check_imm(
    input logic [31:0] instruction,
    input logic [2:0]  select,
    input logic [31:0] expected
  );
    begin
      instr   = instruction;
      imm_sel = select;

      #1;

      if (imm !== expected)
        $error("FAIL: sel=%0d instr=%h expected=%h got=%h",
               select, instruction, expected, imm);
      else
        $display("PASS: sel=%0d expected=%h got=%h",
                 select, expected, imm);
    end
  endtask


  initial begin

    // I-type: +10
    check_imm(
      32'b000000001010_00000_000_00001_0010011,
      3'd0,
      32'd10
    );

    // I-type: -5
    check_imm(
      32'b111111111011_00000_000_00001_0010011,
      3'd0,
      32'hFFFFFFFB
    );

    // S-type: +20
    check_imm(
      32'b0000000_00000_00000_010_10100_0100011,
      3'd1,
      32'd20
    );

    // U-type
    check_imm(
      32'h12345037,
      3'd3,
      32'h12345000
    );

    $display("Testing complete.");
    $finish;
  end

endmodule