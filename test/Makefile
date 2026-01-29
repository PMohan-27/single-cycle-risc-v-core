
#default values
.DEFAULT_GOAL = all
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../rtl
PROJECT_SOURCES = cpu.v instruction_memory.v register_file.v PC.v control_unit.v ALU.v data_memory.v immediate_gen.v constants.vh
WAVES = 1

SIM_BUILD				= sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))


COMPILE_ARGS 		+= -I$(SRC_DIR)

TOPLEVEL=cpu_top 
COCOTB_TEST_MODULES=test_cpu


ALU:
	$(MAKE) TOPLEVEL=ALU COCOTB_TEST_MODULES=test_alu

CPU_TOP:
	$(MAKE) TOPLEVEL=cpu_top COCOTB_TEST_MODULES=test_cpu

DATA_MEM:
	$(MAKE) TOPLEVEL=data_mem COCOTB_TEST_MODULES=test_data_mem

CONTROL_UNIT:
	$(MAKE) TOPLEVEL=control_unit COCOTB_TEST_MODULES=test_control_unit


# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
