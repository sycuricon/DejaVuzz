module Queue_12_tb(
  input         clock,
  input         reset,
  output        io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [63:0] io_enq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [7:0]  io_enq_bits_strb, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_bits_last, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [63:0] io_deq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [7:0]  io_deq_bits_strb, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_bits_last // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_data [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [7:0] ram_strb [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_strb_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_strb_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  ram_last [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  empty = ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:28]
  wire  _do_enq_T = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _do_deq_T = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_11 = io_deq_ready ? 1'h0 : _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 319:26 281:27 319:35]
  wire  do_enq = empty ? _GEN_11 : _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 316:17 281:27]
  wire  do_deq = empty ? 1'h0 : _do_deq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 316:17 318:14 282:27]
  assign ram_data_io_deq_bits_MPORT_en = 1'h1;
  assign ram_data_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_data_io_deq_bits_MPORT_data = ram_data[ram_data_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_data_MPORT_data = io_enq_bits_data;
  assign ram_data_MPORT_addr = 1'h0;
  assign ram_data_MPORT_mask = 1'h1;
  assign ram_data_MPORT_en = empty ? _GEN_11 : _do_enq_T;
  assign ram_strb_io_deq_bits_MPORT_en = 1'h1;
  assign ram_strb_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_strb_io_deq_bits_MPORT_data = ram_strb[ram_strb_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_strb_MPORT_data = io_enq_bits_strb;
  assign ram_strb_MPORT_addr = 1'h0;
  assign ram_strb_MPORT_mask = 1'h1;
  assign ram_strb_MPORT_en = empty ? _GEN_11 : _do_enq_T;
  assign ram_last_io_deq_bits_MPORT_en = 1'h1;
  assign ram_last_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_last_io_deq_bits_MPORT_data = ram_last[ram_last_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_last_MPORT_data = io_enq_bits_last;
  assign ram_last_MPORT_addr = 1'h0;
  assign ram_last_MPORT_mask = 1'h1;
  assign ram_last_MPORT_en = empty ? _GEN_11 : _do_enq_T;
  assign io_enq_ready = ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = io_enq_valid | ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:16 315:{24,39}]
  assign io_deq_bits_data = empty ? io_enq_bits_data : ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_strb = empty ? io_enq_bits_strb : ram_strb_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_last = empty ? io_enq_bits_last : ram_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  always @(posedge clock) begin
    if (ram_data_MPORT_en & ram_data_MPORT_mask) begin
      ram_data[ram_data_MPORT_addr] <= ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_strb_MPORT_en & ram_strb_MPORT_mask) begin
      ram_strb[ram_strb_MPORT_addr] <= ram_strb_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_last_MPORT_en & ram_last_MPORT_mask) begin
      ram_last[ram_last_MPORT_addr] <= ram_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      if (empty) begin // @[src/main/scala/chisel3/util/Decoupled.scala 316:17]
        if (io_deq_ready) begin // @[src/main/scala/chisel3/util/Decoupled.scala 319:26]
          maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 319:35]
        end else begin
          maybe_full <= _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 281:27]
        end
      end else begin
        maybe_full <= _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 281:27]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_data[initvar] = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_strb[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_last[initvar] = _RAND_2[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4RAM_tb(
  input         clock,
  input         reset,
  output        auto_in_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_in_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_in_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_bits_echo_real_last // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire [27:0] mem_R0_addr; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_R0_en; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_R0_clk; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_0; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_1; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_2; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_3; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_4; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_5; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_6; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_R0_data_7; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [27:0] mem_W0_addr; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_en; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_clk; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_0; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_1; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_2; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_3; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_4; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_5; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_6; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [7:0] mem_W0_data_7; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_0; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_1; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_2; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_3; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_4; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_5; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_6; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire  mem_W0_mask_7; // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
  wire [6:0] r_addr_lo_lo = {auto_in_ar_bits_addr[9],auto_in_ar_bits_addr[8],auto_in_ar_bits_addr[7],
    auto_in_ar_bits_addr[6],auto_in_ar_bits_addr[5],auto_in_ar_bits_addr[4],auto_in_ar_bits_addr[3]}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 65:21]
  wire [13:0] r_addr_lo = {auto_in_ar_bits_addr[16],auto_in_ar_bits_addr[15],auto_in_ar_bits_addr[14],
    auto_in_ar_bits_addr[13],auto_in_ar_bits_addr[12],auto_in_ar_bits_addr[11],auto_in_ar_bits_addr[10],r_addr_lo_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 65:21]
  wire [6:0] r_addr_hi_lo = {auto_in_ar_bits_addr[23],auto_in_ar_bits_addr[22],auto_in_ar_bits_addr[21],
    auto_in_ar_bits_addr[20],auto_in_ar_bits_addr[19],auto_in_ar_bits_addr[18],auto_in_ar_bits_addr[17]}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 65:21]
  wire [13:0] r_addr_hi = {auto_in_ar_bits_addr[30],auto_in_ar_bits_addr[29],auto_in_ar_bits_addr[28],
    auto_in_ar_bits_addr[27],auto_in_ar_bits_addr[26],auto_in_ar_bits_addr[25],auto_in_ar_bits_addr[24],r_addr_hi_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 65:21]
  wire [6:0] w_addr_lo_lo = {auto_in_aw_bits_addr[9],auto_in_aw_bits_addr[8],auto_in_aw_bits_addr[7],
    auto_in_aw_bits_addr[6],auto_in_aw_bits_addr[5],auto_in_aw_bits_addr[4],auto_in_aw_bits_addr[3]}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 66:21]
  wire [13:0] w_addr_lo = {auto_in_aw_bits_addr[16],auto_in_aw_bits_addr[15],auto_in_aw_bits_addr[14],
    auto_in_aw_bits_addr[13],auto_in_aw_bits_addr[12],auto_in_aw_bits_addr[11],auto_in_aw_bits_addr[10],w_addr_lo_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 66:21]
  wire [6:0] w_addr_hi_lo = {auto_in_aw_bits_addr[23],auto_in_aw_bits_addr[22],auto_in_aw_bits_addr[21],
    auto_in_aw_bits_addr[20],auto_in_aw_bits_addr[19],auto_in_aw_bits_addr[18],auto_in_aw_bits_addr[17]}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 66:21]
  wire [13:0] w_addr_hi = {auto_in_aw_bits_addr[30],auto_in_aw_bits_addr[29],auto_in_aw_bits_addr[28],
    auto_in_aw_bits_addr[27],auto_in_aw_bits_addr[26],auto_in_aw_bits_addr[25],auto_in_aw_bits_addr[24],w_addr_hi_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 66:21]
  wire [31:0] _r_sel0_T = auto_in_ar_bits_addr ^ 32'h80000000; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:31]
  wire [32:0] _r_sel0_T_1 = {1'b0,$signed(_r_sel0_T)}; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:41]
  wire [32:0] _r_sel0_T_3 = $signed(_r_sel0_T_1) & -33'sh80000000; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:46]
  wire [31:0] _w_sel0_T = auto_in_aw_bits_addr ^ 32'h80000000; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:31]
  wire [32:0] _w_sel0_T_1 = {1'b0,$signed(_w_sel0_T)}; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:41]
  wire [32:0] _w_sel0_T_3 = $signed(_w_sel0_T_1) & -33'sh80000000; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:46]
  wire  w_sel0 = $signed(_w_sel0_T_3) == 33'sh0; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:59]
  reg  w_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 70:25]
  reg [3:0] w_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 71:21]
  reg  w_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 72:21]
  reg  r_sel1; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 73:25]
  reg  w_sel1; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 74:25]
  wire  _T = auto_in_b_ready & w_full; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_0 = _T ? 1'h0 : w_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 76:23 70:25 76:32]
  wire  _nodeIn_aw_ready_T_1 = auto_in_b_ready | ~w_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 92:47]
  wire  nodeIn_aw_ready = auto_in_w_valid & (auto_in_b_ready | ~w_full); // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 92:32]
  wire  _T_1 = nodeIn_aw_ready & auto_in_aw_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_1 = _T_1 | _GEN_0; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 77:{23,32}]
  reg  r_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 99:25]
  reg [3:0] r_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 100:21]
  reg  r_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 101:21]
  wire  _T_13 = auto_in_r_ready & r_full; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_40 = _T_13 ? 1'h0 : r_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 103:{23,32} 99:25]
  wire  nodeIn_ar_ready = auto_in_r_ready | ~r_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 117:31]
  wire  _T_14 = nodeIn_ar_ready & auto_in_ar_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_41 = _T_14 | _GEN_40; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 104:{23,32}]
  reg  rdata_REG; // @[repo/rocket-chip/src/main/scala/util/package.scala 92:91]
  reg [7:0] rdata_r_0; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_1; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_2; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_3; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_4; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_5; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_6; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  reg [7:0] rdata_r_7; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
  wire [7:0] _GEN_49 = rdata_REG ? mem_R0_data_0 : rdata_r_0; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_50 = rdata_REG ? mem_R0_data_1 : rdata_r_1; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_51 = rdata_REG ? mem_R0_data_2 : rdata_r_2; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_52 = rdata_REG ? mem_R0_data_3 : rdata_r_3; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_53 = rdata_REG ? mem_R0_data_4 : rdata_r_4; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_54 = rdata_REG ? mem_R0_data_5 : rdata_r_5; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_55 = rdata_REG ? mem_R0_data_6 : rdata_r_6; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [7:0] _GEN_56 = rdata_REG ? mem_R0_data_7 : rdata_r_7; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:{63,63,63}]
  wire [31:0] nodeIn_r_bits_data_lo = {_GEN_52,_GEN_51,_GEN_50,_GEN_49}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 121:26]
  wire [31:0] nodeIn_r_bits_data_hi = {_GEN_56,_GEN_55,_GEN_54,_GEN_53}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 121:26]
  mem_tb mem ( // @[repo/rocket-chip/src/main/scala/util/DescribedSRAM.scala 17:26]
    .R0_addr(mem_R0_addr),
    .R0_en(mem_R0_en),
    .R0_clk(mem_R0_clk),
    .R0_data_0(mem_R0_data_0),
    .R0_data_1(mem_R0_data_1),
    .R0_data_2(mem_R0_data_2),
    .R0_data_3(mem_R0_data_3),
    .R0_data_4(mem_R0_data_4),
    .R0_data_5(mem_R0_data_5),
    .R0_data_6(mem_R0_data_6),
    .R0_data_7(mem_R0_data_7),
    .W0_addr(mem_W0_addr),
    .W0_en(mem_W0_en),
    .W0_clk(mem_W0_clk),
    .W0_data_0(mem_W0_data_0),
    .W0_data_1(mem_W0_data_1),
    .W0_data_2(mem_W0_data_2),
    .W0_data_3(mem_W0_data_3),
    .W0_data_4(mem_W0_data_4),
    .W0_data_5(mem_W0_data_5),
    .W0_data_6(mem_W0_data_6),
    .W0_data_7(mem_W0_data_7),
    .W0_mask_0(mem_W0_mask_0),
    .W0_mask_1(mem_W0_mask_1),
    .W0_mask_2(mem_W0_mask_2),
    .W0_mask_3(mem_W0_mask_3),
    .W0_mask_4(mem_W0_mask_4),
    .W0_mask_5(mem_W0_mask_5),
    .W0_mask_6(mem_W0_mask_6),
    .W0_mask_7(mem_W0_mask_7)
  );
  assign auto_in_aw_ready = auto_in_w_valid & (auto_in_b_ready | ~w_full); // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 92:32]
  assign auto_in_w_ready = auto_in_aw_valid & _nodeIn_aw_ready_T_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 93:32]
  assign auto_in_b_valid = w_full; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 91:17]
  assign auto_in_b_bits_id = w_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 95:20]
  assign auto_in_b_bits_resp = w_sel1 ? 2'h0 : 2'h3; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 96:26]
  assign auto_in_b_bits_echo_real_last = w_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 97:20]
  assign auto_in_ar_ready = auto_in_r_ready | ~r_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 117:31]
  assign auto_in_r_valid = r_full; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 116:17 repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17]
  assign auto_in_r_bits_id = r_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 119:20]
  assign auto_in_r_bits_data = {nodeIn_r_bits_data_hi,nodeIn_r_bits_data_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 121:26]
  assign auto_in_r_bits_resp = r_sel1 ? 2'h0 : 2'h3; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 120:26]
  assign auto_in_r_bits_echo_real_last = r_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 122:20]
  assign mem_R0_addr = {r_addr_hi,r_addr_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 65:21]
  assign mem_R0_en = nodeIn_ar_ready & auto_in_ar_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  assign mem_R0_clk = clock; // @[repo/rocket-chip/src/main/scala/util/package.scala 92:{58,58}]
  assign mem_W0_addr = {w_addr_hi,w_addr_lo}; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 66:21]
  assign mem_W0_en = _T_1 & w_sel0; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 86:22]
  assign mem_W0_clk = clock; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 86:33]
  assign mem_W0_data_0 = auto_in_w_bits_data[7:0]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_1 = auto_in_w_bits_data[15:8]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_2 = auto_in_w_bits_data[23:16]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_3 = auto_in_w_bits_data[31:24]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_4 = auto_in_w_bits_data[39:32]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_5 = auto_in_w_bits_data[47:40]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_6 = auto_in_w_bits_data[55:48]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_data_7 = auto_in_w_bits_data[63:56]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 85:66]
  assign mem_W0_mask_0 = auto_in_w_bits_strb[0]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_1 = auto_in_w_bits_strb[1]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_2 = auto_in_w_bits_strb[2]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_3 = auto_in_w_bits_strb[3]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_4 = auto_in_w_bits_strb[4]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_5 = auto_in_w_bits_strb[5]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_6 = auto_in_w_bits_strb[6]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  assign mem_W0_mask_7 = auto_in_w_bits_strb[7]; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 87:47]
  always @(posedge clock) begin
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 70:25]
      w_full <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 70:25]
    end else begin
      w_full <= _GEN_1;
    end
    if (_T_1) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 79:23]
      w_id <= auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 80:12]
    end
    if (_T_1) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 79:23]
      w_echo_real_last <= auto_in_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 82:14]
    end
    r_sel1 <= $signed(_r_sel0_T_3) == 33'sh0; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:59]
    w_sel1 <= $signed(_w_sel0_T_3) == 33'sh0; // @[repo/rocket-chip/src/main/scala/diplomacy/Parameters.scala 137:59]
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 99:25]
      r_full <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 99:25]
    end else begin
      r_full <= _GEN_41;
    end
    if (_T_14) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 106:23]
      r_id <= auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 107:12]
    end
    if (_T_14) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 106:23]
      r_echo_real_last <= auto_in_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/SRAM.scala 109:14]
    end
    rdata_REG <= nodeIn_ar_ready & auto_in_ar_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_0 <= mem_R0_data_0; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_1 <= mem_R0_data_1; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_2 <= mem_R0_data_2; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_3 <= mem_R0_data_3; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_4 <= mem_R0_data_4; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_5 <= mem_R0_data_5; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_6 <= mem_R0_data_6; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
    if (rdata_REG) begin // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
      rdata_r_7 <= mem_R0_data_7; // @[repo/rocket-chip/src/main/scala/util/package.scala 80:63]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  w_full = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  w_id = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  w_echo_real_last = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  r_sel1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  w_sel1 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  r_full = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  r_id = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  r_echo_real_last = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rdata_REG = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  rdata_r_0 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  rdata_r_1 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  rdata_r_2 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  rdata_r_3 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  rdata_r_4 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  rdata_r_5 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  rdata_r_6 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  rdata_r_7 = _RAND_16[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4Xbar_tb(
  input         clock,
  input         reset,
  output        auto_in_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_aw_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [2:0]  auto_in_aw_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_in_aw_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_in_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_ar_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [2:0]  auto_in_ar_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_in_ar_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_in_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [7:0]  auto_out_aw_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [2:0]  auto_out_aw_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_out_aw_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_out_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [7:0]  auto_out_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_w_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [7:0]  auto_out_ar_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [2:0]  auto_out_ar_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_out_ar_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_out_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_bits_last // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
);
  wire  _awOut_0_io_enq_bits_T_1 = ~auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:60]
  wire  _awOut_0_io_enq_bits_T_4 = ~reset; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:11]
  wire  _T_1 = ~auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:60]
  wire  _T_13 = ~auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:60]
  wire  _T_25 = ~auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:60]
  assign auto_in_aw_ready = auto_out_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_w_ready = auto_out_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_b_valid = auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 297:22]
  assign auto_in_b_bits_id = auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 91:65]
  assign auto_in_b_bits_resp = auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_ar_ready = auto_out_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_valid = auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 297:22]
  assign auto_in_r_bits_id = auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 91:65]
  assign auto_in_r_bits_data = auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_resp = auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_last = auto_out_r_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_out_aw_valid = auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 297:22]
  assign auto_out_aw_bits_id = auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 94:47]
  assign auto_out_aw_bits_addr = auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_aw_bits_len = auto_in_aw_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_aw_bits_size = auto_in_aw_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_aw_bits_burst = auto_in_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_w_valid = auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 241:40]
  assign auto_out_w_bits_data = auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_w_bits_strb = auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_w_bits_last = auto_in_w_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_b_ready = auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_ar_valid = auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 297:22]
  assign auto_out_ar_bits_id = auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 95:47]
  assign auto_out_ar_bits_addr = auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_ar_bits_len = auto_in_ar_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_ar_bits_size = auto_in_ar_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_ar_bits_burst = auto_in_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign auto_out_r_ready = auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~1'h1 & ~reset) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_awOut_0_io_enq_bits_T_4 & ~(_awOut_0_io_enq_bits_T_1 | auto_in_aw_valid)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Xbar.scala:277 assert (!anyValid || winner.reduce(_||_))\n"); // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_awOut_0_io_enq_bits_T_1 | auto_in_aw_valid) & _awOut_0_io_enq_bits_T_4) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~1'h1 & ~reset) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_awOut_0_io_enq_bits_T_4 & ~(_T_1 | auto_in_ar_valid)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Xbar.scala:277 assert (!anyValid || winner.reduce(_||_))\n"); // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_1 | auto_in_ar_valid) & _awOut_0_io_enq_bits_T_4) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~1'h1 & ~reset) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_awOut_0_io_enq_bits_T_4 & ~(_T_13 | auto_out_r_valid)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Xbar.scala:277 assert (!anyValid || winner.reduce(_||_))\n"); // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_13 | auto_out_r_valid) & _awOut_0_io_enq_bits_T_4) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~1'h1 & ~reset) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 275:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_awOut_0_io_enq_bits_T_4 & ~(_T_25 | auto_out_b_valid)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Xbar.scala:277 assert (!anyValid || winner.reduce(_||_))\n"); // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_25 | auto_out_b_valid) & _awOut_0_io_enq_bits_T_4) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 277:12]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module Queue_68_tb(
  input         clock,
  input         reset,
  output        io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [3:0]  io_enq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [31:0] io_enq_bits_addr, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_bits_echo_real_last, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [3:0]  io_deq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [31:0] io_deq_bits_addr, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_bits_echo_real_last // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_id [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [31:0] ram_addr [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [31:0] ram_addr_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [31:0] ram_addr_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  ram_echo_real_last [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  enq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  deq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 278:33]
  wire  empty = ptr_match & ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:25]
  wire  full = ptr_match & maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 280:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  assign ram_id_io_deq_bits_MPORT_en = 1'h1;
  assign ram_id_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_id_io_deq_bits_MPORT_data = ram_id[ram_id_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_id_MPORT_data = io_enq_bits_id;
  assign ram_id_MPORT_addr = enq_ptr_value;
  assign ram_id_MPORT_mask = 1'h1;
  assign ram_id_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_addr_io_deq_bits_MPORT_en = 1'h1;
  assign ram_addr_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_addr_io_deq_bits_MPORT_data = ram_addr[ram_addr_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_addr_MPORT_data = io_enq_bits_addr;
  assign ram_addr_MPORT_addr = enq_ptr_value;
  assign ram_addr_MPORT_mask = 1'h1;
  assign ram_addr_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_echo_real_last_io_deq_bits_MPORT_en = 1'h1;
  assign ram_echo_real_last_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_echo_real_last_io_deq_bits_MPORT_data = ram_echo_real_last[ram_echo_real_last_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_echo_real_last_MPORT_data = io_enq_bits_echo_real_last;
  assign ram_echo_real_last_MPORT_addr = enq_ptr_value;
  assign ram_echo_real_last_MPORT_mask = 1'h1;
  assign ram_echo_real_last_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:19]
  assign io_deq_bits_id = ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_addr = ram_addr_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_echo_real_last = ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  always @(posedge clock) begin
    if (ram_id_MPORT_en & ram_id_MPORT_mask) begin
      ram_id[ram_id_MPORT_addr] <= ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_addr_MPORT_en & ram_addr_MPORT_mask) begin
      ram_addr[ram_addr_MPORT_addr] <= ram_addr_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_echo_real_last_MPORT_en & ram_echo_real_last_MPORT_mask) begin
      ram_echo_real_last[ram_echo_real_last_MPORT_addr] <= ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      enq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_enq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 287:16]
      enq_ptr_value <= enq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      deq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 291:16]
      deq_ptr_value <= deq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      maybe_full <= do_enq; // @[src/main/scala/chisel3/util/Decoupled.scala 295:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_id[initvar] = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_addr[initvar] = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_echo_real_last[initvar] = _RAND_2[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  enq_ptr_value = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  deq_ptr_value = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_69_tb(
  input         clock,
  input         reset,
  output        io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [63:0] io_enq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [7:0]  io_enq_bits_strb, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [63:0] io_deq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [7:0]  io_deq_bits_strb // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_data [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [7:0] ram_strb [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_strb_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_strb_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_strb_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  enq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  deq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 278:33]
  wire  empty = ptr_match & ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:25]
  wire  full = ptr_match & maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 280:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  assign ram_data_io_deq_bits_MPORT_en = 1'h1;
  assign ram_data_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_data_io_deq_bits_MPORT_data = ram_data[ram_data_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_data_MPORT_data = io_enq_bits_data;
  assign ram_data_MPORT_addr = enq_ptr_value;
  assign ram_data_MPORT_mask = 1'h1;
  assign ram_data_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_strb_io_deq_bits_MPORT_en = 1'h1;
  assign ram_strb_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_strb_io_deq_bits_MPORT_data = ram_strb[ram_strb_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_strb_MPORT_data = io_enq_bits_strb;
  assign ram_strb_MPORT_addr = enq_ptr_value;
  assign ram_strb_MPORT_mask = 1'h1;
  assign ram_strb_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:19]
  assign io_deq_bits_data = ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_strb = ram_strb_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  always @(posedge clock) begin
    if (ram_data_MPORT_en & ram_data_MPORT_mask) begin
      ram_data[ram_data_MPORT_addr] <= ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_strb_MPORT_en & ram_strb_MPORT_mask) begin
      ram_strb[ram_strb_MPORT_addr] <= ram_strb_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      enq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_enq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 287:16]
      enq_ptr_value <= enq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      deq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 291:16]
      deq_ptr_value <= deq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      maybe_full <= do_enq; // @[src/main/scala/chisel3/util/Decoupled.scala 295:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_strb[initvar] = _RAND_1[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enq_ptr_value = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  deq_ptr_value = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_70_tb(
  input        clock,
  input        reset,
  output       io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input        io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [3:0] io_enq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [1:0] io_enq_bits_resp, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input        io_enq_bits_echo_real_last, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input        io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output       io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [3:0] io_deq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [1:0] io_deq_bits_resp, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output       io_deq_bits_echo_real_last // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_id [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [1:0] ram_resp [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_resp_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_resp_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  ram_echo_real_last [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  enq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  deq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 278:33]
  wire  empty = ptr_match & ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:25]
  wire  full = ptr_match & maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 280:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  assign ram_id_io_deq_bits_MPORT_en = 1'h1;
  assign ram_id_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_id_io_deq_bits_MPORT_data = ram_id[ram_id_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_id_MPORT_data = io_enq_bits_id;
  assign ram_id_MPORT_addr = enq_ptr_value;
  assign ram_id_MPORT_mask = 1'h1;
  assign ram_id_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_resp_io_deq_bits_MPORT_en = 1'h1;
  assign ram_resp_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_resp_io_deq_bits_MPORT_data = ram_resp[ram_resp_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_resp_MPORT_data = io_enq_bits_resp;
  assign ram_resp_MPORT_addr = enq_ptr_value;
  assign ram_resp_MPORT_mask = 1'h1;
  assign ram_resp_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_echo_real_last_io_deq_bits_MPORT_en = 1'h1;
  assign ram_echo_real_last_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_echo_real_last_io_deq_bits_MPORT_data = ram_echo_real_last[ram_echo_real_last_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_echo_real_last_MPORT_data = io_enq_bits_echo_real_last;
  assign ram_echo_real_last_MPORT_addr = enq_ptr_value;
  assign ram_echo_real_last_MPORT_mask = 1'h1;
  assign ram_echo_real_last_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:19]
  assign io_deq_bits_id = ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_resp = ram_resp_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_echo_real_last = ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  always @(posedge clock) begin
    if (ram_id_MPORT_en & ram_id_MPORT_mask) begin
      ram_id[ram_id_MPORT_addr] <= ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_resp_MPORT_en & ram_resp_MPORT_mask) begin
      ram_resp[ram_resp_MPORT_addr] <= ram_resp_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_echo_real_last_MPORT_en & ram_echo_real_last_MPORT_mask) begin
      ram_echo_real_last[ram_echo_real_last_MPORT_addr] <= ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      enq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_enq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 287:16]
      enq_ptr_value <= enq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      deq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 291:16]
      deq_ptr_value <= deq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      maybe_full <= do_enq; // @[src/main/scala/chisel3/util/Decoupled.scala 295:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_id[initvar] = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_resp[initvar] = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_echo_real_last[initvar] = _RAND_2[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  enq_ptr_value = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  deq_ptr_value = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_72_tb(
  input         clock,
  input         reset,
  output        io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [3:0]  io_enq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [63:0] io_enq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [1:0]  io_enq_bits_resp, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_bits_echo_real_last, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [3:0]  io_deq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [63:0] io_deq_bits_data, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [1:0]  io_deq_bits_resp, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_bits_echo_real_last, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_bits_last // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_id [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [63:0] ram_data [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [63:0] ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_data_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [1:0] ram_resp [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_resp_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_resp_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_resp_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  ram_echo_real_last [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_echo_real_last_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  ram_last [0:1]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_last_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  enq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  deq_ptr_value; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[src/main/scala/chisel3/util/Decoupled.scala 278:33]
  wire  empty = ptr_match & ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:25]
  wire  full = ptr_match & maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 280:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  assign ram_id_io_deq_bits_MPORT_en = 1'h1;
  assign ram_id_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_id_io_deq_bits_MPORT_data = ram_id[ram_id_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_id_MPORT_data = io_enq_bits_id;
  assign ram_id_MPORT_addr = enq_ptr_value;
  assign ram_id_MPORT_mask = 1'h1;
  assign ram_id_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_data_io_deq_bits_MPORT_en = 1'h1;
  assign ram_data_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_data_io_deq_bits_MPORT_data = ram_data[ram_data_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_data_MPORT_data = io_enq_bits_data;
  assign ram_data_MPORT_addr = enq_ptr_value;
  assign ram_data_MPORT_mask = 1'h1;
  assign ram_data_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_resp_io_deq_bits_MPORT_en = 1'h1;
  assign ram_resp_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_resp_io_deq_bits_MPORT_data = ram_resp[ram_resp_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_resp_MPORT_data = io_enq_bits_resp;
  assign ram_resp_MPORT_addr = enq_ptr_value;
  assign ram_resp_MPORT_mask = 1'h1;
  assign ram_resp_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_echo_real_last_io_deq_bits_MPORT_en = 1'h1;
  assign ram_echo_real_last_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_echo_real_last_io_deq_bits_MPORT_data = ram_echo_real_last[ram_echo_real_last_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_echo_real_last_MPORT_data = io_enq_bits_echo_real_last;
  assign ram_echo_real_last_MPORT_addr = enq_ptr_value;
  assign ram_echo_real_last_MPORT_mask = 1'h1;
  assign ram_echo_real_last_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_last_io_deq_bits_MPORT_en = 1'h1;
  assign ram_last_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_last_io_deq_bits_MPORT_data = ram_last[ram_last_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_last_MPORT_data = 1'h1;
  assign ram_last_MPORT_addr = enq_ptr_value;
  assign ram_last_MPORT_mask = 1'h1;
  assign ram_last_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:19]
  assign io_deq_bits_id = ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_data = ram_data_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_resp = ram_resp_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_echo_real_last = ram_echo_real_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  assign io_deq_bits_last = ram_last_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17]
  always @(posedge clock) begin
    if (ram_id_MPORT_en & ram_id_MPORT_mask) begin
      ram_id[ram_id_MPORT_addr] <= ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_data_MPORT_en & ram_data_MPORT_mask) begin
      ram_data[ram_data_MPORT_addr] <= ram_data_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_resp_MPORT_en & ram_resp_MPORT_mask) begin
      ram_resp[ram_resp_MPORT_addr] <= ram_resp_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_echo_real_last_MPORT_en & ram_echo_real_last_MPORT_mask) begin
      ram_echo_real_last[ram_echo_real_last_MPORT_addr] <= ram_echo_real_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_last_MPORT_en & ram_last_MPORT_mask) begin
      ram_last[ram_last_MPORT_addr] <= ram_last_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      enq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_enq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 287:16]
      enq_ptr_value <= enq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      deq_ptr_value <= 1'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 291:16]
      deq_ptr_value <= deq_ptr_value + 1'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      maybe_full <= do_enq; // @[src/main/scala/chisel3/util/Decoupled.scala 295:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_id[initvar] = _RAND_0[3:0];
  _RAND_1 = {2{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_resp[initvar] = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_echo_real_last[initvar] = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_last[initvar] = _RAND_4[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  enq_ptr_value = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  deq_ptr_value = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  maybe_full = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4Buffer_tb(
  input         clock,
  input         reset,
  output        auto_in_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_in_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_in_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_aw_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_out_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [7:0]  auto_out_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_b_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_ar_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_out_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_bits_echo_real_last // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
);
  wire  nodeOut_aw_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeOut_aw_deq_q_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] nodeOut_aw_deq_q_io_enq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_enq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeOut_aw_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] nodeOut_aw_deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_aw_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] nodeOut_w_deq_q_io_enq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] nodeOut_w_deq_q_io_enq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_w_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] nodeOut_w_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] nodeOut_w_deq_q_io_deq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeIn_b_deq_q_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] nodeIn_b_deq_q_io_enq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_enq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeIn_b_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] nodeIn_b_deq_q_io_deq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_b_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeOut_ar_deq_q_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] nodeOut_ar_deq_q_io_enq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_enq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeOut_ar_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] nodeOut_ar_deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeOut_ar_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeIn_r_deq_q_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] nodeIn_r_deq_q_io_enq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] nodeIn_r_deq_q_io_enq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_enq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] nodeIn_r_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] nodeIn_r_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] nodeIn_r_deq_q_io_deq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  nodeIn_r_deq_q_io_deq_bits_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  Queue_68_tb nodeOut_aw_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(nodeOut_aw_deq_q_clock),
    .reset(nodeOut_aw_deq_q_reset),
    .io_enq_ready(nodeOut_aw_deq_q_io_enq_ready),
    .io_enq_valid(nodeOut_aw_deq_q_io_enq_valid),
    .io_enq_bits_id(nodeOut_aw_deq_q_io_enq_bits_id),
    .io_enq_bits_addr(nodeOut_aw_deq_q_io_enq_bits_addr),
    .io_enq_bits_echo_real_last(nodeOut_aw_deq_q_io_enq_bits_echo_real_last),
    .io_deq_ready(nodeOut_aw_deq_q_io_deq_ready),
    .io_deq_valid(nodeOut_aw_deq_q_io_deq_valid),
    .io_deq_bits_id(nodeOut_aw_deq_q_io_deq_bits_id),
    .io_deq_bits_addr(nodeOut_aw_deq_q_io_deq_bits_addr),
    .io_deq_bits_echo_real_last(nodeOut_aw_deq_q_io_deq_bits_echo_real_last)
  );
  Queue_69_tb nodeOut_w_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(nodeOut_w_deq_q_clock),
    .reset(nodeOut_w_deq_q_reset),
    .io_enq_ready(nodeOut_w_deq_q_io_enq_ready),
    .io_enq_valid(nodeOut_w_deq_q_io_enq_valid),
    .io_enq_bits_data(nodeOut_w_deq_q_io_enq_bits_data),
    .io_enq_bits_strb(nodeOut_w_deq_q_io_enq_bits_strb),
    .io_deq_ready(nodeOut_w_deq_q_io_deq_ready),
    .io_deq_valid(nodeOut_w_deq_q_io_deq_valid),
    .io_deq_bits_data(nodeOut_w_deq_q_io_deq_bits_data),
    .io_deq_bits_strb(nodeOut_w_deq_q_io_deq_bits_strb)
  );
  Queue_70_tb nodeIn_b_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(nodeIn_b_deq_q_clock),
    .reset(nodeIn_b_deq_q_reset),
    .io_enq_ready(nodeIn_b_deq_q_io_enq_ready),
    .io_enq_valid(nodeIn_b_deq_q_io_enq_valid),
    .io_enq_bits_id(nodeIn_b_deq_q_io_enq_bits_id),
    .io_enq_bits_resp(nodeIn_b_deq_q_io_enq_bits_resp),
    .io_enq_bits_echo_real_last(nodeIn_b_deq_q_io_enq_bits_echo_real_last),
    .io_deq_ready(nodeIn_b_deq_q_io_deq_ready),
    .io_deq_valid(nodeIn_b_deq_q_io_deq_valid),
    .io_deq_bits_id(nodeIn_b_deq_q_io_deq_bits_id),
    .io_deq_bits_resp(nodeIn_b_deq_q_io_deq_bits_resp),
    .io_deq_bits_echo_real_last(nodeIn_b_deq_q_io_deq_bits_echo_real_last)
  );
  Queue_68_tb nodeOut_ar_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(nodeOut_ar_deq_q_clock),
    .reset(nodeOut_ar_deq_q_reset),
    .io_enq_ready(nodeOut_ar_deq_q_io_enq_ready),
    .io_enq_valid(nodeOut_ar_deq_q_io_enq_valid),
    .io_enq_bits_id(nodeOut_ar_deq_q_io_enq_bits_id),
    .io_enq_bits_addr(nodeOut_ar_deq_q_io_enq_bits_addr),
    .io_enq_bits_echo_real_last(nodeOut_ar_deq_q_io_enq_bits_echo_real_last),
    .io_deq_ready(nodeOut_ar_deq_q_io_deq_ready),
    .io_deq_valid(nodeOut_ar_deq_q_io_deq_valid),
    .io_deq_bits_id(nodeOut_ar_deq_q_io_deq_bits_id),
    .io_deq_bits_addr(nodeOut_ar_deq_q_io_deq_bits_addr),
    .io_deq_bits_echo_real_last(nodeOut_ar_deq_q_io_deq_bits_echo_real_last)
  );
  Queue_72_tb nodeIn_r_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(nodeIn_r_deq_q_clock),
    .reset(nodeIn_r_deq_q_reset),
    .io_enq_ready(nodeIn_r_deq_q_io_enq_ready),
    .io_enq_valid(nodeIn_r_deq_q_io_enq_valid),
    .io_enq_bits_id(nodeIn_r_deq_q_io_enq_bits_id),
    .io_enq_bits_data(nodeIn_r_deq_q_io_enq_bits_data),
    .io_enq_bits_resp(nodeIn_r_deq_q_io_enq_bits_resp),
    .io_enq_bits_echo_real_last(nodeIn_r_deq_q_io_enq_bits_echo_real_last),
    .io_deq_ready(nodeIn_r_deq_q_io_deq_ready),
    .io_deq_valid(nodeIn_r_deq_q_io_deq_valid),
    .io_deq_bits_id(nodeIn_r_deq_q_io_deq_bits_id),
    .io_deq_bits_data(nodeIn_r_deq_q_io_deq_bits_data),
    .io_deq_bits_resp(nodeIn_r_deq_q_io_deq_bits_resp),
    .io_deq_bits_echo_real_last(nodeIn_r_deq_q_io_deq_bits_echo_real_last),
    .io_deq_bits_last(nodeIn_r_deq_q_io_deq_bits_last)
  );
  assign auto_in_aw_ready = nodeOut_aw_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_w_ready = nodeOut_w_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_b_valid = nodeIn_b_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_in_b_bits_id = nodeIn_b_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_b_bits_resp = nodeIn_b_deq_q_io_deq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_b_bits_echo_real_last = nodeIn_b_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_ar_ready = nodeOut_ar_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_r_valid = nodeIn_r_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_in_r_bits_id = nodeIn_r_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_r_bits_data = nodeIn_r_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_r_bits_resp = nodeIn_r_deq_q_io_deq_bits_resp; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_r_bits_echo_real_last = nodeIn_r_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_in_r_bits_last = nodeIn_r_deq_q_io_deq_bits_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_aw_valid = nodeOut_aw_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_out_aw_bits_id = nodeOut_aw_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_aw_bits_addr = nodeOut_aw_deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_aw_bits_echo_real_last = nodeOut_aw_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_w_valid = nodeOut_w_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_out_w_bits_data = nodeOut_w_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_w_bits_strb = nodeOut_w_deq_q_io_deq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_b_ready = nodeIn_b_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_out_ar_valid = nodeOut_ar_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_out_ar_bits_id = nodeOut_ar_deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_ar_bits_addr = nodeOut_ar_deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_ar_bits_echo_real_last = nodeOut_ar_deq_q_io_deq_bits_echo_real_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_r_ready = nodeIn_r_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign nodeOut_aw_deq_q_clock = clock;
  assign nodeOut_aw_deq_q_reset = reset;
  assign nodeOut_aw_deq_q_io_enq_valid = auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_aw_deq_q_io_enq_bits_id = auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_aw_deq_q_io_enq_bits_addr = auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_aw_deq_q_io_enq_bits_echo_real_last = auto_in_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_aw_deq_q_io_deq_ready = auto_out_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeOut_w_deq_q_clock = clock;
  assign nodeOut_w_deq_q_reset = reset;
  assign nodeOut_w_deq_q_io_enq_valid = auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_w_deq_q_io_enq_bits_data = auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_w_deq_q_io_enq_bits_strb = auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_w_deq_q_io_deq_ready = auto_out_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_b_deq_q_clock = clock;
  assign nodeIn_b_deq_q_reset = reset;
  assign nodeIn_b_deq_q_io_enq_valid = auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_b_deq_q_io_enq_bits_id = auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_b_deq_q_io_enq_bits_resp = auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_b_deq_q_io_enq_bits_echo_real_last = auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_b_deq_q_io_deq_ready = auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_ar_deq_q_clock = clock;
  assign nodeOut_ar_deq_q_reset = reset;
  assign nodeOut_ar_deq_q_io_enq_valid = auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_ar_deq_q_io_enq_bits_id = auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_ar_deq_q_io_enq_bits_addr = auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_ar_deq_q_io_enq_bits_echo_real_last = auto_in_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign nodeOut_ar_deq_q_io_deq_ready = auto_out_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_clock = clock;
  assign nodeIn_r_deq_q_reset = reset;
  assign nodeIn_r_deq_q_io_enq_valid = auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_io_enq_bits_id = auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_io_enq_bits_data = auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_io_enq_bits_resp = auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_io_enq_bits_echo_real_last = auto_out_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign nodeIn_r_deq_q_io_deq_ready = auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
