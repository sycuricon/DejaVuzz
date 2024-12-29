ROOT				?= $(CURDIR)
TARGET_CORE			?=	BOOM
SIM_MODE			?=	variant
SIMULATION_LABEL	?= 	swap_mem
STARSHIP_DIR		=	$(ROOT)/starship-parafuzz
STARSHIP_CELL_DIR	=	$(ROOT)/starship-parafuzz-cellift
XIANGSHAN_DIR		=	$(ROOT)/xiangshan-dejavuzz


ifndef DEJAVUZZ
$(error $$DEJAVUZZ is undefined, please set $$DEJAVUZZ to your dejavuzz-toolchain)
endif

ifeq ($(TARGET_CORE),XiangShan)
    export XS_REPO_DIR = $(XIANGSHAN_DIR)
endif
export PATH = $(DEJAVUZZ)/bin:$(shell printenv PATH)
export STARSHIP_CORE = $(TARGET_CORE)
export SIMULATION_MODE = $(SIM_MODE)
export STARSHIP_TESTCASE ?= swap_mem.cfg

vcs:
	make -C $(STARSHIP_DIR) vcs 

vcs-dummy:
	make -C $(STARSHIP_DIR) vcs-dummy

vcs-cell:
	make -C $(STARSHIP_CELL_DIR) vcs 

vcs-debug-cell:
	make -C $(STARSHIP_CELL_DIR) vcs-debug 

vcs-dummy-cell:
	make -C $(STARSHIP_CELL_DIR) vcs-dummy

compile-xiangshan:
	make -C $(XIANGSHAN_DIR) clean
	cd $(XIANGSHAN_DIR); ./generate.sh

clean:
	make -C $(STARSHIP_CELL_DIR) clean
	make -C $(STARSHIP_DIR) clean
	make -C $(XIANGSHAN_DIR) clean
