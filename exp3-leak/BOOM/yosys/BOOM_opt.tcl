yosys read_verilog -sv vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.v
yosys read_verilog -sv yosys/blackbox.v
yosys read_verilog -sv vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).behav_srams.top.v

yosys hierarchy -top $::env(YOSYS_TOP)

yosys tee -o vsrc/boom_keep.log keep_chisel_signals --verbose

yosys proc
yosys pmuxtree
yosys bmuxmap
yosys opt -purge

yosys write_verilog -simple-lhs vsrc/BOOM.$::env(YOSYS_TOP).$::env(YOSYS_CONFIG).top.opt.v