endmodule
module Queue_73_tb(
  input         clock,
  input         reset,
  output        io_enq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_enq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [3:0]  io_enq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [31:0] io_enq_bits_addr, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [7:0]  io_enq_bits_len, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [2:0]  io_enq_bits_size, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input  [1:0]  io_enq_bits_burst, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  input         io_deq_ready, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output        io_deq_valid, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [3:0]  io_deq_bits_id, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [31:0] io_deq_bits_addr, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [7:0]  io_deq_bits_len, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [2:0]  io_deq_bits_size, // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
  output [1:0]  io_deq_bits_burst // @[src/main/scala/chisel3/util/Decoupled.scala 273:14]
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] ram_id [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [3:0] ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_id_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [31:0] ram_addr [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [31:0] ram_addr_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [31:0] ram_addr_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_addr_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [7:0] ram_len [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_len_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_len_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_len_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [7:0] ram_len_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_len_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_len_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_len_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [2:0] ram_size [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_size_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_size_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [2:0] ram_size_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [2:0] ram_size_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_size_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_size_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_size_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg [1:0] ram_burst [0:0]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_burst_io_deq_bits_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_burst_io_deq_bits_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_burst_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire [1:0] ram_burst_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_burst_MPORT_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_burst_MPORT_mask; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  wire  ram_burst_MPORT_en; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  reg  maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
  wire  empty = ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 279:28]
  wire  _do_enq_T = io_enq_ready & io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _do_deq_T = io_deq_ready & io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire  _GEN_17 = io_deq_ready ? 1'h0 : _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 319:26 281:27 319:35]
  wire  do_enq = empty ? _GEN_17 : _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 316:17 281:27]
  wire  do_deq = empty ? 1'h0 : _do_deq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 316:17 318:14 282:27]
  assign ram_id_io_deq_bits_MPORT_en = 1'h1;
  assign ram_id_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_id_io_deq_bits_MPORT_data = ram_id[ram_id_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_id_MPORT_data = io_enq_bits_id;
  assign ram_id_MPORT_addr = 1'h0;
  assign ram_id_MPORT_mask = 1'h1;
  assign ram_id_MPORT_en = empty ? _GEN_17 : _do_enq_T;
  assign ram_addr_io_deq_bits_MPORT_en = 1'h1;
  assign ram_addr_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_addr_io_deq_bits_MPORT_data = ram_addr[ram_addr_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_addr_MPORT_data = io_enq_bits_addr;
  assign ram_addr_MPORT_addr = 1'h0;
  assign ram_addr_MPORT_mask = 1'h1;
  assign ram_addr_MPORT_en = empty ? _GEN_17 : _do_enq_T;
  assign ram_len_io_deq_bits_MPORT_en = 1'h1;
  assign ram_len_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_len_io_deq_bits_MPORT_data = ram_len[ram_len_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_len_MPORT_data = io_enq_bits_len;
  assign ram_len_MPORT_addr = 1'h0;
  assign ram_len_MPORT_mask = 1'h1;
  assign ram_len_MPORT_en = empty ? _GEN_17 : _do_enq_T;
  assign ram_size_io_deq_bits_MPORT_en = 1'h1;
  assign ram_size_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_size_io_deq_bits_MPORT_data = ram_size[ram_size_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_size_MPORT_data = io_enq_bits_size;
  assign ram_size_MPORT_addr = 1'h0;
  assign ram_size_MPORT_mask = 1'h1;
  assign ram_size_MPORT_en = empty ? _GEN_17 : _do_enq_T;
  assign ram_burst_io_deq_bits_MPORT_en = 1'h1;
  assign ram_burst_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_burst_io_deq_bits_MPORT_data = ram_burst[ram_burst_io_deq_bits_MPORT_addr]; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
  assign ram_burst_MPORT_data = io_enq_bits_burst;
  assign ram_burst_MPORT_addr = 1'h0;
  assign ram_burst_MPORT_mask = 1'h1;
  assign ram_burst_MPORT_en = empty ? _GEN_17 : _do_enq_T;
  assign io_enq_ready = ~maybe_full; // @[src/main/scala/chisel3/util/Decoupled.scala 304:19]
  assign io_deq_valid = io_enq_valid | ~empty; // @[src/main/scala/chisel3/util/Decoupled.scala 303:16 315:{24,39}]
  assign io_deq_bits_id = empty ? io_enq_bits_id : ram_id_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_addr = empty ? io_enq_bits_addr : ram_addr_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_len = empty ? io_enq_bits_len : ram_len_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_size = empty ? io_enq_bits_size : ram_size_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  assign io_deq_bits_burst = empty ? io_enq_bits_burst : ram_burst_io_deq_bits_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 311:17 316:17 317:19]
  always @(posedge clock) begin
    if (ram_id_MPORT_en & ram_id_MPORT_mask) begin
      ram_id[ram_id_MPORT_addr] <= ram_id_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_addr_MPORT_en & ram_addr_MPORT_mask) begin
      ram_addr[ram_addr_MPORT_addr] <= ram_addr_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_len_MPORT_en & ram_len_MPORT_mask) begin
      ram_len[ram_len_MPORT_addr] <= ram_len_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_size_MPORT_en & ram_size_MPORT_mask) begin
      ram_size[ram_size_MPORT_addr] <= ram_size_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (ram_burst_MPORT_en & ram_burst_MPORT_mask) begin
      ram_burst[ram_burst_MPORT_addr] <= ram_burst_MPORT_data; // @[src/main/scala/chisel3/util/Decoupled.scala 274:95]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
      maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 277:27]
    end else if (do_enq != do_deq) begin // @[src/main/scala/chisel3/util/Decoupled.scala 294:27]
      if (empty) begin // @[src/main/scala/chisel3/util/Decoupled.scala 316:17]
        if (io_deq_ready) begin // @[src/main/scala/chisel3/util/Decoupled.scala 319:26]
          maybe_full <= 1'h0; // @[src/main/scala/chisel3/util/Decoupled.scala 319:35]
        end else begin
          maybe_full <= _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 281:27]
        end
      end else begin
        maybe_full <= _do_enq_T; // @[src/main/scala/chisel3/util/Decoupled.scala 281:27]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_id[initvar] = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_addr[initvar] = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_len[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_size[initvar] = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_burst[initvar] = _RAND_4[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module AXI4Fragmenter_1_tb(
  input         clock,
  input         reset,
  output        auto_in_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_aw_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [2:0]  auto_in_aw_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_in_aw_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_in_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_w_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_in_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [31:0] auto_in_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [7:0]  auto_in_ar_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [2:0]  auto_in_ar_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_in_ar_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_in_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_in_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_in_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [1:0]  auto_in_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_in_r_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_aw_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [63:0] auto_out_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [7:0]  auto_out_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_b_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [3:0]  auto_out_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output [31:0] auto_out_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_ar_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  output        auto_out_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [3:0]  auto_out_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [63:0] auto_out_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input  [1:0]  auto_out_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_bits_echo_real_last, // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
  input         auto_out_r_bits_last // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 367:18]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
