TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build

FUZZ_SRC	=	$(SRC)/InstGenerator

TARGET_CORE	=	BOOM
SIM_MODE	?=	variant
SIMULATION_LABEL	?= 	swap_mem

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE ?= $(FUZZ_BUILD)/swap_mem.cfg

PREFIX ?= $(TARGET_CORE)
THREAD_NUM  ?= 	16

GEN_MODE = gen
BASIC_CONFIG = --rtl_sim=$(TOP) --rtl_sim_mode=vcs\
	--taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_$(TARGET_CORE)\
	--thread_num=$(THREAD_NUM)
FUZZ_MODE = fuzz $(BASIC_CONFIG)
WORK_MODE = 

do-gen: 	WORK_MODE += $(GEN_MODE)
do-fuzz: 	WORK_MODE += $(FUZZ_MODE)

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(BUILD)
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py\
		-I $(RAZZLE_DIR)/config/testcase/mem_init.hjson\
		-O $(BUILD)\
		--prefix $(PREFIX)\
		$(WORK_MODE)

vcs:
	make -C $(STARSHIP_DIR) vcs 

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

do-gen: 	fuzz
do-fuzz:	fuzz

# other

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

verdi:
	make -C $(STARSHIP_DIR) verdi

vlt:
	make -C $(STARSHIP_DIR) vlt

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(FUZZ_BUILD)/origin.dist

# utils

REPO_PATH = $(BUILD)/$(PREFIX).template_repo

compile: $(RAZZLE_DIR)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/offline_compiler.py -I $(STARSHIP_TESTCASE)

analysis:
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/fuzz_analysis.py \
		-I $(REPO_PATH)/trigger_iter_record \
		-O $(REPO_PATH)/trigger_analysis.md \
		--mode trigger

# draw coverage

cov_draw_time:	WORK_MODE += -m time
cov_draw_iter:	WORK_MODE += -m iter

cov_draw:
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/coverage_draw.py \
		-I $(REPO_PATH)/fuzz.log $(WORK_MODE)

cov_draw_iter: 	cov_draw
cov_draw_time:	cov_draw
