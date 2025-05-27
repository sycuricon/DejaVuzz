ROOT				?= $(CURDIR)
TARGET_CORE			?=	BOOM
SIM_MODE			?=	variant
SIMULATION_LABEL	?= 	swap_mem
STARSHIP_DIR		=	$(ROOT)/starship-dejavuzz

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE ?= swap_mem.cfg

vcs:
	make -C $(STARSHIP_DIR) vcs 

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

vcs-dummy:
	make -C $(STARSHIP_DIR) vcs-dummy

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

verdi:
	make -C $(STARSHIP_DIR) verdi


#######################################
#
#              FUZZ
#
#######################################

RAZZLE_DIR			= $(ROOT)/razzle
BUILD				= $(ROOT)/build
PREFIX 				?= $(TARGET_CORE)
THREAD_NUM  		?= 16
RAND_SEED			?= 0

GEN_MODE 			:= gen 
BASIC_CONFIG 		:= --rtl_sim=$(ROOT) --rtl_sim_mode=vcs	\
					   --taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_$(TARGET_CORE)	\
					   --thread_num=$(THREAD_NUM)
FUZZ_MODE 			:= fuzz $(BASIC_CONFIG)
WORK_MODE 			:= -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson			\
		-O $(BUILD) --prefix $(PREFIX) --core $(TARGET_CORE) --rand_seed $(RAND_SEED)

do-gen: 	WORK_MODE += $(GEN_MODE)
do-fuzz: 	WORK_MODE += $(FUZZ_MODE) --fuzz_mode=leak
do-fuzz-no-coverage: 	WORK_MODE += $(FUZZ_MODE) --fuzz_mode=no_coverage
do-fuzz-trigger:	WORK_MODE += $(FUZZ_MODE) --fuzz_mode=trigger
do-fuzz-access:		WORK_MODE += $(FUZZ_MODE) --fuzz_mode=access

fuzz: $(RAZZLE_DIR)
	mkdir -p $(BUILD)
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py				\
		$(WORK_MODE)

do-gen: 	fuzz
do-fuzz:	fuzz
do-fuzz-no-coverage:	fuzz
do-fuzz-trigger:	fuzz
do-fuzz-access:		fuzz

analysis:
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py $(WORK_MODE) 	\
		analysis --thread_num $(THREAD_NUM)
