TOP				:= $(CURDIR)
STARSHIP_DIR	:= $(TOP)/starship-parafuzz
RAZZLE_DIR		:= $(TOP)/InstGenerator
BUILD			:= $(TOP)/build


FUZZ_SRC	=	$(SRC)/InstGenerator
FUZZ_BUILD	=	$(BUILD)/fuzz_code

FUZZ_CODE	=	$(FUZZ_BUILD)/Testbench

FUZZ_MODE = 

fuzz-virtual: 		FUZZ_MODE += -V
fuzz-do-physics: 	FUZZ_MODE += --fuzz
fuzz-do-virtual: 	FUZZ_MODE += -V --fuzz
fuzz-do-virtual-debug: 	FUZZ_MODE += -V --fuzz --debug

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(FUZZ_MODE)

export EXTRA_SIM_ARGS = +origin_dist=$(FUZZ_BUILD)/origin.dist +variant_dist=$(FUZZ_BUILD)/variant.dist +max-cycles=500

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

fuzz-physics: fuzz
fuzz-virtual: fuzz
fuzz-do-physics: fuzz
fuzz-do-virtual: fuzz
fuzz-do-virtual-debug: fuzz
