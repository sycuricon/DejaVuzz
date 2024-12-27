yosys read_verilog -sv vsrc/XiangShan.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.opt.v
yosys read_verilog -sv yosys/blackbox.v

yosys hierarchy -top $::env(YOSYS_TOP)

yosys proc
yosys memory_collect
yosys opt -purge

# yosys tee -o vsrc/sink_summary.log tsink --verbose --top $::env(YOSYS_TOP)

yosys tee -o vsrc/xiangshan_ift.log    pift --verbose --liveness --ignore-ports clock,reset --vec_anno vsrc/XiangShan.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).vec
yosys tee -o vsrc/xiangshan_sram.log   anno_chisel_sram --verbose
yosys setattr -mod -set pift_ignore_module 1 XS_L2Top
yosys tee -o vsrc/xiangshan_cov.log    tsum --verbose

yosys opt -purge

yosys setattr -mod -set pift_ignore_module 0 XS_L2Top
yosys thook

yosys write_verilog -simple-lhs vsrc/XiangShan.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.ift.v
