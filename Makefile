TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build

SIM_MODE	?=	variant

FUZZ_BUILD	=	$(BUILD)/$(TARGET_CORE).fuzz_code

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE ?= $(FUZZ_BUILD)/swap_mem.cfg

GEN_MODE = gen
BASIC_CONFIG = --rtl_sim=$(TOP) --rtl_sim_mode=vcs\
	--taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_BOOM\
	--repo_path=$(BUILD)/$(TARGET_CORE).template_repo
FUZZ_MODE = fuzz $(BASIC_CONFIG)
ITER_NUM ?= 0
LOAD_MODE = load $(BASIC_CONFIG)
TRIGGER_TEST = trigger_test $(BASIC_CONFIG)
FRONT_END_TEST = front_end_test $(BASIC_CONFIG)
WORK_MODE = 

gen-do-physics: 	WORK_MODE += $(GEN_MODE)
gen-do-virtual: 	WORK_MODE += -V $(GEN_MODE)
fuzz-do-physics: 	WORK_MODE += $(FUZZ_MODE)
fuzz-do-virtual:	WORK_MODE += -V $(FUZZ_MODE)
load-do-physics: 	WORK_MODE += $(LOAD_MODE)
load-do-virtual:	WORK_MODE += -V $(LOAD_MODE)
trigger-test-do-physics:	WORK_MODE += $(TRIGGER_TEST)
trigger-test-do-virtual:	WORK_MODE += -V $(TRIGGER_TEST)
front-end-test-do-physics:	WORK_MODE += $(FRONT_END_TEST)
front-end-test-do-virtual:	WORK_MODE += -V $(FRONT_END_TEST)

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(WORK_MODE)

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
load-do-physics: 	fuzz
load-do-virtual:	fuzz
trigger-test-do-physics: 	fuzz
trigger-test-do-virtual: 	fuzz
front-end-test-do-physics:	fuzz
front-end-test-do-virtual:	fuzz
