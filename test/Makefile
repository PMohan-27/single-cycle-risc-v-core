
#default values
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../rtl
PROJECT_SOURCES = cpu.sv instruction_memory.sv register_file.sv PC.sv control_unit.sv ALU.sv
WAVES = 1

SIM_BUILD				= sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))


COMPILE_ARGS 		+= -I$(SRC_DIR)

TOPLEVEL = cpu_top

# MODULE is the basename of the Python test file
MODULE = test


# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
