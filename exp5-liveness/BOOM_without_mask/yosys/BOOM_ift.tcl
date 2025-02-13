yosys read_verilog -sv vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.opt.v
yosys read_verilog -sv yosys/blackbox.v

yosys hierarchy -top $::env(YOSYS_TOP)

yosys proc
yosys memory_collect
yosys opt -purge

# yosys tee -o vsrc/sink_summary.log tsink --verbose --top $::env(YOSYS_TOP)

yosys tee -o vsrc/boom_ift.log     pift --verbose --liveness --ignore-ports clock,reset --vec_anno vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).vec
yosys tee -o vsrc/boom_sram.log    anno_chisel_sram --verbose
yosys tee -o vsrc/boom_cov.log     tsum --verbose

yosys opt -purge

yosys thook

yosys write_verilog -simple-lhs vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.ift.v
