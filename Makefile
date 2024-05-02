TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build


FUZZ_SRC	=	$(SRC)/InstGenerator
FUZZ_BUILD	=	$(BUILD)/fuzz_code

TARGET_CORE	=	BOOM
SIM_MODE	=	variant
# SIM_MODE	=	normal

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE = $(FUZZ_BUILD)/swap_mem.cfg


FUZZ_CODE	=	$(FUZZ_BUILD)/Testbench

FUZZ_CODE = 
GEN_MODE = gen
STAGE1_MODE = stage1 --rtl_sim=$(TOP) --rtl_sim_mode=vcs\
	--taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_BOOM_variant/wave/swap_mem.cfg.taint\
	--repo_path=$(BUILD)/template_repo 

gen-do-physics: 	FUZZ_MODE += $(GEN_MODE)
gen-do-virtual: 	FUZZ_MODE += -V $(GEN_MODE)
stage1-do-physics: 	FUZZ_MODE += $(STAGE1_MODE)
stage1-do-virtual:	FUZZ_MODE += -V $(STAGE1_MODE)

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	rm -rf $(FUZZ_BUILD)
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(FUZZ_MODE)

vcs:
	make -C $(STARSHIP_DIR) vcs

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

vlt:
	make -C $(STARSHIP_DIR) vlt

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(FUZZ_BUILD)/origin.dist

gen-do-physics: 	fuzz
gen-do-virtual: 	fuzz
stage1-do-physics: 	fuzz
stage1-do-virtual:	fuzz
