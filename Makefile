ROOT				?= $(CURDIR)
STARSHIP_DIR		:= $(ROOT)/starship-parafuzz
RAZZLE_DIR			:= $(ROOT)/InstGenerator
REGRESS_DIR			:= $(ROOT)/riscv-tests-parafuzz
BUILD				:= $(ROOT)/build
REPO_PATH 			:= $(BUILD)/$(PREFIX).template_repo

TARGET_CORE			?=	BOOM
SIM_MODE			?=	variant
SIMULATION_LABEL	?= 	swap_mem

ifeq ($(TARGET_CORE),XiangShan)
    export XS_REPO_DIR = $(ROOT)/xiangshan-dejavuzz
endif

export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE ?= swap_mem.cfg

PREFIX 				?= $(TARGET_CORE)
THREAD_NUM  		?= 16

GEN_MODE 			:= gen 
BASIC_CONFIG 		:= --rtl_sim=$(ROOT) --rtl_sim_mode=vcs	\
					   --taint_log=$(STARSHIP_DIR)/build/vcs/starship.asic.StarshipSimMiniConfig_$(TARGET_CORE)	\
					   --thread_num=$(THREAD_NUM)
FUZZ_MODE 			:= fuzz $(BASIC_CONFIG)
WORK_MODE 			:= 

do-gen: 	WORK_MODE += $(GEN_MODE)
do-fuzz: 	WORK_MODE += $(FUZZ_MODE) --fuzz_mode=leak
do-fuzz-trigger:	WORK_MODE += $(FUZZ_MODE) --fuzz_mode=trigger
do-fuzz-access:		WORK_MODE += $(FUZZ_MODE) --fuzz_mode=access

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(BUILD)
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py				\
		-I $(RAZZLE_DIR)/config/testcase/mem_init.hjson			\
		-O $(BUILD) --prefix $(PREFIX) --core $(TARGET_CORE)	\
		$(WORK_MODE)

vcs:
	make -C $(STARSHIP_DIR) vcs 

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave

do-gen: 	fuzz
do-fuzz:	fuzz
do-fuzz-trigger:	fuzz
do-fuzz-access:		fuzz

# other

# todo: replace this with the real target binary
vcs-dummy:
	make -C $(STARSHIP_DIR) vcs-dummy

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug

verdi:
	make -C $(STARSHIP_DIR) verdi

vlt:
	make -C $(STARSHIP_DIR) vlt

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(STARSHIP_TESTCASE)

# utils
compile: $(RAZZLE_DIR)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py						\
		-I $(RAZZLE_DIR)/config/testcase/mem_init.hjson			\
		-O $(BUILD) --prefix $(PREFIX) --core=$(TARGET_CORE)	\
		compile --mem_cfg $(STARSHIP_TESTCASE)

analysis:
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/main.py 				\
		-I $(RAZZLE_DIR)/config/testcase/mem_init.hjson			\
		-O $(BUILD) --prefix $(PREFIX) --core=$(TARGET_CORE)	\
		analysis --thread_num $(THREAD_NUM)

# draw coverage
cov_draw_time:	WORK_MODE += -m time
cov_draw_iter:	WORK_MODE += -m iter

cov_draw:
	cd $(RAZZLE_DIR); \
	time PYTHONPATH=`pwd` python3 razzle/coverage_draw.py		\
		-I $(REPO_PATH)/fuzz.log $(WORK_MODE)

cov_draw_iter: 	cov_draw
cov_draw_time:	cov_draw

# regress test

REGRESS_TARGET	:=	spectre-v1			\
					spectre-v2			\
					spectre-v3			\
					spectre-v4			\
					spectre-rsb			\
					spectre-mds			\
					spectre-rewind		\
					spectre-frozen		\
					spectre-ctrl-failed	\
					spectre-specret		\
					spectre-speccall

regress: vcs-dummy
	mkdir -p $(BUILD)/regress
	for guess in 100 101; do \
		for target in $(REGRESS_TARGET); do \
        	python3 scripts/gen_cfg.py \
                --dut_init_file $(REGRESS_DIR)/build/benchmarks/$${target}.guess$${guess}.riscv.bin \
                --vnt_init_file $(REGRESS_DIR)/build/benchmarks/$${target}.guess$${guess}.riscv.variant.bin \
                --output_file $(BUILD)/regress/$${target}.$${guess}.cfg ;	\
			make -C $(STARSHIP_DIR) vcs STARSHIP_TESTCASE=$(BUILD)/regress/$${target}.$${guess}.cfg SIMULATION_LABEL=$${target}.$${guess} & \
		done; \
	done
