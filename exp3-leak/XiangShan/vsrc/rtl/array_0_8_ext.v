// name:array_0_8_ext depth:128 width:51 masked:false maskGran:51 maskSeg:1
module array_0_8_ext(
  input R0_clk,
  input [6:0] R0_addr,
  input R0_en,
  output [50:0] R0_data,
  input W0_clk,
  input [6:0] W0_addr,
  input W0_en,
  input [50:0] W0_data
);


  reg reg_R0_ren;
  reg [6:0] reg_R0_addr;
  reg [50:0] ram [127:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #`RANDOMIZE_DELAY begin end
      for (initvar = 0; initvar < 128; initvar = initvar+1)
        ram[initvar] = {2 {$random}};
      reg_R0_addr = {1 {$random}};
    end
  `endif
  always @(posedge R0_clk)
    reg_R0_ren <= R0_en;
  always @(posedge R0_clk)
    if (R0_en) reg_R0_addr <= R0_addr;
  always @(posedge W0_clk)
    if (W0_en) begin
      ram[W0_addr][50:0] <= W0_data[50:0];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [63:0] R0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #`RANDOMIZE_DELAY begin end
      R0_random = {$random, $random};
      reg_R0_ren = R0_random[0];
    end
  `endif
  always @(posedge R0_clk) R0_random <= {$random, $random};
  assign R0_data = reg_R0_ren ? ram[reg_R0_addr] : R0_random[50:0];
  `else
  assign R0_data = ram[reg_R0_addr];
  `endif

endmodule