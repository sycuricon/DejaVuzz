# Starship Project
# Copyright (C) 2020-2022 by phantom
# Email: phantom@zju.edu.cn
# This file is under MIT License, see https://www.phvntom.tech/LICENSE.txt

TOP		:= $(CURDIR)
BUILD	:= $(TOP)/build

SIMULATION_MODE 	?= variant
SIMULATION_LABEL 	?= swap_mem
STARSHIP_CORE 		?= BOOM
STARSHIP_TESTCASE 	?= swap_mem.cfg

STARSHIP_TH 	?= starship.asic.TestHarness
STARSHIP_TOP	?= starship.asic.StarshipSimTop
STARSHIP_CONFIG	?= starship.asic.StarshipSimMiniConfig
ROCKET_OUTPUT	:= $(STARSHIP_CORE).$(lastword $(subst ., ,$(STARSHIP_TOP))).$(lastword $(subst ., ,$(STARSHIP_CONFIG)))

SIM_DIR			:= $(TOP)/testbench
SRC_DIR			:= $(TOP)/vsrc
TB_TOP			?= Testbench

ifndef DEJAVUZZ
$(error $$DEJAVUZZ is undefined, please set $$DEJAVUZZ to your dejavuzz-toolchain)
endif

GCC_VERSION	:= $(word 1, $(subst ., ,$(shell gcc -dumpversion)))
ifeq ($(shell echo $(GCC_VERSION)\>=10 | bc ),0)
SCL_PREFIX := source scl_source enable devtoolset-10 &&
endif

#######################################
#
#              Yosys
#
#######################################

YOSYS_SRC	:= $(TOP)/yosys
YOSYS_TOP = $(lastword $(subst ., ,$(STARSHIP_TOP)))
YOSYS_CONFIG = $(lastword $(subst ., ,$(STARSHIP_CONFIG)))
export YOSYS_TOP YOSYS_CONFIG

YOSYS_TOP_VERILOG_OPT	:= $(SRC_DIR)/$(ROCKET_OUTPUT).top.opt.v
YOSYS_TOP_VERILOG_IFT	:= $(SRC_DIR)/$(ROCKET_OUTPUT).top.ift.v
YOSYS_TOP_VERILOG_VEC	:= $(SRC_DIR)/$(ROCKET_OUTPUT).vec

$(YOSYS_TOP_VERILOG_OPT):
	$(YOSYS_SRC)/$(STARSHIP_CORE)_vec_collect.sh
	$(DEJAVUZZ)/bin/yosys -c $(YOSYS_SRC)/$(STARSHIP_CORE)_opt.tcl

$(YOSYS_TOP_VERILOG_IFT): $(YOSYS_TOP_VERILOG_OPT)
	$(DEJAVUZZ)/bin/yosys -c $(YOSYS_SRC)/$(STARSHIP_CORE)_ift.tcl
	sed -i "s/.IFT_RULE(\"REPLACE_ME_TO_IFT_RULE\")/.IFT_RULE(IFT_RULE)/g" $(YOSYS_TOP_VERILOG_IFT)
	sed -i "/module/{:a;N;/);/!ba;s/\(module[^\)]*\));/&\nparameter string IFT_RULE = \"none\";/}" $(YOSYS_TOP_VERILOG_IFT)

#######################################
#
#              vcs
#
#######################################

all: vcs

CHISEL_DEFINE 	:= +define+PRINTF_COND=$(TB_TOP).printf_cond	\
			   	   +define+STOP_COND=!$(TB_TOP).reset

SIM_SRC_C		:= $(SIM_DIR)/probebuffer.cc		\
				   $(SIM_DIR)/mem_swap.cc 			\
			   	   $(SIM_DIR)/tb_mem.cc
SIM_SRC_V		:= $(SIM_DIR)/tty.v					\
				   $(SIM_DIR)/probebuffer.v			\
				   $(SIM_DIR)/archstep.v			\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).behav_srams.testharness.v	\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).behav_srams.top.v			\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).testharness.v				\
				   $(SRC_DIR)/plusarg_reader.v
SIM_DEFINE		:= +define+MODEL=$(STARSHIP_TH)			\
			   	   +define+CLOCK_PERIOD=1.0	   			\
				   +define+TARGET_$(STARSHIP_CORE)

ifeq ($(SIMULATION_MODE),cosim)
SIM_SRC_C		+= $(SIM_DIR)/spike_difftest.cc		\
				   $(SPIKE_LIB)
SIM_SRC_V		+= $(SIM_DIR)/Testbench.v			\
				   $(SIM_DIR)/spike_difftest.v		\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).top.v
SIM_DEFINE		+= +define+COVERAGE_SUMMARY +define+COSIMULATION
else ifeq ($(SIMULATION_MODE),robprofile)
SIM_SRC_V		+= $(SIM_DIR)/Testbench.v			\
				   $(SIM_DIR)/robprofile.v			\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).top.v
