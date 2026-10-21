#for BSVTools
ifndef BLUEXLNX_MK_INCLUDED
BLUEXLNX_MK_INCLUDED := 1

BLUEXLNX_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
BLUEXLNX_SRC := $(BLUEXLNX_ROOT)/src
EXTRA_BSV_LIBS += $(BLUEXLNX_SRC)
VIVADO_INCLUDES += --includes $(BLUEXLNX_ROOT)/rtl

$(info Adding BlueXilinx from $(BLUEXLNX_SRC))

endif
