// name:array_0_24_ext depth:1024 width:5 masked:true maskGran:5 maskSeg:1
module array_0_24_ext(
  input RW0_clk,
  input [9:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [0:0] RW0_wmask,
  input [4:0] RW0_wdata,
  output [4:0] RW0_rdata
);


  reg reg_RW0_ren;
  reg [9:0] reg_RW0_addr;
  reg [4:0] ram [1023:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #`RANDOMIZE_DELAY begin end
      for (initvar = 0; initvar < 1024; initvar = initvar+1)
        ram[initvar] = {1 {$random}};
      reg_RW0_addr = {1 {$random}};
    end
  `endif
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;
  always @(posedge RW0_clk)
    if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;
  always @(posedge RW0_clk)
    if (RW0_en && RW0_wmode) begin
      if (RW0_wmask[0]) ram[RW0_addr][4:0] <= RW0_wdata[4:0];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] RW0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #`RANDOMIZE_DELAY begin end
      RW0_random = {$random};
      reg_RW0_ren = RW0_random[0];
    end
  `endif
  always @(posedge RW0_clk) RW0_random <= {$random};
  assign RW0_rdata = reg_RW0_ren ? ram[reg_RW0_addr] : RW0_random[4:0];
  `else
  assign RW0_rdata = ram[reg_RW0_addr];
  `endif

endmodule