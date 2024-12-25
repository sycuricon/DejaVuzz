import "DPI-C" function void testbench_memory_write_byte(byte unsigned is_variant, longint unsigned addr, byte unsigned data);
import "DPI-C" function byte testbench_memory_read_byte(byte unsigned is_variant, longint unsigned addr);
import "DPI-C" function void testbench_memory_initial(string input_file, longint unsigned real_mem_size);
`timescale 1ns / 10ps

`ifndef RESET_DELAY
	`define RESET_DELAY 7.7
`endif

module mem_ext(
	input W0_clk,
	input [25:0] W0_addr,
	input W0_en,
	input [255:0] W0_data,
	input [31:0] W0_mask,

	input R0_clk,
	input [25:0] R0_addr,
	input R0_en,
	output [255:0] R0_data
);

	byte unsigned is_variant;
	string testcase_file = "";
	initial begin
		#(`RESET_DELAY/2.0)
		is_variant = {is_variant_hierachy($sformatf("%m"))};
		void'($value$plusargs("testcase=%s", testcase_file));
		testbench_memory_initial(testcase_file, 64'h80000000);
	end

	reg [255:0] R0_tmp_data;
	assign R0_data = R0_tmp_data;
	always @(posedge R0_clk)begin
		if (R0_en) begin
			R0_tmp_data[7:0] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd0});
			R0_tmp_data[15:8] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd1});
			R0_tmp_data[23:16] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd2});
			R0_tmp_data[31:24] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd3});
			R0_tmp_data[39:32] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd4});
			R0_tmp_data[47:40] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd5});
			R0_tmp_data[55:48] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd6});
			R0_tmp_data[63:56] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd7});
			R0_tmp_data[71:64] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd8});
			R0_tmp_data[79:72] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd9});
			R0_tmp_data[87:80] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd10});
			R0_tmp_data[95:88] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd11});
			R0_tmp_data[103:96] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd12});
			R0_tmp_data[111:104] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd13});
			R0_tmp_data[119:112] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd14});
			R0_tmp_data[127:120] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd15});
			R0_tmp_data[135:128] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd16});
			R0_tmp_data[143:136] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd17});
			R0_tmp_data[151:144] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd18});
			R0_tmp_data[159:152] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd19});
			R0_tmp_data[167:160] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd20});
			R0_tmp_data[175:168] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd21});
			R0_tmp_data[183:176] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd22});
			R0_tmp_data[191:184] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd23});
			R0_tmp_data[199:192] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd24});
			R0_tmp_data[207:200] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd25});
			R0_tmp_data[215:208] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd26});
			R0_tmp_data[223:216] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd27});
			R0_tmp_data[231:224] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd28});
			R0_tmp_data[239:232] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd29});
			R0_tmp_data[247:240] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd30});
			R0_tmp_data[255:248] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 5'd31});
		end
	end
	always @(posedge W0_clk)begin
		if (W0_en) begin
			if(W0_mask[0]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd0}, W0_data[7:0]);
			if(W0_mask[1]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd1}, W0_data[15:8]);
			if(W0_mask[2]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd2}, W0_data[23:16]);
			if(W0_mask[3]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd3}, W0_data[31:24]);
			if(W0_mask[4]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd4}, W0_data[39:32]);
			if(W0_mask[5]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd5}, W0_data[47:40]);
			if(W0_mask[6]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd6}, W0_data[55:48]);
			if(W0_mask[7]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd7}, W0_data[63:56]);
			if(W0_mask[8]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd8}, W0_data[71:64]);
			if(W0_mask[9]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd9}, W0_data[79:72]);
			if(W0_mask[10]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd10}, W0_data[87:80]);
			if(W0_mask[11]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd11}, W0_data[95:88]);
			if(W0_mask[12]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd12}, W0_data[103:96]);
			if(W0_mask[13]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd13}, W0_data[111:104]);
			if(W0_mask[14]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd14}, W0_data[119:112]);
			if(W0_mask[15]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd15}, W0_data[127:120]);
			if(W0_mask[16]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd16}, W0_data[135:128]);
			if(W0_mask[17]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd17}, W0_data[143:136]);
			if(W0_mask[18]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd18}, W0_data[151:144]);
			if(W0_mask[19]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd19}, W0_data[159:152]);
			if(W0_mask[20]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd20}, W0_data[167:160]);
			if(W0_mask[21]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd21}, W0_data[175:168]);
			if(W0_mask[22]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd22}, W0_data[183:176]);
			if(W0_mask[23]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd23}, W0_data[191:184]);
			if(W0_mask[24]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd24}, W0_data[199:192]);
			if(W0_mask[25]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd25}, W0_data[207:200]);
			if(W0_mask[26]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd26}, W0_data[215:208]);
			if(W0_mask[27]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd27}, W0_data[223:216]);
			if(W0_mask[28]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd28}, W0_data[231:224]);
			if(W0_mask[29]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd29}, W0_data[239:232]);
			if(W0_mask[30]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd30}, W0_data[247:240]);
			if(W0_mask[31]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 5'd31}, W0_data[255:248]);
		end
	end

endmodule
