import "DPI-C" function void testbench_memory_write_byte(byte unsigned is_variant, longint unsigned addr, byte unsigned data);
import "DPI-C" function byte testbench_memory_read_byte(byte unsigned is_variant, longint unsigned addr);
import "DPI-C" function void testbench_memory_initial(string input_file, longint unsigned real_mem_size);
`timescale 1ns / 10ps

`ifndef RESET_DELAY
	`define RESET_DELAY 7.7
`endif

module mem_ext(
	input W0_clk,
	input [27:0] W0_addr,
	input W0_en,
	input [63:0] W0_data,
	input [7:0] W0_mask,

	input R0_clk,
	input [27:0] R0_addr,
	input R0_en,
	output [63:0] R0_data
);

	byte unsigned is_variant;
	string testcase_file = "";
	initial begin
		#(`RESET_DELAY/2.0)
		is_variant = {is_variant_hierachy($sformatf("%m"))};
		void'($value$plusargs("testcase=%s", testcase_file));
		testbench_memory_initial(testcase_file, 64'h80000000);
	end

	reg [63:0] R0_tmp_data;
	assign R0_data = R0_tmp_data;
	always @(posedge R0_clk)begin
		if (R0_en) begin
			R0_tmp_data[7:0] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd0});
			R0_tmp_data[15:8] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd1});
			R0_tmp_data[23:16] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd2});
			R0_tmp_data[31:24] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd3});
			R0_tmp_data[39:32] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd4});
			R0_tmp_data[47:40] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd5});
			R0_tmp_data[55:48] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd6});
			R0_tmp_data[63:56] <= testbench_memory_read_byte(is_variant, {33'h0, R0_addr, 3'd7});
		end
	end
	always @(posedge W0_clk)begin
		if (W0_en) begin
			if(W0_mask[0]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd0}, W0_data[7:0]);
			if(W0_mask[1]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd1}, W0_data[15:8]);
			if(W0_mask[2]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd2}, W0_data[23:16]);
			if(W0_mask[3]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd3}, W0_data[31:24]);
			if(W0_mask[4]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd4}, W0_data[39:32]);
			if(W0_mask[5]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd5}, W0_data[47:40]);
			if(W0_mask[6]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd6}, W0_data[55:48]);
			if(W0_mask[7]) testbench_memory_write_byte(is_variant, {33'h0, W0_addr, 3'd7}, W0_data[63:56]);
		end
	end

endmodule