`endif // RANDOMIZE_REG_INIT
  wire  deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] deq_q_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] deq_q_io_enq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] deq_q_io_enq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [2:0] deq_q_io_enq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] deq_q_io_enq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] deq_q_io_deq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [2:0] deq_q_io_deq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] deq_q_io_deq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] deq_q_1_io_enq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] deq_q_1_io_enq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] deq_q_1_io_enq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [2:0] deq_q_1_io_enq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] deq_q_1_io_enq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  deq_q_1_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [3:0] deq_q_1_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [31:0] deq_q_1_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] deq_q_1_io_deq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [2:0] deq_q_1_io_deq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [1:0] deq_q_1_io_deq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_clock; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_reset; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_enq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_enq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] in_w_deq_q_io_enq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] in_w_deq_q_io_enq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_enq_bits_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_deq_ready; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [63:0] in_w_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire [7:0] in_w_deq_q_io_deq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  wire  in_w_deq_q_io_deq_bits_last; // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
  reg  busy; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
  reg [31:0] r_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 65:25]
  reg [7:0] r_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 66:25]
  wire [7:0] irr_bits_len = deq_q_io_deq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [7:0] len = busy ? r_len : irr_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 68:23]
  wire [31:0] irr_bits_addr = deq_q_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [31:0] addr = busy ? r_addr : irr_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 69:23]
  wire [1:0] irr_bits_burst = deq_q_io_deq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire  fixed = irr_bits_burst == 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 96:34]
  wire [2:0] irr_bits_size = deq_q_io_deq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [15:0] _inc_addr_T = 16'h1 << irr_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:38]
  wire [31:0] _GEN_48 = {{16'd0}, _inc_addr_T}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:29]
  wire [31:0] inc_addr = addr + _GEN_48; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:29]
  wire [15:0] _wrapMask_T = {irr_bits_len,8'hff}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:9]
  wire [22:0] _GEN_63 = {{7'd0}, _wrapMask_T}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:21]
  wire [22:0] _wrapMask_T_1 = _GEN_63 << irr_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:21]
  wire [14:0] wrapMask = _wrapMask_T_1[22:8]; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:30]
  wire [31:0] _GEN_49 = {{17'd0}, wrapMask}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:33]
  wire [31:0] _mux_addr_T = inc_addr & _GEN_49; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:33]
  wire [31:0] _mux_addr_T_1 = ~irr_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:49]
  wire [31:0] _mux_addr_T_2 = _mux_addr_T_1 | _GEN_49; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:62]
  wire [31:0] _mux_addr_T_3 = ~_mux_addr_T_2; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:47]
  wire [31:0] _mux_addr_T_4 = _mux_addr_T | _mux_addr_T_3; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:45]
  wire  ar_last = 8'h0 == len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 114:27]
  wire [31:0] _out_bits_addr_T = ~addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:28]
  wire [9:0] _out_bits_addr_T_2 = 10'h7 << irr_bits_size; // @[repo/rocket-chip/src/main/scala/util/package.scala 235:71]
  wire [2:0] _out_bits_addr_T_4 = ~_out_bits_addr_T_2[2:0]; // @[repo/rocket-chip/src/main/scala/util/package.scala 235:46]
  wire [31:0] _GEN_51 = {{29'd0}, _out_bits_addr_T_4}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:34]
  wire [31:0] _out_bits_addr_T_5 = _out_bits_addr_T | _GEN_51; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:34]
  wire  irr_valid = deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  wire  _T_2 = auto_out_ar_ready & irr_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire [8:0] _GEN_52 = {{1'd0}, len}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 131:25]
  wire [8:0] _r_len_T_1 = _GEN_52 - 9'h1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 131:25]
  wire [8:0] _GEN_4 = _T_2 ? _r_len_T_1 : {{1'd0}, r_len}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25 131:18 66:25]
  reg  busy_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
  reg [31:0] r_addr_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 65:25]
  reg [7:0] r_len_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 66:25]
  wire [7:0] irr_1_bits_len = deq_q_1_io_deq_bits_len; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [7:0] len_1 = busy_1 ? r_len_1 : irr_1_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 68:23]
  wire [31:0] irr_1_bits_addr = deq_q_1_io_deq_bits_addr; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [31:0] addr_1 = busy_1 ? r_addr_1 : irr_1_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 69:23]
  wire [1:0] irr_1_bits_burst = deq_q_1_io_deq_bits_burst; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire  fixed_1 = irr_1_bits_burst == 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 96:34]
  wire [2:0] irr_1_bits_size = deq_q_1_io_deq_bits_size; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire [15:0] _inc_addr_T_2 = 16'h1 << irr_1_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:38]
  wire [31:0] _GEN_57 = {{16'd0}, _inc_addr_T_2}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:29]
  wire [31:0] inc_addr_1 = addr_1 + _GEN_57; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 104:29]
  wire [15:0] _wrapMask_T_2 = {irr_1_bits_len,8'hff}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:9]
  wire [22:0] _GEN_64 = {{7'd0}, _wrapMask_T_2}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:21]
  wire [22:0] _wrapMask_T_3 = _GEN_64 << irr_1_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:21]
  wire [14:0] wrapMask_1 = _wrapMask_T_3[22:8]; // @[repo/rocket-chip/src/main/scala/amba/axi4/Bundles.scala 33:30]
  wire [31:0] _GEN_58 = {{17'd0}, wrapMask_1}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:33]
  wire [31:0] _mux_addr_T_5 = inc_addr_1 & _GEN_58; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:33]
  wire [31:0] _mux_addr_T_6 = ~irr_1_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:49]
  wire [31:0] _mux_addr_T_7 = _mux_addr_T_6 | _GEN_58; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:62]
  wire [31:0] _mux_addr_T_8 = ~_mux_addr_T_7; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:47]
  wire [31:0] _mux_addr_T_9 = _mux_addr_T_5 | _mux_addr_T_8; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:45]
  wire  aw_last = 8'h0 == len_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 114:27]
  reg [8:0] w_counter; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 172:30]
  wire  w_idle = w_counter == 9'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 173:30]
  reg  wbeats_latched; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 156:35]
  wire  _in_aw_ready_T = w_idle | wbeats_latched; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 164:52]
  wire  in_aw_ready = auto_out_aw_ready & (w_idle | wbeats_latched); // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 164:35]
  wire [31:0] _out_bits_addr_T_7 = ~addr_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:28]
  wire [9:0] _out_bits_addr_T_9 = 10'h7 << irr_1_bits_size; // @[repo/rocket-chip/src/main/scala/util/package.scala 235:71]
  wire [2:0] _out_bits_addr_T_11 = ~_out_bits_addr_T_9[2:0]; // @[repo/rocket-chip/src/main/scala/util/package.scala 235:46]
  wire [31:0] _GEN_60 = {{29'd0}, _out_bits_addr_T_11}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:34]
  wire [31:0] _out_bits_addr_T_12 = _out_bits_addr_T_7 | _GEN_60; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:34]
  wire  irr_1_valid = deq_q_1_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  wire  _T_5 = in_aw_ready & irr_1_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire [8:0] _GEN_61 = {{1'd0}, len_1}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 131:25]
  wire [8:0] _r_len_T_3 = _GEN_61 - 9'h1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 131:25]
  wire [8:0] _GEN_9 = _T_5 ? _r_len_T_3 : {{1'd0}, r_len_1}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25 131:18 66:25]
  wire  wbeats_valid = irr_1_valid & ~wbeats_latched; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 165:35]
  wire  _GEN_10 = wbeats_valid & w_idle | wbeats_latched; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 156:35 159:{43,60}]
  wire  nodeOut_aw_valid = irr_1_valid & _in_aw_ready_T; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 163:35]
  wire  _T_7 = auto_out_aw_ready & nodeOut_aw_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire [8:0] _w_todo_T = wbeats_valid ? 9'h1 : 9'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 174:35]
  wire [8:0] w_todo = w_idle ? _w_todo_T : w_counter; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 174:23]
  wire  w_last = w_todo == 9'h1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 175:27]
  wire  in_w_valid = in_w_deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  wire  _nodeOut_w_valid_T_1 = ~w_idle | wbeats_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 181:51]
  wire  nodeOut_w_valid = in_w_valid & (~w_idle | wbeats_valid); // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 181:33]
  wire  _w_counter_T = auto_out_w_ready & nodeOut_w_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire [8:0] _GEN_62 = {{8'd0}, _w_counter_T}; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 176:27]
  wire [8:0] _w_counter_T_2 = w_todo - _GEN_62; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 176:27]
  wire  _T_13 = ~reset; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 177:14]
  wire  in_w_bits_last = in_w_deq_q_io_deq_bits_last; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  wire  nodeOut_b_ready = auto_in_b_ready | ~auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 204:33]
  reg [1:0] error_0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_2; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_3; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_4; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_5; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_6; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_7; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_8; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_9; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_10; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_11; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_12; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_13; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_14; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  reg [1:0] error_15; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
  wire [1:0] _GEN_13 = 4'h1 == auto_out_b_bits_id ? error_1 : error_0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_14 = 4'h2 == auto_out_b_bits_id ? error_2 : _GEN_13; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_15 = 4'h3 == auto_out_b_bits_id ? error_3 : _GEN_14; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_16 = 4'h4 == auto_out_b_bits_id ? error_4 : _GEN_15; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_17 = 4'h5 == auto_out_b_bits_id ? error_5 : _GEN_16; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_18 = 4'h6 == auto_out_b_bits_id ? error_6 : _GEN_17; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_19 = 4'h7 == auto_out_b_bits_id ? error_7 : _GEN_18; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_20 = 4'h8 == auto_out_b_bits_id ? error_8 : _GEN_19; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_21 = 4'h9 == auto_out_b_bits_id ? error_9 : _GEN_20; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_22 = 4'ha == auto_out_b_bits_id ? error_10 : _GEN_21; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_23 = 4'hb == auto_out_b_bits_id ? error_11 : _GEN_22; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_24 = 4'hc == auto_out_b_bits_id ? error_12 : _GEN_23; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_25 = 4'hd == auto_out_b_bits_id ? error_13 : _GEN_24; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_26 = 4'he == auto_out_b_bits_id ? error_14 : _GEN_25; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [1:0] _GEN_27 = 4'hf == auto_out_b_bits_id ? error_15 : _GEN_26; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:{41,41}]
  wire [15:0] _T_22 = 16'h1 << auto_out_b_bits_id; // @[src/main/scala/chisel3/util/OneHot.scala 65:12]
  wire  _T_40 = nodeOut_b_ready & auto_out_b_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 52:35]
  wire [1:0] _error_0_T = error_0 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_1_T = error_1 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_2_T = error_2 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_3_T = error_3 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_4_T = error_4 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_5_T = error_5 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_6_T = error_6 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_7_T = error_7 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_8_T = error_8 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_9_T = error_9 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_10_T = error_10 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_11_T = error_11 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_12_T = error_12 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_13_T = error_13 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_14_T = error_14 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  wire [1:0] _error_15_T = error_15 | auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:64]
  Queue_73_tb deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(deq_q_clock),
    .reset(deq_q_reset),
    .io_enq_ready(deq_q_io_enq_ready),
    .io_enq_valid(deq_q_io_enq_valid),
    .io_enq_bits_id(deq_q_io_enq_bits_id),
    .io_enq_bits_addr(deq_q_io_enq_bits_addr),
    .io_enq_bits_len(deq_q_io_enq_bits_len),
    .io_enq_bits_size(deq_q_io_enq_bits_size),
    .io_enq_bits_burst(deq_q_io_enq_bits_burst),
    .io_deq_ready(deq_q_io_deq_ready),
    .io_deq_valid(deq_q_io_deq_valid),
    .io_deq_bits_id(deq_q_io_deq_bits_id),
    .io_deq_bits_addr(deq_q_io_deq_bits_addr),
    .io_deq_bits_len(deq_q_io_deq_bits_len),
    .io_deq_bits_size(deq_q_io_deq_bits_size),
    .io_deq_bits_burst(deq_q_io_deq_bits_burst)
  );
  Queue_73_tb deq_q_1 ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(deq_q_1_clock),
    .reset(deq_q_1_reset),
    .io_enq_ready(deq_q_1_io_enq_ready),
    .io_enq_valid(deq_q_1_io_enq_valid),
    .io_enq_bits_id(deq_q_1_io_enq_bits_id),
    .io_enq_bits_addr(deq_q_1_io_enq_bits_addr),
    .io_enq_bits_len(deq_q_1_io_enq_bits_len),
    .io_enq_bits_size(deq_q_1_io_enq_bits_size),
    .io_enq_bits_burst(deq_q_1_io_enq_bits_burst),
    .io_deq_ready(deq_q_1_io_deq_ready),
    .io_deq_valid(deq_q_1_io_deq_valid),
    .io_deq_bits_id(deq_q_1_io_deq_bits_id),
    .io_deq_bits_addr(deq_q_1_io_deq_bits_addr),
    .io_deq_bits_len(deq_q_1_io_deq_bits_len),
    .io_deq_bits_size(deq_q_1_io_deq_bits_size),
    .io_deq_bits_burst(deq_q_1_io_deq_bits_burst)
  );
  Queue_12_tb in_w_deq_q ( // @[src/main/scala/chisel3/util/Decoupled.scala 376:21]
    .clock(in_w_deq_q_clock),
    .reset(in_w_deq_q_reset),
    .io_enq_ready(in_w_deq_q_io_enq_ready),
    .io_enq_valid(in_w_deq_q_io_enq_valid),
    .io_enq_bits_data(in_w_deq_q_io_enq_bits_data),
    .io_enq_bits_strb(in_w_deq_q_io_enq_bits_strb),
    .io_enq_bits_last(in_w_deq_q_io_enq_bits_last),
    .io_deq_ready(in_w_deq_q_io_deq_ready),
    .io_deq_valid(in_w_deq_q_io_deq_valid),
    .io_deq_bits_data(in_w_deq_q_io_deq_bits_data),
    .io_deq_bits_strb(in_w_deq_q_io_deq_bits_strb),
    .io_deq_bits_last(in_w_deq_q_io_deq_bits_last)
  );
  assign auto_in_aw_ready = deq_q_1_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_w_ready = in_w_deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_b_valid = auto_out_b_valid & auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 203:33]
  assign auto_in_b_bits_id = auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_b_bits_resp = auto_out_b_bits_resp | _GEN_27; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 208:41]
  assign auto_in_ar_ready = deq_q_io_enq_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 src/main/scala/chisel3/util/Decoupled.scala 380:17]
  assign auto_in_r_valid = auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_id = auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_data = auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_resp = auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 373:12]
  assign auto_in_r_bits_last = auto_out_r_bits_last & auto_out_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 194:41]
  assign auto_out_aw_valid = irr_1_valid & _in_aw_ready_T; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 163:35]
  assign auto_out_aw_bits_id = deq_q_1_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_aw_bits_addr = ~_out_bits_addr_T_12; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:26]
  assign auto_out_aw_bits_echo_real_last = 8'h0 == len_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 114:27]
  assign auto_out_w_valid = in_w_valid & (~w_idle | wbeats_valid); // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 181:33]
  assign auto_out_w_bits_data = in_w_deq_q_io_deq_bits_data; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_w_bits_strb = in_w_deq_q_io_deq_bits_strb; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_b_ready = auto_in_b_ready | ~auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 204:33]
  assign auto_out_ar_valid = deq_q_io_deq_valid; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 417:15]
  assign auto_out_ar_bits_id = deq_q_io_deq_bits_id; // @[src/main/scala/chisel3/util/Decoupled.scala 415:19 416:14]
  assign auto_out_ar_bits_addr = ~_out_bits_addr_T_5; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 126:26]
  assign auto_out_ar_bits_echo_real_last = 8'h0 == len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 114:27]
  assign auto_out_r_ready = auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_clock = clock;
  assign deq_q_reset = reset;
  assign deq_q_io_enq_valid = auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_enq_bits_id = auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_enq_bits_addr = auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_enq_bits_len = auto_in_ar_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_enq_bits_size = auto_in_ar_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_enq_bits_burst = auto_in_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_io_deq_ready = auto_out_ar_ready & ar_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 115:30]
  assign deq_q_1_clock = clock;
  assign deq_q_1_reset = reset;
  assign deq_q_1_io_enq_valid = auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_enq_bits_id = auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_enq_bits_addr = auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_enq_bits_len = auto_in_aw_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_enq_bits_size = auto_in_aw_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_enq_bits_burst = auto_in_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign deq_q_1_io_deq_ready = in_aw_ready & aw_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 115:30]
  assign in_w_deq_q_clock = clock;
  assign in_w_deq_q_reset = reset;
  assign in_w_deq_q_io_enq_valid = auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign in_w_deq_q_io_enq_bits_data = auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign in_w_deq_q_io_enq_bits_strb = auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign in_w_deq_q_io_enq_bits_last = auto_in_w_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1214:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 371:16]
  assign in_w_deq_q_io_deq_ready = auto_out_w_ready & _nodeOut_w_valid_T_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 182:33]
  always @(posedge clock) begin
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
      busy <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
    end else if (_T_2) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25]
      busy <= ~ar_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 129:16]
    end
    if (_T_2) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25]
      if (fixed) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 110:60]
        r_addr <= irr_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 111:20]
      end else if (irr_bits_burst == 2'h2) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 107:59]
        r_addr <= _mux_addr_T_4; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:20]
      end else begin
        r_addr <= inc_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 106:35]
      end
    end
    r_len <= _GEN_4[7:0];
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
      busy_1 <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 64:29]
    end else if (_T_5) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25]
      busy_1 <= ~aw_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 129:16]
    end
    if (_T_5) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 128:25]
      if (fixed_1) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 110:60]
        r_addr_1 <= irr_1_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 111:20]
      end else if (irr_1_bits_burst == 2'h2) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 107:59]
        r_addr_1 <= _mux_addr_T_9; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 108:20]
      end else begin
        r_addr_1 <= inc_addr_1; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 106:35]
      end
    end
    r_len_1 <= _GEN_9[7:0];
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 172:30]
      w_counter <= 9'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 172:30]
    end else begin
      w_counter <= _w_counter_T_2; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 176:17]
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 156:35]
      wbeats_latched <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 156:35]
    end else if (_T_7) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 160:26]
      wbeats_latched <= 1'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 160:43]
    end else begin
      wbeats_latched <= _GEN_10;
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_0 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[0] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_0 <= 2'h0;
      end else begin
        error_0 <= _error_0_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_1 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[1] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_1 <= 2'h0;
      end else begin
        error_1 <= _error_1_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_2 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[2] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_2 <= 2'h0;
      end else begin
        error_2 <= _error_2_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_3 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[3] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_3 <= 2'h0;
      end else begin
        error_3 <= _error_3_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_4 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[4] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_4 <= 2'h0;
      end else begin
        error_4 <= _error_4_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_5 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[5] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_5 <= 2'h0;
      end else begin
        error_5 <= _error_5_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_6 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[6] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_6 <= 2'h0;
      end else begin
        error_6 <= _error_6_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_7 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[7] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_7 <= 2'h0;
      end else begin
        error_7 <= _error_7_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_8 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[8] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_8 <= 2'h0;
      end else begin
        error_8 <= _error_8_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_9 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[9] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_9 <= 2'h0;
      end else begin
        error_9 <= _error_9_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_10 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[10] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_10 <= 2'h0;
      end else begin
        error_10 <= _error_10_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_11 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[11] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_11 <= 2'h0;
      end else begin
        error_11 <= _error_11_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_12 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[12] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_12 <= 2'h0;
      end else begin
        error_12 <= _error_12_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_13 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[13] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_13 <= 2'h0;
      end else begin
        error_13 <= _error_13_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_14 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[14] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_14 <= 2'h0;
      end else begin
        error_14 <= _error_14_T;
      end
    end
    if (reset) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
      error_15 <= 2'h0; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 207:26]
    end else if (_T_22[15] & _T_40) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:34]
      if (auto_out_b_bits_echo_real_last) begin // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 210:46]
        error_15 <= 2'h0;
      end else begin
        error_15 <= _error_15_T;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(~_w_counter_T | w_todo != 9'h0)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at Fragmenter.scala:177 assert (!out.w.fire || w_todo =/= 0.U) // underflow impossible\n"
            ); // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 177:14]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(~_w_counter_T | w_todo != 9'h0) & ~reset) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 177:14]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_13 & ~(~nodeOut_w_valid | ~in_w_bits_last | w_last)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at Fragmenter.scala:186 assert (!out.w.valid || !in_w.bits.last || w_last)\n"); // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 186:14]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(~nodeOut_w_valid | ~in_w_bits_last | w_last) & _T_13) begin
          $fatal; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 186:14]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  busy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  r_addr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  r_len = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  busy_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  r_addr_1 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  r_len_1 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  w_counter = _RAND_6[8:0];
  _RAND_7 = {1{`RANDOM}};
  wbeats_latched = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  error_0 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  error_1 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  error_2 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  error_3 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  error_4 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  error_5 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  error_6 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  error_7 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  error_8 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  error_9 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  error_10 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  error_11 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  error_12 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  error_13 = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  error_14 = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  error_15 = _RAND_23[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimAXIMem_tb(
  input         clock,
  input         reset,
  output        io_axi4_0_aw_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_aw_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [3:0]  io_axi4_0_aw_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [31:0] io_axi4_0_aw_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [7:0]  io_axi4_0_aw_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [2:0]  io_axi4_0_aw_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [1:0]  io_axi4_0_aw_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output        io_axi4_0_w_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_w_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [63:0] io_axi4_0_w_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [7:0]  io_axi4_0_w_bits_strb, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_w_bits_last, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_b_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output        io_axi4_0_b_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output [3:0]  io_axi4_0_b_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output [1:0]  io_axi4_0_b_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output        io_axi4_0_ar_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_ar_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [3:0]  io_axi4_0_ar_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [31:0] io_axi4_0_ar_bits_addr, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [7:0]  io_axi4_0_ar_bits_len, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [2:0]  io_axi4_0_ar_bits_size, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input  [1:0]  io_axi4_0_ar_bits_burst, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  input         io_axi4_0_r_ready, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output        io_axi4_0_r_valid, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output [3:0]  io_axi4_0_r_bits_id, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output [63:0] io_axi4_0_r_bits_data, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output [1:0]  io_axi4_0_r_bits_resp, // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
  output        io_axi4_0_r_bits_last // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1649:17]
);
  wire  srams_clock; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_reset; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [3:0] srams_auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [31:0] srams_auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [63:0] srams_auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [7:0] srams_auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [3:0] srams_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [1:0] srams_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [3:0] srams_auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [31:0] srams_auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [3:0] srams_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [63:0] srams_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire [1:0] srams_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  srams_auto_in_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
  wire  axi4xbar_clock; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_reset; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [31:0] axi4xbar_auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_in_aw_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [2:0] axi4xbar_auto_in_aw_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_in_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [63:0] axi4xbar_auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_w_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [31:0] axi4xbar_auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_in_ar_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [2:0] axi4xbar_auto_in_ar_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_in_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [63:0] axi4xbar_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [31:0] axi4xbar_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_out_aw_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [2:0] axi4xbar_auto_out_aw_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_out_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [63:0] axi4xbar_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_w_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [31:0] axi4xbar_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [7:0] axi4xbar_auto_out_ar_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [2:0] axi4xbar_auto_out_ar_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_out_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [3:0] axi4xbar_auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [63:0] axi4xbar_auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire [1:0] axi4xbar_auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4xbar_auto_out_r_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
  wire  axi4buf_clock; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_reset; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [31:0] axi4buf_auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [63:0] axi4buf_auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [7:0] axi4buf_auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [1:0] axi4buf_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [31:0] axi4buf_auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [63:0] axi4buf_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [1:0] axi4buf_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [31:0] axi4buf_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [63:0] axi4buf_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [7:0] axi4buf_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [1:0] axi4buf_auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [31:0] axi4buf_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [3:0] axi4buf_auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [63:0] axi4buf_auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire [1:0] axi4buf_auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4buf_auto_out_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
  wire  axi4frag_clock; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_reset; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_in_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [31:0] axi4frag_auto_in_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [7:0] axi4frag_auto_in_aw_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [2:0] axi4frag_auto_in_aw_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_in_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [63:0] axi4frag_auto_in_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [7:0] axi4frag_auto_in_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_w_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_in_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [31:0] axi4frag_auto_in_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [7:0] axi4frag_auto_in_ar_bits_len; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [2:0] axi4frag_auto_in_ar_bits_size; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_in_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [63:0] axi4frag_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_aw_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [31:0] axi4frag_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_w_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [63:0] axi4frag_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [7:0] axi4frag_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_b_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_out_b_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_out_b_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_ar_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [31:0] axi4frag_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_r_valid; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [3:0] axi4frag_auto_out_r_bits_id; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [63:0] axi4frag_auto_out_r_bits_data; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire [1:0] axi4frag_auto_out_r_bits_resp; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  wire  axi4frag_auto_out_r_bits_last; // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
  AXI4RAM_tb srams ( // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 19:15]
    .clock(srams_clock),
    .reset(srams_reset),
    .auto_in_aw_ready(srams_auto_in_aw_ready),
    .auto_in_aw_valid(srams_auto_in_aw_valid),
    .auto_in_aw_bits_id(srams_auto_in_aw_bits_id),
    .auto_in_aw_bits_addr(srams_auto_in_aw_bits_addr),
    .auto_in_aw_bits_echo_real_last(srams_auto_in_aw_bits_echo_real_last),
    .auto_in_w_ready(srams_auto_in_w_ready),
    .auto_in_w_valid(srams_auto_in_w_valid),
    .auto_in_w_bits_data(srams_auto_in_w_bits_data),
    .auto_in_w_bits_strb(srams_auto_in_w_bits_strb),
    .auto_in_b_ready(srams_auto_in_b_ready),
    .auto_in_b_valid(srams_auto_in_b_valid),
    .auto_in_b_bits_id(srams_auto_in_b_bits_id),
    .auto_in_b_bits_resp(srams_auto_in_b_bits_resp),
    .auto_in_b_bits_echo_real_last(srams_auto_in_b_bits_echo_real_last),
    .auto_in_ar_ready(srams_auto_in_ar_ready),
    .auto_in_ar_valid(srams_auto_in_ar_valid),
    .auto_in_ar_bits_id(srams_auto_in_ar_bits_id),
    .auto_in_ar_bits_addr(srams_auto_in_ar_bits_addr),
    .auto_in_ar_bits_echo_real_last(srams_auto_in_ar_bits_echo_real_last),
    .auto_in_r_ready(srams_auto_in_r_ready),
    .auto_in_r_valid(srams_auto_in_r_valid),
    .auto_in_r_bits_id(srams_auto_in_r_bits_id),
    .auto_in_r_bits_data(srams_auto_in_r_bits_data),
    .auto_in_r_bits_resp(srams_auto_in_r_bits_resp),
    .auto_in_r_bits_echo_real_last(srams_auto_in_r_bits_echo_real_last)
  );
  AXI4Xbar_tb axi4xbar ( // @[repo/rocket-chip/src/main/scala/amba/axi4/Xbar.scala 230:30]
    .clock(axi4xbar_clock),
    .reset(axi4xbar_reset),
    .auto_in_aw_ready(axi4xbar_auto_in_aw_ready),
    .auto_in_aw_valid(axi4xbar_auto_in_aw_valid),
    .auto_in_aw_bits_id(axi4xbar_auto_in_aw_bits_id),
    .auto_in_aw_bits_addr(axi4xbar_auto_in_aw_bits_addr),
    .auto_in_aw_bits_len(axi4xbar_auto_in_aw_bits_len),
    .auto_in_aw_bits_size(axi4xbar_auto_in_aw_bits_size),
    .auto_in_aw_bits_burst(axi4xbar_auto_in_aw_bits_burst),
    .auto_in_w_ready(axi4xbar_auto_in_w_ready),
    .auto_in_w_valid(axi4xbar_auto_in_w_valid),
    .auto_in_w_bits_data(axi4xbar_auto_in_w_bits_data),
    .auto_in_w_bits_strb(axi4xbar_auto_in_w_bits_strb),
    .auto_in_w_bits_last(axi4xbar_auto_in_w_bits_last),
    .auto_in_b_ready(axi4xbar_auto_in_b_ready),
    .auto_in_b_valid(axi4xbar_auto_in_b_valid),
    .auto_in_b_bits_id(axi4xbar_auto_in_b_bits_id),
    .auto_in_b_bits_resp(axi4xbar_auto_in_b_bits_resp),
    .auto_in_ar_ready(axi4xbar_auto_in_ar_ready),
    .auto_in_ar_valid(axi4xbar_auto_in_ar_valid),
    .auto_in_ar_bits_id(axi4xbar_auto_in_ar_bits_id),
    .auto_in_ar_bits_addr(axi4xbar_auto_in_ar_bits_addr),
    .auto_in_ar_bits_len(axi4xbar_auto_in_ar_bits_len),
    .auto_in_ar_bits_size(axi4xbar_auto_in_ar_bits_size),
    .auto_in_ar_bits_burst(axi4xbar_auto_in_ar_bits_burst),
    .auto_in_r_ready(axi4xbar_auto_in_r_ready),
    .auto_in_r_valid(axi4xbar_auto_in_r_valid),
    .auto_in_r_bits_id(axi4xbar_auto_in_r_bits_id),
    .auto_in_r_bits_data(axi4xbar_auto_in_r_bits_data),
    .auto_in_r_bits_resp(axi4xbar_auto_in_r_bits_resp),
    .auto_in_r_bits_last(axi4xbar_auto_in_r_bits_last),
    .auto_out_aw_ready(axi4xbar_auto_out_aw_ready),
    .auto_out_aw_valid(axi4xbar_auto_out_aw_valid),
    .auto_out_aw_bits_id(axi4xbar_auto_out_aw_bits_id),
    .auto_out_aw_bits_addr(axi4xbar_auto_out_aw_bits_addr),
    .auto_out_aw_bits_len(axi4xbar_auto_out_aw_bits_len),
    .auto_out_aw_bits_size(axi4xbar_auto_out_aw_bits_size),
    .auto_out_aw_bits_burst(axi4xbar_auto_out_aw_bits_burst),
    .auto_out_w_ready(axi4xbar_auto_out_w_ready),
    .auto_out_w_valid(axi4xbar_auto_out_w_valid),
    .auto_out_w_bits_data(axi4xbar_auto_out_w_bits_data),
    .auto_out_w_bits_strb(axi4xbar_auto_out_w_bits_strb),
    .auto_out_w_bits_last(axi4xbar_auto_out_w_bits_last),
    .auto_out_b_ready(axi4xbar_auto_out_b_ready),
    .auto_out_b_valid(axi4xbar_auto_out_b_valid),
    .auto_out_b_bits_id(axi4xbar_auto_out_b_bits_id),
    .auto_out_b_bits_resp(axi4xbar_auto_out_b_bits_resp),
    .auto_out_ar_ready(axi4xbar_auto_out_ar_ready),
    .auto_out_ar_valid(axi4xbar_auto_out_ar_valid),
    .auto_out_ar_bits_id(axi4xbar_auto_out_ar_bits_id),
    .auto_out_ar_bits_addr(axi4xbar_auto_out_ar_bits_addr),
    .auto_out_ar_bits_len(axi4xbar_auto_out_ar_bits_len),
    .auto_out_ar_bits_size(axi4xbar_auto_out_ar_bits_size),
    .auto_out_ar_bits_burst(axi4xbar_auto_out_ar_bits_burst),
    .auto_out_r_ready(axi4xbar_auto_out_r_ready),
    .auto_out_r_valid(axi4xbar_auto_out_r_valid),
    .auto_out_r_bits_id(axi4xbar_auto_out_r_bits_id),
    .auto_out_r_bits_data(axi4xbar_auto_out_r_bits_data),
    .auto_out_r_bits_resp(axi4xbar_auto_out_r_bits_resp),
    .auto_out_r_bits_last(axi4xbar_auto_out_r_bits_last)
  );
  AXI4Buffer_tb axi4buf ( // @[repo/rocket-chip/src/main/scala/amba/axi4/Buffer.scala 63:29]
    .clock(axi4buf_clock),
    .reset(axi4buf_reset),
    .auto_in_aw_ready(axi4buf_auto_in_aw_ready),
    .auto_in_aw_valid(axi4buf_auto_in_aw_valid),
    .auto_in_aw_bits_id(axi4buf_auto_in_aw_bits_id),
    .auto_in_aw_bits_addr(axi4buf_auto_in_aw_bits_addr),
    .auto_in_aw_bits_echo_real_last(axi4buf_auto_in_aw_bits_echo_real_last),
    .auto_in_w_ready(axi4buf_auto_in_w_ready),
    .auto_in_w_valid(axi4buf_auto_in_w_valid),
    .auto_in_w_bits_data(axi4buf_auto_in_w_bits_data),
    .auto_in_w_bits_strb(axi4buf_auto_in_w_bits_strb),
    .auto_in_b_ready(axi4buf_auto_in_b_ready),
    .auto_in_b_valid(axi4buf_auto_in_b_valid),
    .auto_in_b_bits_id(axi4buf_auto_in_b_bits_id),
    .auto_in_b_bits_resp(axi4buf_auto_in_b_bits_resp),
    .auto_in_b_bits_echo_real_last(axi4buf_auto_in_b_bits_echo_real_last),
    .auto_in_ar_ready(axi4buf_auto_in_ar_ready),
    .auto_in_ar_valid(axi4buf_auto_in_ar_valid),
    .auto_in_ar_bits_id(axi4buf_auto_in_ar_bits_id),
    .auto_in_ar_bits_addr(axi4buf_auto_in_ar_bits_addr),
    .auto_in_ar_bits_echo_real_last(axi4buf_auto_in_ar_bits_echo_real_last),
    .auto_in_r_ready(axi4buf_auto_in_r_ready),
    .auto_in_r_valid(axi4buf_auto_in_r_valid),
    .auto_in_r_bits_id(axi4buf_auto_in_r_bits_id),
    .auto_in_r_bits_data(axi4buf_auto_in_r_bits_data),
    .auto_in_r_bits_resp(axi4buf_auto_in_r_bits_resp),
    .auto_in_r_bits_echo_real_last(axi4buf_auto_in_r_bits_echo_real_last),
    .auto_in_r_bits_last(axi4buf_auto_in_r_bits_last),
    .auto_out_aw_ready(axi4buf_auto_out_aw_ready),
    .auto_out_aw_valid(axi4buf_auto_out_aw_valid),
    .auto_out_aw_bits_id(axi4buf_auto_out_aw_bits_id),
    .auto_out_aw_bits_addr(axi4buf_auto_out_aw_bits_addr),
    .auto_out_aw_bits_echo_real_last(axi4buf_auto_out_aw_bits_echo_real_last),
    .auto_out_w_ready(axi4buf_auto_out_w_ready),
    .auto_out_w_valid(axi4buf_auto_out_w_valid),
    .auto_out_w_bits_data(axi4buf_auto_out_w_bits_data),
    .auto_out_w_bits_strb(axi4buf_auto_out_w_bits_strb),
    .auto_out_b_ready(axi4buf_auto_out_b_ready),
    .auto_out_b_valid(axi4buf_auto_out_b_valid),
    .auto_out_b_bits_id(axi4buf_auto_out_b_bits_id),
    .auto_out_b_bits_resp(axi4buf_auto_out_b_bits_resp),
    .auto_out_b_bits_echo_real_last(axi4buf_auto_out_b_bits_echo_real_last),
    .auto_out_ar_ready(axi4buf_auto_out_ar_ready),
    .auto_out_ar_valid(axi4buf_auto_out_ar_valid),
    .auto_out_ar_bits_id(axi4buf_auto_out_ar_bits_id),
    .auto_out_ar_bits_addr(axi4buf_auto_out_ar_bits_addr),
    .auto_out_ar_bits_echo_real_last(axi4buf_auto_out_ar_bits_echo_real_last),
    .auto_out_r_ready(axi4buf_auto_out_r_ready),
    .auto_out_r_valid(axi4buf_auto_out_r_valid),
    .auto_out_r_bits_id(axi4buf_auto_out_r_bits_id),
    .auto_out_r_bits_data(axi4buf_auto_out_r_bits_data),
    .auto_out_r_bits_resp(axi4buf_auto_out_r_bits_resp),
    .auto_out_r_bits_echo_real_last(axi4buf_auto_out_r_bits_echo_real_last)
  );
  AXI4Fragmenter_1_tb axi4frag ( // @[repo/rocket-chip/src/main/scala/amba/axi4/Fragmenter.scala 220:30]
    .clock(axi4frag_clock),
    .reset(axi4frag_reset),
    .auto_in_aw_ready(axi4frag_auto_in_aw_ready),
    .auto_in_aw_valid(axi4frag_auto_in_aw_valid),
    .auto_in_aw_bits_id(axi4frag_auto_in_aw_bits_id),
    .auto_in_aw_bits_addr(axi4frag_auto_in_aw_bits_addr),
    .auto_in_aw_bits_len(axi4frag_auto_in_aw_bits_len),
    .auto_in_aw_bits_size(axi4frag_auto_in_aw_bits_size),
    .auto_in_aw_bits_burst(axi4frag_auto_in_aw_bits_burst),
    .auto_in_w_ready(axi4frag_auto_in_w_ready),
    .auto_in_w_valid(axi4frag_auto_in_w_valid),
    .auto_in_w_bits_data(axi4frag_auto_in_w_bits_data),
    .auto_in_w_bits_strb(axi4frag_auto_in_w_bits_strb),
    .auto_in_w_bits_last(axi4frag_auto_in_w_bits_last),
    .auto_in_b_ready(axi4frag_auto_in_b_ready),
    .auto_in_b_valid(axi4frag_auto_in_b_valid),
    .auto_in_b_bits_id(axi4frag_auto_in_b_bits_id),
    .auto_in_b_bits_resp(axi4frag_auto_in_b_bits_resp),
    .auto_in_ar_ready(axi4frag_auto_in_ar_ready),
    .auto_in_ar_valid(axi4frag_auto_in_ar_valid),
    .auto_in_ar_bits_id(axi4frag_auto_in_ar_bits_id),
    .auto_in_ar_bits_addr(axi4frag_auto_in_ar_bits_addr),
    .auto_in_ar_bits_len(axi4frag_auto_in_ar_bits_len),
    .auto_in_ar_bits_size(axi4frag_auto_in_ar_bits_size),
    .auto_in_ar_bits_burst(axi4frag_auto_in_ar_bits_burst),
    .auto_in_r_ready(axi4frag_auto_in_r_ready),
    .auto_in_r_valid(axi4frag_auto_in_r_valid),
    .auto_in_r_bits_id(axi4frag_auto_in_r_bits_id),
    .auto_in_r_bits_data(axi4frag_auto_in_r_bits_data),
    .auto_in_r_bits_resp(axi4frag_auto_in_r_bits_resp),
    .auto_in_r_bits_last(axi4frag_auto_in_r_bits_last),
    .auto_out_aw_ready(axi4frag_auto_out_aw_ready),
    .auto_out_aw_valid(axi4frag_auto_out_aw_valid),
    .auto_out_aw_bits_id(axi4frag_auto_out_aw_bits_id),
    .auto_out_aw_bits_addr(axi4frag_auto_out_aw_bits_addr),
    .auto_out_aw_bits_echo_real_last(axi4frag_auto_out_aw_bits_echo_real_last),
    .auto_out_w_ready(axi4frag_auto_out_w_ready),
    .auto_out_w_valid(axi4frag_auto_out_w_valid),
    .auto_out_w_bits_data(axi4frag_auto_out_w_bits_data),
    .auto_out_w_bits_strb(axi4frag_auto_out_w_bits_strb),
    .auto_out_b_ready(axi4frag_auto_out_b_ready),
    .auto_out_b_valid(axi4frag_auto_out_b_valid),
    .auto_out_b_bits_id(axi4frag_auto_out_b_bits_id),
    .auto_out_b_bits_resp(axi4frag_auto_out_b_bits_resp),
    .auto_out_b_bits_echo_real_last(axi4frag_auto_out_b_bits_echo_real_last),
    .auto_out_ar_ready(axi4frag_auto_out_ar_ready),
    .auto_out_ar_valid(axi4frag_auto_out_ar_valid),
    .auto_out_ar_bits_id(axi4frag_auto_out_ar_bits_id),
    .auto_out_ar_bits_addr(axi4frag_auto_out_ar_bits_addr),
    .auto_out_ar_bits_echo_real_last(axi4frag_auto_out_ar_bits_echo_real_last),
    .auto_out_r_ready(axi4frag_auto_out_r_ready),
    .auto_out_r_valid(axi4frag_auto_out_r_valid),
    .auto_out_r_bits_id(axi4frag_auto_out_r_bits_id),
    .auto_out_r_bits_data(axi4frag_auto_out_r_bits_data),
    .auto_out_r_bits_resp(axi4frag_auto_out_r_bits_resp),
    .auto_out_r_bits_echo_real_last(axi4frag_auto_out_r_bits_echo_real_last),
    .auto_out_r_bits_last(axi4frag_auto_out_r_bits_last)
  );
  assign io_axi4_0_aw_ready = axi4xbar_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_w_ready = axi4xbar_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_b_valid = axi4xbar_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_b_bits_id = axi4xbar_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_b_bits_resp = axi4xbar_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_ar_ready = axi4xbar_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_r_valid = axi4xbar_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_r_bits_id = axi4xbar_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_r_bits_data = axi4xbar_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_r_bits_resp = axi4xbar_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign io_axi4_0_r_bits_last = axi4xbar_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign srams_clock = clock;
  assign srams_reset = reset;
  assign srams_auto_in_aw_valid = axi4buf_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_aw_bits_id = axi4buf_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_aw_bits_addr = axi4buf_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_aw_bits_echo_real_last = axi4buf_auto_out_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_w_valid = axi4buf_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_w_bits_data = axi4buf_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_w_bits_strb = axi4buf_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_b_ready = axi4buf_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_ar_valid = axi4buf_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_ar_bits_id = axi4buf_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_ar_bits_addr = axi4buf_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_ar_bits_echo_real_last = axi4buf_auto_out_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign srams_auto_in_r_ready = axi4buf_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4xbar_clock = clock;
  assign axi4xbar_reset = reset;
  assign axi4xbar_auto_in_aw_valid = io_axi4_0_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_aw_bits_id = io_axi4_0_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_aw_bits_addr = io_axi4_0_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_aw_bits_len = io_axi4_0_aw_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_aw_bits_size = io_axi4_0_aw_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_aw_bits_burst = io_axi4_0_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_w_valid = io_axi4_0_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_w_bits_data = io_axi4_0_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_w_bits_strb = io_axi4_0_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_w_bits_last = io_axi4_0_w_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_b_ready = io_axi4_0_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_valid = io_axi4_0_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_bits_id = io_axi4_0_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_bits_addr = io_axi4_0_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_bits_len = io_axi4_0_ar_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_bits_size = io_axi4_0_ar_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_ar_bits_burst = io_axi4_0_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_in_r_ready = io_axi4_0_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/Nodes.scala 1205:17 1651:60]
  assign axi4xbar_auto_out_aw_ready = axi4frag_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_w_ready = axi4frag_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_b_valid = axi4frag_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_b_bits_id = axi4frag_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_b_bits_resp = axi4frag_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_ar_ready = axi4frag_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_r_valid = axi4frag_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_r_bits_id = axi4frag_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_r_bits_data = axi4frag_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_r_bits_resp = axi4frag_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4xbar_auto_out_r_bits_last = axi4frag_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4buf_clock = clock;
  assign axi4buf_reset = reset;
  assign axi4buf_auto_in_aw_valid = axi4frag_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_aw_bits_id = axi4frag_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_aw_bits_addr = axi4frag_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_aw_bits_echo_real_last = axi4frag_auto_out_aw_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_w_valid = axi4frag_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_w_bits_data = axi4frag_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_w_bits_strb = axi4frag_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_b_ready = axi4frag_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_ar_valid = axi4frag_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_ar_bits_id = axi4frag_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_ar_bits_addr = axi4frag_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_ar_bits_echo_real_last = axi4frag_auto_out_ar_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_in_r_ready = axi4frag_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_aw_ready = srams_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_w_ready = srams_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_b_valid = srams_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_b_bits_id = srams_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_b_bits_resp = srams_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_b_bits_echo_real_last = srams_auto_in_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_ar_ready = srams_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_r_valid = srams_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_r_bits_id = srams_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_r_bits_data = srams_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_r_bits_resp = srams_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4buf_auto_out_r_bits_echo_real_last = srams_auto_in_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_clock = clock;
  assign axi4frag_reset = reset;
  assign axi4frag_auto_in_aw_valid = axi4xbar_auto_out_aw_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_aw_bits_id = axi4xbar_auto_out_aw_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_aw_bits_addr = axi4xbar_auto_out_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_aw_bits_len = axi4xbar_auto_out_aw_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_aw_bits_size = axi4xbar_auto_out_aw_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_aw_bits_burst = axi4xbar_auto_out_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_w_valid = axi4xbar_auto_out_w_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_w_bits_data = axi4xbar_auto_out_w_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_w_bits_strb = axi4xbar_auto_out_w_bits_strb; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_w_bits_last = axi4xbar_auto_out_w_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_b_ready = axi4xbar_auto_out_b_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_valid = axi4xbar_auto_out_ar_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_bits_id = axi4xbar_auto_out_ar_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_bits_addr = axi4xbar_auto_out_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_bits_len = axi4xbar_auto_out_ar_bits_len; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_bits_size = axi4xbar_auto_out_ar_bits_size; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_ar_bits_burst = axi4xbar_auto_out_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_in_r_ready = axi4xbar_auto_out_r_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 358:18]
  assign axi4frag_auto_out_aw_ready = axi4buf_auto_in_aw_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_w_ready = axi4buf_auto_in_w_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_b_valid = axi4buf_auto_in_b_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_b_bits_id = axi4buf_auto_in_b_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_b_bits_resp = axi4buf_auto_in_b_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_b_bits_echo_real_last = axi4buf_auto_in_b_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_ar_ready = axi4buf_auto_in_ar_ready; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_valid = axi4buf_auto_in_r_valid; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_bits_id = axi4buf_auto_in_r_bits_id; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_bits_data = axi4buf_auto_in_r_bits_data; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_bits_resp = axi4buf_auto_in_r_bits_resp; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_bits_echo_real_last = axi4buf_auto_in_r_bits_echo_real_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
  assign axi4frag_auto_out_r_bits_last = axi4buf_auto_in_r_bits_last; // @[repo/rocket-chip/src/main/scala/diplomacy/LazyModule.scala 356:18]
