TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build
FUZZ_BUILD		:= $(BUILD)/fuzz_code

TARGET_CORE		?= XiangShan
SIM_MODE		?= variant
TEST_INPUT		?= $(FUZZ_BUILD)/Testbench
TEST_NAME		?= default

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE = $(TEST_INPUT)
export SIMULATION_LABEL = $(TEST_NAME)
export XS_REPO_DIR = /home/phantom/work/xiangshan-dejavuzz

FUZZ_MODE 	?=
fuzz-virtual: 		FUZZ_MODE += -V
fuzz-do-physics: 	FUZZ_MODE += --fuzz
fuzz-do-virtual: 	FUZZ_MODE += -V --fuzz
fuzz-do-virtual-debug: 	FUZZ_MODE += -V --fuzz --debug

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(FUZZ_MODE)

fuzz-physics: fuzz
fuzz-virtual: fuzz
fuzz-do-physics: fuzz
fuzz-do-virtual: fuzz
fuzz-do-virtual-debug: fuzz

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(FUZZ_BUILD)/origin.dist

export EXTRA_SIM_ARGS =

vcs:
	make -C $(STARSHIP_DIR) vcs

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

vcs-plot:
	make -C $(STARSHIP_DIR) plot_vcs_taint

vlt:
	make -C $(STARSHIP_DIR) vlt




