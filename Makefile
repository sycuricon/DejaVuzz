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

fuzz: $(RAZZLE_DIR) $(STARSHIP_DIR)/build
	mkdir -p $(FUZZ_BUILD)
	cd $(RAZZLE_DIR); \
	PYTHONPATH=`pwd` python3 razzle/main.py -I $(RAZZLE_DIR)/config/testcase/mem_init.hjson -O $(FUZZ_BUILD) $(FUZZ_MODE)
	
vcs:
	make -C $(STARSHIP_DIR) vcs STARSHIP_TESTCASE=$(FUZZ_CODE)

vcs-debug:
	make -C $(STARSHIP_DIR) vcs-debug STARSHIP_TESTCASE=$(FUZZ_CODE)

vcs-wave:
	make -C $(STARSHIP_DIR) vcs-wave STARSHIP_TESTCASE=$(FUZZ_CODE)

vlt:
	make -C $(STARSHIP_DIR) vlt STARSHIP_TESTCASE=$(FUZZ_CODE)

sim:
	$(STARSHIP_DIR)/build/spike/spike --log=./log --log-commits -l -d $(FUZZ_BUILD)/origin.dist

fuzz-physics: fuzz
fuzz-virtual: fuzz
fuzz-do-physics: fuzz
fuzz-do-virtual: fuzz