endmodule
module TaintSource_tb(
  input         clock,
  input         reset,
  input         io_mem_axi4_0_ar_ready, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input         io_mem_axi4_0_ar_valid, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input  [3:0]  io_mem_axi4_0_ar_bits_id, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input  [31:0] io_mem_axi4_0_ar_bits_addr, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input         io_mem_axi4_0_r_ready, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input         io_mem_axi4_0_r_valid, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input  [3:0]  io_mem_axi4_0_r_bits_id, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  input         io_mem_axi4_0_r_bits_last, // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
  output [63:0] io_mem_axi4_0_r_bits_data_taint_0 // @[repo/starship/src/main/scala/asic/SimTop.scala 87:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [63:0] plusarg_reader_out; // @[repo/rocket-chip/src/main/scala/util/PlusArg.scala 80:11]
  wire [31:0] plusarg_reader_1_out; // @[repo/rocket-chip/src/main/scala/util/PlusArg.scala 80:11]
  reg  reg_busy; // @[repo/starship/src/main/scala/asic/SimTop.scala 102:25]
  reg [31:0] reg_matched_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 104:31]
  wire  mem_axi_ar_fire = io_mem_axi4_0_ar_ready & io_mem_axi4_0_ar_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 106:48]
  wire [63:0] _GEN_1 = {{32'd0}, io_mem_axi4_0_ar_bits_addr}; // @[repo/starship/src/main/scala/asic/SimTop.scala 107:54]
  wire [63:0] _GEN_6 = {{32'd0}, plusarg_reader_1_out}; // @[repo/starship/src/main/scala/asic/SimTop.scala 107:116]
  wire [63:0] _mem_axi_ar_match_T_2 = plusarg_reader_out + _GEN_6; // @[repo/starship/src/main/scala/asic/SimTop.scala 107:116]
  wire  mem_axi_ar_match = _GEN_1 >= plusarg_reader_out & _GEN_1 < _mem_axi_ar_match_T_2; // @[repo/starship/src/main/scala/asic/SimTop.scala 107:70]
  wire  mem_axi_r_fire = io_mem_axi4_0_r_ready & io_mem_axi4_0_r_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 108:46]
  wire [31:0] _GEN_8 = {{28'd0}, io_mem_axi4_0_r_bits_id}; // @[repo/starship/src/main/scala/asic/SimTop.scala 109:49]
  wire  mem_axi_r_match = _GEN_8 == reg_matched_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 109:49]
  wire  _GEN_0 = ~reg_busy & mem_axi_ar_fire & mem_axi_ar_match | reg_busy; // @[repo/starship/src/main/scala/asic/SimTop.scala 113:59 114:14 102:25]
  plusarg_reader #(.DEFAULT(32'd2147500032), .FORMAT("secret_addr=%d"), .WIDTH(64)) plusarg_reader ( // @[repo/rocket-chip/src/main/scala/util/PlusArg.scala 80:11]
    .out(plusarg_reader_out)
  );
  plusarg_reader #(.DEFAULT(4096), .FORMAT("secret_size=%d"), .WIDTH(32)) plusarg_reader_1 ( // @[repo/rocket-chip/src/main/scala/util/PlusArg.scala 80:11]
    .out(plusarg_reader_1_out)
  );
  assign io_mem_axi4_0_r_bits_data_taint_0 = reg_busy & mem_axi_r_fire & mem_axi_r_match ? 64'hffffffffffffffff : 64'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 119:37 120:56 121:39]
  always @(posedge clock) begin
    if (reset) begin // @[repo/starship/src/main/scala/asic/SimTop.scala 102:25]
      reg_busy <= 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 102:25]
    end else if (reg_busy & mem_axi_r_fire & mem_axi_r_match) begin // @[repo/starship/src/main/scala/asic/SimTop.scala 120:56]
      if (io_mem_axi4_0_r_bits_last) begin // @[repo/starship/src/main/scala/asic/SimTop.scala 123:38]
        reg_busy <= 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 124:16]
      end else begin
        reg_busy <= _GEN_0;
      end
    end else begin
      reg_busy <= _GEN_0;
    end
    if (reset) begin // @[repo/starship/src/main/scala/asic/SimTop.scala 104:31]
      reg_matched_id <= 32'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 104:31]
    end else if (~reg_busy & mem_axi_ar_fire & mem_axi_ar_match) begin // @[repo/starship/src/main/scala/asic/SimTop.scala 113:59]
      reg_matched_id <= {{28'd0}, io_mem_axi4_0_ar_bits_id}; // @[repo/starship/src/main/scala/asic/SimTop.scala 116:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_busy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_matched_id = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TestHarness(
  input   clock,
  input   reset,
  output  io_uart_tx, // @[repo/starship/src/main/scala/asic/SimTop.scala 131:14]
  input   io_uart_rx // @[repo/starship/src/main/scala/asic/SimTop.scala 131:14]
);
  wire  ldut_clock; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_reset; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_aw_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_aw_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_aw_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_mem_axi4_0_aw_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_mem_axi4_0_aw_bits_len; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_mem_axi4_0_aw_bits_size; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_aw_bits_burst; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_aw_bits_lock; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_aw_bits_cache; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_mem_axi4_0_aw_bits_prot; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_aw_bits_qos; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_w_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_w_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_mem_axi4_0_w_bits_data; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_mem_axi4_0_w_bits_strb; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_w_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_b_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_b_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_b_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_b_bits_resp; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_ar_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_ar_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_ar_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_mem_axi4_0_ar_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_mem_axi4_0_ar_bits_len; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_mem_axi4_0_ar_bits_size; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_ar_bits_burst; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_ar_bits_lock; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_ar_bits_cache; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_mem_axi4_0_ar_bits_prot; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_ar_bits_qos; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_r_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_r_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_r_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_mem_axi4_0_r_bits_data; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_r_bits_resp; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_r_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_aw_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_aw_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_aw_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_l2_frontend_bus_axi4_0_aw_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_aw_bits_len; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_aw_bits_size; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_aw_bits_burst; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_aw_bits_lock; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_aw_bits_cache; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_aw_bits_prot; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_aw_bits_qos; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_w_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_w_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_l2_frontend_bus_axi4_0_w_bits_data; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_w_bits_strb; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_w_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_b_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_b_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_b_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_b_bits_resp; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_ar_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_ar_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_ar_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_l2_frontend_bus_axi4_0_ar_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_ar_bits_len; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_ar_bits_size; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_ar_bits_burst; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_ar_bits_lock; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_ar_bits_cache; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_ar_bits_prot; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_ar_bits_qos; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_r_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_r_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_r_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_l2_frontend_bus_axi4_0_r_bits_data; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_r_bits_resp; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_r_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_uart_0_rxd_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_reset_manager_reset_in_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_r_ready_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_ar_bits_qos_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_ar_bits_prot_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_ar_bits_cache_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_ar_bits_lock_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_ar_bits_burst_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_ar_bits_size_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_ar_bits_len_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_l2_frontend_bus_axi4_0_ar_bits_addr_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_ar_bits_id_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_ar_valid_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_b_ready_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_w_bits_last_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_w_bits_strb_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_l2_frontend_bus_axi4_0_w_bits_data_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_w_valid_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_aw_bits_qos_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_aw_bits_prot_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_l2_frontend_bus_axi4_0_aw_bits_cache_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_aw_bits_lock_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_l2_frontend_bus_axi4_0_aw_bits_burst_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [2:0] ldut_l2_frontend_bus_axi4_0_aw_bits_size_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_aw_bits_len_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [31:0] ldut_l2_frontend_bus_axi4_0_aw_bits_addr_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [7:0] ldut_l2_frontend_bus_axi4_0_aw_bits_id_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_l2_frontend_bus_axi4_0_aw_valid_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_r_bits_last_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_r_bits_resp_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [63:0] ldut_mem_axi4_0_r_bits_data_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_r_bits_id_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_r_valid_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_ar_ready_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [1:0] ldut_mem_axi4_0_b_bits_resp_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire [3:0] ldut_mem_axi4_0_b_bits_id_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_b_valid_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_w_ready_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  ldut_mem_axi4_0_aw_ready_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
  wire  mem_clock; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_reset; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_aw_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_aw_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [3:0] mem_io_axi4_0_aw_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [31:0] mem_io_axi4_0_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [7:0] mem_io_axi4_0_aw_bits_len; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [2:0] mem_io_axi4_0_aw_bits_size; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [1:0] mem_io_axi4_0_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_w_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_w_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [63:0] mem_io_axi4_0_w_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [7:0] mem_io_axi4_0_w_bits_strb; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_w_bits_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_b_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_b_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [3:0] mem_io_axi4_0_b_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [1:0] mem_io_axi4_0_b_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_ar_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_ar_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [3:0] mem_io_axi4_0_ar_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [31:0] mem_io_axi4_0_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [7:0] mem_io_axi4_0_ar_bits_len; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [2:0] mem_io_axi4_0_ar_bits_size; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [1:0] mem_io_axi4_0_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_r_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_r_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [3:0] mem_io_axi4_0_r_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [63:0] mem_io_axi4_0_r_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire [1:0] mem_io_axi4_0_r_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  mem_io_axi4_0_r_bits_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
  wire  tsrc_clock; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_reset; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_io_mem_axi4_0_ar_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_io_mem_axi4_0_ar_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire [3:0] tsrc_io_mem_axi4_0_ar_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire [31:0] tsrc_io_mem_axi4_0_ar_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_io_mem_axi4_0_r_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_io_mem_axi4_0_r_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire [3:0] tsrc_io_mem_axi4_0_r_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire  tsrc_io_mem_axi4_0_r_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  wire [63:0] tsrc_io_mem_axi4_0_r_bits_data_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
  StarshipSimTop ldut ( // @[repo/starship/src/main/scala/asic/SimTop.scala 137:19]
    .clock(ldut_clock),
    .reset(ldut_reset),
    .mem_axi4_0_aw_ready(ldut_mem_axi4_0_aw_ready),
    .mem_axi4_0_aw_valid(ldut_mem_axi4_0_aw_valid),
    .mem_axi4_0_aw_bits_id(ldut_mem_axi4_0_aw_bits_id),
    .mem_axi4_0_aw_bits_addr(ldut_mem_axi4_0_aw_bits_addr),
    .mem_axi4_0_aw_bits_len(ldut_mem_axi4_0_aw_bits_len),
    .mem_axi4_0_aw_bits_size(ldut_mem_axi4_0_aw_bits_size),
    .mem_axi4_0_aw_bits_burst(ldut_mem_axi4_0_aw_bits_burst),
    .mem_axi4_0_aw_bits_lock(ldut_mem_axi4_0_aw_bits_lock),
    .mem_axi4_0_aw_bits_cache(ldut_mem_axi4_0_aw_bits_cache),
    .mem_axi4_0_aw_bits_prot(ldut_mem_axi4_0_aw_bits_prot),
    .mem_axi4_0_aw_bits_qos(ldut_mem_axi4_0_aw_bits_qos),
    .mem_axi4_0_w_ready(ldut_mem_axi4_0_w_ready),
    .mem_axi4_0_w_valid(ldut_mem_axi4_0_w_valid),
    .mem_axi4_0_w_bits_data(ldut_mem_axi4_0_w_bits_data),
    .mem_axi4_0_w_bits_strb(ldut_mem_axi4_0_w_bits_strb),
    .mem_axi4_0_w_bits_last(ldut_mem_axi4_0_w_bits_last),
    .mem_axi4_0_b_ready(ldut_mem_axi4_0_b_ready),
    .mem_axi4_0_b_valid(ldut_mem_axi4_0_b_valid),
    .mem_axi4_0_b_bits_id(ldut_mem_axi4_0_b_bits_id),
    .mem_axi4_0_b_bits_resp(ldut_mem_axi4_0_b_bits_resp),
    .mem_axi4_0_ar_ready(ldut_mem_axi4_0_ar_ready),
    .mem_axi4_0_ar_valid(ldut_mem_axi4_0_ar_valid),
    .mem_axi4_0_ar_bits_id(ldut_mem_axi4_0_ar_bits_id),
    .mem_axi4_0_ar_bits_addr(ldut_mem_axi4_0_ar_bits_addr),
    .mem_axi4_0_ar_bits_len(ldut_mem_axi4_0_ar_bits_len),
    .mem_axi4_0_ar_bits_size(ldut_mem_axi4_0_ar_bits_size),
    .mem_axi4_0_ar_bits_burst(ldut_mem_axi4_0_ar_bits_burst),
    .mem_axi4_0_ar_bits_lock(ldut_mem_axi4_0_ar_bits_lock),
    .mem_axi4_0_ar_bits_cache(ldut_mem_axi4_0_ar_bits_cache),
    .mem_axi4_0_ar_bits_prot(ldut_mem_axi4_0_ar_bits_prot),
    .mem_axi4_0_ar_bits_qos(ldut_mem_axi4_0_ar_bits_qos),
    .mem_axi4_0_r_ready(ldut_mem_axi4_0_r_ready),
    .mem_axi4_0_r_valid(ldut_mem_axi4_0_r_valid),
    .mem_axi4_0_r_bits_id(ldut_mem_axi4_0_r_bits_id),
    .mem_axi4_0_r_bits_data(ldut_mem_axi4_0_r_bits_data),
    .mem_axi4_0_r_bits_resp(ldut_mem_axi4_0_r_bits_resp),
    .mem_axi4_0_r_bits_last(ldut_mem_axi4_0_r_bits_last),
    .l2_frontend_bus_axi4_0_aw_ready(ldut_l2_frontend_bus_axi4_0_aw_ready),
    .l2_frontend_bus_axi4_0_aw_valid(ldut_l2_frontend_bus_axi4_0_aw_valid),
    .l2_frontend_bus_axi4_0_aw_bits_id(ldut_l2_frontend_bus_axi4_0_aw_bits_id),
    .l2_frontend_bus_axi4_0_aw_bits_addr(ldut_l2_frontend_bus_axi4_0_aw_bits_addr),
    .l2_frontend_bus_axi4_0_aw_bits_len(ldut_l2_frontend_bus_axi4_0_aw_bits_len),
    .l2_frontend_bus_axi4_0_aw_bits_size(ldut_l2_frontend_bus_axi4_0_aw_bits_size),
    .l2_frontend_bus_axi4_0_aw_bits_burst(ldut_l2_frontend_bus_axi4_0_aw_bits_burst),
    .l2_frontend_bus_axi4_0_aw_bits_lock(ldut_l2_frontend_bus_axi4_0_aw_bits_lock),
    .l2_frontend_bus_axi4_0_aw_bits_cache(ldut_l2_frontend_bus_axi4_0_aw_bits_cache),
    .l2_frontend_bus_axi4_0_aw_bits_prot(ldut_l2_frontend_bus_axi4_0_aw_bits_prot),
    .l2_frontend_bus_axi4_0_aw_bits_qos(ldut_l2_frontend_bus_axi4_0_aw_bits_qos),
    .l2_frontend_bus_axi4_0_w_ready(ldut_l2_frontend_bus_axi4_0_w_ready),
    .l2_frontend_bus_axi4_0_w_valid(ldut_l2_frontend_bus_axi4_0_w_valid),
    .l2_frontend_bus_axi4_0_w_bits_data(ldut_l2_frontend_bus_axi4_0_w_bits_data),
    .l2_frontend_bus_axi4_0_w_bits_strb(ldut_l2_frontend_bus_axi4_0_w_bits_strb),
    .l2_frontend_bus_axi4_0_w_bits_last(ldut_l2_frontend_bus_axi4_0_w_bits_last),
    .l2_frontend_bus_axi4_0_b_ready(ldut_l2_frontend_bus_axi4_0_b_ready),
    .l2_frontend_bus_axi4_0_b_valid(ldut_l2_frontend_bus_axi4_0_b_valid),
    .l2_frontend_bus_axi4_0_b_bits_id(ldut_l2_frontend_bus_axi4_0_b_bits_id),
    .l2_frontend_bus_axi4_0_b_bits_resp(ldut_l2_frontend_bus_axi4_0_b_bits_resp),
    .l2_frontend_bus_axi4_0_ar_ready(ldut_l2_frontend_bus_axi4_0_ar_ready),
    .l2_frontend_bus_axi4_0_ar_valid(ldut_l2_frontend_bus_axi4_0_ar_valid),
    .l2_frontend_bus_axi4_0_ar_bits_id(ldut_l2_frontend_bus_axi4_0_ar_bits_id),
    .l2_frontend_bus_axi4_0_ar_bits_addr(ldut_l2_frontend_bus_axi4_0_ar_bits_addr),
    .l2_frontend_bus_axi4_0_ar_bits_len(ldut_l2_frontend_bus_axi4_0_ar_bits_len),
    .l2_frontend_bus_axi4_0_ar_bits_size(ldut_l2_frontend_bus_axi4_0_ar_bits_size),
    .l2_frontend_bus_axi4_0_ar_bits_burst(ldut_l2_frontend_bus_axi4_0_ar_bits_burst),
    .l2_frontend_bus_axi4_0_ar_bits_lock(ldut_l2_frontend_bus_axi4_0_ar_bits_lock),
    .l2_frontend_bus_axi4_0_ar_bits_cache(ldut_l2_frontend_bus_axi4_0_ar_bits_cache),
    .l2_frontend_bus_axi4_0_ar_bits_prot(ldut_l2_frontend_bus_axi4_0_ar_bits_prot),
    .l2_frontend_bus_axi4_0_ar_bits_qos(ldut_l2_frontend_bus_axi4_0_ar_bits_qos),
    .l2_frontend_bus_axi4_0_r_ready(ldut_l2_frontend_bus_axi4_0_r_ready),
    .l2_frontend_bus_axi4_0_r_valid(ldut_l2_frontend_bus_axi4_0_r_valid),
    .l2_frontend_bus_axi4_0_r_bits_id(ldut_l2_frontend_bus_axi4_0_r_bits_id),
    .l2_frontend_bus_axi4_0_r_bits_data(ldut_l2_frontend_bus_axi4_0_r_bits_data),
    .l2_frontend_bus_axi4_0_r_bits_resp(ldut_l2_frontend_bus_axi4_0_r_bits_resp),
    .l2_frontend_bus_axi4_0_r_bits_last(ldut_l2_frontend_bus_axi4_0_r_bits_last),
    .uart_0_rxd_taint_0(ldut_uart_0_rxd_taint_0),
    .reset_manager_reset_in_taint_0(ldut_reset_manager_reset_in_taint_0),
    .l2_frontend_bus_axi4_0_r_ready_taint_0(ldut_l2_frontend_bus_axi4_0_r_ready_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_qos_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_qos_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_prot_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_prot_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_cache_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_cache_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_lock_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_lock_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_burst_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_burst_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_size_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_size_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_len_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_len_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_addr_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_addr_taint_0),
    .l2_frontend_bus_axi4_0_ar_bits_id_taint_0(ldut_l2_frontend_bus_axi4_0_ar_bits_id_taint_0),
    .l2_frontend_bus_axi4_0_ar_valid_taint_0(ldut_l2_frontend_bus_axi4_0_ar_valid_taint_0),
    .l2_frontend_bus_axi4_0_b_ready_taint_0(ldut_l2_frontend_bus_axi4_0_b_ready_taint_0),
    .l2_frontend_bus_axi4_0_w_bits_last_taint_0(ldut_l2_frontend_bus_axi4_0_w_bits_last_taint_0),
    .l2_frontend_bus_axi4_0_w_bits_strb_taint_0(ldut_l2_frontend_bus_axi4_0_w_bits_strb_taint_0),
    .l2_frontend_bus_axi4_0_w_bits_data_taint_0(ldut_l2_frontend_bus_axi4_0_w_bits_data_taint_0),
    .l2_frontend_bus_axi4_0_w_valid_taint_0(ldut_l2_frontend_bus_axi4_0_w_valid_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_qos_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_qos_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_prot_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_prot_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_cache_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_cache_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_lock_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_lock_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_burst_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_burst_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_size_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_size_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_len_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_len_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_addr_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_addr_taint_0),
    .l2_frontend_bus_axi4_0_aw_bits_id_taint_0(ldut_l2_frontend_bus_axi4_0_aw_bits_id_taint_0),
    .l2_frontend_bus_axi4_0_aw_valid_taint_0(ldut_l2_frontend_bus_axi4_0_aw_valid_taint_0),
    .mem_axi4_0_r_bits_last_taint_0(ldut_mem_axi4_0_r_bits_last_taint_0),
    .mem_axi4_0_r_bits_resp_taint_0(ldut_mem_axi4_0_r_bits_resp_taint_0),
    .mem_axi4_0_r_bits_data_taint_0(ldut_mem_axi4_0_r_bits_data_taint_0),
    .mem_axi4_0_r_bits_id_taint_0(ldut_mem_axi4_0_r_bits_id_taint_0),
    .mem_axi4_0_r_valid_taint_0(ldut_mem_axi4_0_r_valid_taint_0),
    .mem_axi4_0_ar_ready_taint_0(ldut_mem_axi4_0_ar_ready_taint_0),
    .mem_axi4_0_b_bits_resp_taint_0(ldut_mem_axi4_0_b_bits_resp_taint_0),
    .mem_axi4_0_b_bits_id_taint_0(ldut_mem_axi4_0_b_bits_id_taint_0),
    .mem_axi4_0_b_valid_taint_0(ldut_mem_axi4_0_b_valid_taint_0),
    .mem_axi4_0_w_ready_taint_0(ldut_mem_axi4_0_w_ready_taint_0),
    .mem_axi4_0_aw_ready_taint_0(ldut_mem_axi4_0_aw_ready_taint_0)
  );
  SimAXIMem_tb mem ( // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 47:13]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_axi4_0_aw_ready(mem_io_axi4_0_aw_ready),
    .io_axi4_0_aw_valid(mem_io_axi4_0_aw_valid),
    .io_axi4_0_aw_bits_id(mem_io_axi4_0_aw_bits_id),
    .io_axi4_0_aw_bits_addr(mem_io_axi4_0_aw_bits_addr),
    .io_axi4_0_aw_bits_len(mem_io_axi4_0_aw_bits_len),
    .io_axi4_0_aw_bits_size(mem_io_axi4_0_aw_bits_size),
    .io_axi4_0_aw_bits_burst(mem_io_axi4_0_aw_bits_burst),
    .io_axi4_0_w_ready(mem_io_axi4_0_w_ready),
    .io_axi4_0_w_valid(mem_io_axi4_0_w_valid),
    .io_axi4_0_w_bits_data(mem_io_axi4_0_w_bits_data),
    .io_axi4_0_w_bits_strb(mem_io_axi4_0_w_bits_strb),
    .io_axi4_0_w_bits_last(mem_io_axi4_0_w_bits_last),
    .io_axi4_0_b_ready(mem_io_axi4_0_b_ready),
    .io_axi4_0_b_valid(mem_io_axi4_0_b_valid),
    .io_axi4_0_b_bits_id(mem_io_axi4_0_b_bits_id),
    .io_axi4_0_b_bits_resp(mem_io_axi4_0_b_bits_resp),
    .io_axi4_0_ar_ready(mem_io_axi4_0_ar_ready),
    .io_axi4_0_ar_valid(mem_io_axi4_0_ar_valid),
    .io_axi4_0_ar_bits_id(mem_io_axi4_0_ar_bits_id),
    .io_axi4_0_ar_bits_addr(mem_io_axi4_0_ar_bits_addr),
    .io_axi4_0_ar_bits_len(mem_io_axi4_0_ar_bits_len),
    .io_axi4_0_ar_bits_size(mem_io_axi4_0_ar_bits_size),
    .io_axi4_0_ar_bits_burst(mem_io_axi4_0_ar_bits_burst),
    .io_axi4_0_r_ready(mem_io_axi4_0_r_ready),
    .io_axi4_0_r_valid(mem_io_axi4_0_r_valid),
    .io_axi4_0_r_bits_id(mem_io_axi4_0_r_bits_id),
    .io_axi4_0_r_bits_data(mem_io_axi4_0_r_bits_data),
    .io_axi4_0_r_bits_resp(mem_io_axi4_0_r_bits_resp),
    .io_axi4_0_r_bits_last(mem_io_axi4_0_r_bits_last)
  );
  TaintSource_tb tsrc ( // @[repo/starship/src/main/scala/asic/SimTop.scala 173:20]
    .clock(tsrc_clock),
    .reset(tsrc_reset),
    .io_mem_axi4_0_ar_ready(tsrc_io_mem_axi4_0_ar_ready),
    .io_mem_axi4_0_ar_valid(tsrc_io_mem_axi4_0_ar_valid),
    .io_mem_axi4_0_ar_bits_id(tsrc_io_mem_axi4_0_ar_bits_id),
    .io_mem_axi4_0_ar_bits_addr(tsrc_io_mem_axi4_0_ar_bits_addr),
    .io_mem_axi4_0_r_ready(tsrc_io_mem_axi4_0_r_ready),
    .io_mem_axi4_0_r_valid(tsrc_io_mem_axi4_0_r_valid),
    .io_mem_axi4_0_r_bits_id(tsrc_io_mem_axi4_0_r_bits_id),
    .io_mem_axi4_0_r_bits_last(tsrc_io_mem_axi4_0_r_bits_last),
    .io_mem_axi4_0_r_bits_data_taint_0(tsrc_io_mem_axi4_0_r_bits_data_taint_0)
  );
  assign io_uart_tx = 1'h0;
  assign ldut_clock = clock;
  assign ldut_reset = reset; // @[repo/starship/src/main/scala/asic/SimTop.scala 145:75]
  assign ldut_mem_axi4_0_aw_ready = mem_io_axi4_0_aw_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_w_ready = mem_io_axi4_0_w_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_b_valid = mem_io_axi4_0_b_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_b_bits_id = mem_io_axi4_0_b_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_b_bits_resp = mem_io_axi4_0_b_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_ar_ready = mem_io_axi4_0_ar_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_r_valid = mem_io_axi4_0_r_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_r_bits_id = mem_io_axi4_0_r_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_r_bits_data = mem_io_axi4_0_r_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_r_bits_resp = mem_io_axi4_0_r_bits_resp; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_mem_axi4_0_r_bits_last = mem_io_axi4_0_r_bits_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign ldut_l2_frontend_bus_axi4_0_aw_valid = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 155:18]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_id = 8'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_addr = 32'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_len = 8'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_size = 3'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_burst = 2'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_lock = 1'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_cache = 4'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_prot = 3'h0;
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_qos = 4'h0;
  assign ldut_l2_frontend_bus_axi4_0_w_valid = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 157:17]
  assign ldut_l2_frontend_bus_axi4_0_w_bits_data = 64'h0;
  assign ldut_l2_frontend_bus_axi4_0_w_bits_strb = 8'h0;
  assign ldut_l2_frontend_bus_axi4_0_w_bits_last = 1'h0;
  assign ldut_l2_frontend_bus_axi4_0_b_ready = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 160:17]
  assign ldut_l2_frontend_bus_axi4_0_ar_valid = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 153:18]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_id = 8'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_addr = 32'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_len = 8'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_size = 3'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_burst = 2'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_lock = 1'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_cache = 4'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_prot = 3'h0;
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_qos = 4'h0;
  assign ldut_l2_frontend_bus_axi4_0_r_ready = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 159:17]
  assign ldut_uart_0_rxd_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_reset_manager_reset_in_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_r_ready_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_qos_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_prot_taint_0 = 3'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_cache_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_lock_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_burst_taint_0 = 2'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_size_taint_0 = 3'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_len_taint_0 = 8'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_addr_taint_0 = 32'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_bits_id_taint_0 = 8'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_ar_valid_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_b_ready_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_w_bits_last_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_w_bits_strb_taint_0 = 8'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_w_bits_data_taint_0 = 64'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_w_valid_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_qos_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_prot_taint_0 = 3'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_cache_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_lock_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_burst_taint_0 = 2'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_size_taint_0 = 3'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_len_taint_0 = 8'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_addr_taint_0 = 32'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_bits_id_taint_0 = 8'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_l2_frontend_bus_axi4_0_aw_valid_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_r_bits_last_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_r_bits_resp_taint_0 = 2'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_r_bits_data_taint_0 = tsrc_io_mem_axi4_0_r_bits_data_taint_0; // @[repo/starship/src/main/scala/asic/SimTop.scala 182:57]
  assign ldut_mem_axi4_0_r_bits_id_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_r_valid_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_ar_ready_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_b_bits_resp_taint_0 = 2'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_b_bits_id_taint_0 = 4'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_b_valid_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_w_ready_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign ldut_mem_axi4_0_aw_ready_taint_0 = 1'h0; // @[repo/starship/src/main/scala/asic/SimTop.scala 166:10]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_axi4_0_aw_valid = ldut_mem_axi4_0_aw_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_aw_bits_id = ldut_mem_axi4_0_aw_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_aw_bits_addr = ldut_mem_axi4_0_aw_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_aw_bits_len = ldut_mem_axi4_0_aw_bits_len; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_aw_bits_size = ldut_mem_axi4_0_aw_bits_size; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_aw_bits_burst = ldut_mem_axi4_0_aw_bits_burst; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_w_valid = ldut_mem_axi4_0_w_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_w_bits_data = ldut_mem_axi4_0_w_bits_data; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_w_bits_strb = ldut_mem_axi4_0_w_bits_strb; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_w_bits_last = ldut_mem_axi4_0_w_bits_last; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_b_ready = ldut_mem_axi4_0_b_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_valid = ldut_mem_axi4_0_ar_valid; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_bits_id = ldut_mem_axi4_0_ar_bits_id; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_bits_addr = ldut_mem_axi4_0_ar_bits_addr; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_bits_len = ldut_mem_axi4_0_ar_bits_len; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_bits_size = ldut_mem_axi4_0_ar_bits_size; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_ar_bits_burst = ldut_mem_axi4_0_ar_bits_burst; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign mem_io_axi4_0_r_ready = ldut_mem_axi4_0_r_ready; // @[repo/rocket-chip/src/main/scala/system/SimAXIMem.scala 48:24]
  assign tsrc_clock = clock;
  assign tsrc_reset = reset;
  assign tsrc_io_mem_axi4_0_ar_ready = ldut_mem_axi4_0_ar_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 174:31]
  assign tsrc_io_mem_axi4_0_ar_valid = ldut_mem_axi4_0_ar_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 175:31]
  assign tsrc_io_mem_axi4_0_ar_bits_id = ldut_mem_axi4_0_ar_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 176:33]
  assign tsrc_io_mem_axi4_0_ar_bits_addr = ldut_mem_axi4_0_ar_bits_addr; // @[repo/starship/src/main/scala/asic/SimTop.scala 177:35]
  assign tsrc_io_mem_axi4_0_r_ready = ldut_mem_axi4_0_r_ready; // @[repo/starship/src/main/scala/asic/SimTop.scala 178:30]
  assign tsrc_io_mem_axi4_0_r_valid = ldut_mem_axi4_0_r_valid; // @[repo/starship/src/main/scala/asic/SimTop.scala 179:30]
  assign tsrc_io_mem_axi4_0_r_bits_id = ldut_mem_axi4_0_r_bits_id; // @[repo/starship/src/main/scala/asic/SimTop.scala 180:32]
  assign tsrc_io_mem_axi4_0_r_bits_last = ldut_mem_axi4_0_r_bits_last; // @[repo/starship/src/main/scala/asic/SimTop.scala 181:34]