SIM_DEFINE		+= +define+ROBPROFILE
else ifeq ($(SIMULATION_MODE),taint)
SIM_SRC_C		+= $(SIM_DIR)/divaift_lib.cc
SIM_SRC_V		+= $(SIM_DIR)/Testbench.ift.v		\
				   $(SIM_DIR)/divaift_lib.v			\
				   $(SIM_DIR)/robprofile.v			\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).top.ift.v
SIM_DEFINE		+= +define+HASTAINT
else ifeq ($(SIMULATION_MODE),variant)
SIM_SRC_C		+= $(SIM_DIR)/divaift_lib.cc
SIM_SRC_V		+= $(SIM_DIR)/Testbench.ift.v		\
				   $(SIM_DIR)/divaift_lib.v			\
				   $(SIM_DIR)/robprofile.v			\
				   $(SRC_DIR)/$(ROCKET_OUTPUT).top.ift.v
SIM_DEFINE		+= +define+HASVARIANT
else
SIM_SRC_V		+= $(SIM_DIR)/Testbench.v
endif

VCS_OUTPUT	:= $(BUILD)/vcs/$(STARSHIP_CORE)_$(SIMULATION_MODE)
VERDI_OUTPUT:= $(BUILD)/verdi
VCS_BUILD	:= $(VCS_OUTPUT)/build
VCS_LOG		:= $(VCS_OUTPUT)/log
VCS_WAVE	:= $(VCS_OUTPUT)/wave

VCS_TARGET	:= $(VCS_BUILD)/$(TB_TOP)
VCS_INCLUDE	:= $(SRC_DIR)+$(SIM_DIR)
VCS_CFLAGS	:= -std=c++17 -I$(SRC_DIR)

VCS_SRC_C	:= $(SIM_SRC_C)
VCS_SRC_V	:= $(SIM_SRC_V)
VCS_DEFINE	:= $(SIM_DEFINE)								\
			   +define+TOP_DIR=\"$(VCS_OUTPUT)\"			\
			   +define+DEBUG_FSDB

VCS_PARAL_COM	:= -j$(shell nproc) # -Xkeyopt=rtopt -fgp 
VCS_PARAL_RUN	:= # -fgp=num_threads:4,num_fsdb_threads:1 # -fgp=num_cores:$(shell nproc),percent_fsdb_cores:30

VCS_OPTION	:= -quiet -notice -line +rad -full64 +nospecify +notimingcheck -deraceclockdata 		\
			   -sverilog +systemverilogext+.sva+.pkg+.sv+.SV+.vh+.svh+.svi+ -assert svaext 			\
			   +vcs+lic+wait +vcs+initreg+random +v2k -debug_acc+all -timescale=1ns/10ps 			\
			   +incdir+$(VCS_INCLUDE) $(VCS_PARAL_COM) -CFLAGS "$(VCS_CFLAGS)" -lconfig++			\
			   $(CHISEL_DEFINE) $(VCS_DEFINE)
VCS_SIM_OPTION	:= +vcs+initreg+0 $(VCS_PARAL_RUN) +testcase=$(STARSHIP_TESTCASE) +label=$(SIMULATION_LABEL)\
	+secret_addr=2160066560 +secret_size=1024

vcs-wave: 		VCS_SIM_OPTION += +dump +uart_tx=0
vcs-debug: 		VCS_SIM_OPTION += +verbose +uart_tx=0

$(VCS_TARGET): $(VCS_SRC_V) $(VCS_SRC_C)
	mkdir -p $(VCS_BUILD) $(VCS_LOG) $(VCS_WAVE)
	cd $(VCS_OUTPUT); vcs $(VCS_OPTION) -l $(VCS_LOG)/vcs.log -top $(TB_TOP) \
		$(VCS_SRC_V) $(VCS_SRC_C) $(VERILOG_SRC) -o $@

vcs-dummy: $(VCS_TARGET)

vcs: $(VCS_TARGET)
	mkdir -p $(VCS_LOG) $(VCS_WAVE)
	cd $(VCS_OUTPUT); time \
	$(VCS_TARGET) -quiet +ntb_random_seed_automatic -no_save -l $(VCS_LOG)/sim.log  \
		$(VCS_SIM_OPTION) $(EXTRA_SIM_ARGS) 2>&1 | tee /tmp/rocket.log; exit "$${PIPESTATUS[0]}";

vcs-wave vcs-debug: vcs

verdi:
	mkdir -p $(VERDI_OUTPUT)
	touch $(VERDI_OUTPUT)/signal.rc
	cd $(VERDI_OUTPUT); \
	verdi -$(VCS_OPTION) -q -ssy -ssv -ssz -autoalias \
		-ssf $(VCS_WAVE)/$(SIMULATION_LABEL).fsdb -sswr $(VERDI_OUTPUT)/signal.rc \
		-logfile $(VCS_LOG)/verdi.log -top $(TB_TOP) -f $(ROCKET_INCLUDE) $(VCS_SRC_V) &

clean:
	rm -rf $(BUILD) *log.txt $(SRC_DIR)/*.log $(YOSYS_TOP_VERILOG_OPT) $(YOSYS_TOP_VERILOG_IFT) $(YOSYS_TOP_VERILOG_VEC)