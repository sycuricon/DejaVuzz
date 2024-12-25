ROOT				?= $(CURDIR)
TARGET_CORE			?=	BOOM
SIM_MODE			?=	variant
SIMULATION_LABEL	?= 	swap_mem
STARSHIP_DIR		=	$(ROOT)/$(TARGET_CORE)

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
