TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build


FUZZ_SRC	=	$(SRC)/InstGenerator

TARGET_CORE	=	BOOM
SIM_MODE	?=	variant
# SIM_MODE	=	normal

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE = $(FUZZ_BUILD)/swap_mem.cfg

FUZZ_BUILD	=	$(BUILD)/$(TARGET_CORE).fuzz_code

GEN_MODE = gen
FUZZ_MODE = fuzz --rtl_sim=$(TOP) --rtl_sim_mode=vcs\
	--taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_BOOM\
	--repo_path=$(BUILD)/$(TARGET_CORE).template_repo
WORK_MODE = 

gen-do-physics: 	WORK_MODE += $(GEN_MODE)
gen-do-virtual: 	WORK_MODE += -V $(GEN_MODE)
fuzz-do-physics: 	WORK_MODE += $(FUZZ_MODE)
fuzz-do-virtual:	WORK_MODE += -V $(FUZZ_MODE)

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	rm -rf $(FUZZ_BUILD)
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(WORK_MODE)

vcs:
	make -C $(STARSHIP_DIR) vcs

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

verdi:
	make -C $(STARSHIP_DIR) verdi

vlt:
	make -C $(STARSHIP_DIR) vlt

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(FUZZ_BUILD)/origin.dist

gen-do-physics: 	fuzz
gen-do-virtual: 	fuzz
fuzz-do-physics: 	fuzz
fuzz-do-virtual:	fuzz
