// name:array_0_7_ext depth:256 width:6 masked:true maskGran:6 maskSeg:1
module array_0_7_ext(
  input R0_clk,
  input [7:0] R0_addr,
  input R0_en,
  output [5:0] R0_data,
  input W0_clk,
  input [7:0] W0_addr,
  input W0_en,
  input [5:0] W0_data,
  input [0:0] W0_mask
);


  reg reg_R0_ren;
  reg [7:0] reg_R0_addr;
  reg [5:0] ram [255:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #`RANDOMIZE_DELAY begin end
      for (initvar = 0; initvar < 256; initvar = initvar+1)
        ram[initvar] = {1 {$random}};
      reg_R0_addr = {1 {$random}};
    end
  `endif
  always @(posedge R0_clk)
    reg_R0_ren <= R0_en;
  always @(posedge R0_clk)
    if (R0_en) reg_R0_addr <= R0_addr;
  always @(posedge W0_clk)
    if (W0_en) begin
      if (W0_mask[0]) ram[W0_addr][5:0] <= W0_data[5:0];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] R0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #`RANDOMIZE_DELAY begin end
      R0_random = {$random};
      reg_R0_ren = R0_random[0];
    end
  `endif
  always @(posedge R0_clk) R0_random <= {$random};
  assign R0_data = reg_R0_ren ? ram[reg_R0_addr] : R0_random[5:0];
  `else
  assign R0_data = ram[reg_R0_addr];
  `endif

endmodule