endmodule
module mem_tb(
  input  [27:0] R0_addr,
  input         R0_en,
  input         R0_clk,
  output [7:0]  R0_data_0,
  output [7:0]  R0_data_1,
  output [7:0]  R0_data_2,
  output [7:0]  R0_data_3,
  output [7:0]  R0_data_4,
  output [7:0]  R0_data_5,
  output [7:0]  R0_data_6,
  output [7:0]  R0_data_7,
  input  [27:0] W0_addr,
  input         W0_en,
  input         W0_clk,
  input  [7:0]  W0_data_0,
  input  [7:0]  W0_data_1,
  input  [7:0]  W0_data_2,
  input  [7:0]  W0_data_3,
  input  [7:0]  W0_data_4,
  input  [7:0]  W0_data_5,
  input  [7:0]  W0_data_6,
  input  [7:0]  W0_data_7,
  input         W0_mask_0,
  input         W0_mask_1,
  input         W0_mask_2,
  input         W0_mask_3,
  input         W0_mask_4,
  input         W0_mask_5,
  input         W0_mask_6,
  input         W0_mask_7
);
  wire [27:0] mem_ext_R0_addr;
  wire  mem_ext_R0_en;
  wire  mem_ext_R0_clk;
  wire [63:0] mem_ext_R0_data;
  wire [27:0] mem_ext_W0_addr;
  wire  mem_ext_W0_en;
  wire  mem_ext_W0_clk;
  wire [63:0] mem_ext_W0_data;
  wire [7:0] mem_ext_W0_mask;
  wire [31:0] _GEN_4 = {W0_data_7,W0_data_6,W0_data_5,W0_data_4};
  wire [31:0] _GEN_5 = {W0_data_3,W0_data_2,W0_data_1,W0_data_0};
  wire [3:0] _GEN_10 = {W0_mask_7,W0_mask_6,W0_mask_5,W0_mask_4};
  wire [3:0] _GEN_11 = {W0_mask_3,W0_mask_2,W0_mask_1,W0_mask_0};
  mem_ext mem_ext (
    .R0_addr(mem_ext_R0_addr),
    .R0_en(mem_ext_R0_en),
    .R0_clk(mem_ext_R0_clk),
    .R0_data(mem_ext_R0_data),
    .W0_addr(mem_ext_W0_addr),
    .W0_en(mem_ext_W0_en),
    .W0_clk(mem_ext_W0_clk),
    .W0_data(mem_ext_W0_data),
    .W0_mask(mem_ext_W0_mask)
  );
  assign mem_ext_R0_clk = R0_clk;
  assign mem_ext_R0_en = R0_en;
  assign mem_ext_R0_addr = R0_addr;
  assign R0_data_0 = mem_ext_R0_data[7:0];
  assign R0_data_1 = mem_ext_R0_data[15:8];
  assign R0_data_2 = mem_ext_R0_data[23:16];
  assign R0_data_3 = mem_ext_R0_data[31:24];
  assign R0_data_4 = mem_ext_R0_data[39:32];
  assign R0_data_5 = mem_ext_R0_data[47:40];
  assign R0_data_6 = mem_ext_R0_data[55:48];
  assign R0_data_7 = mem_ext_R0_data[63:56];
  assign mem_ext_W0_clk = W0_clk;
  assign mem_ext_W0_en = W0_en;
  assign mem_ext_W0_addr = W0_addr;
  assign mem_ext_W0_data = {_GEN_4,_GEN_5};
  assign mem_ext_W0_mask = {_GEN_10,_GEN_11};
endmodule
