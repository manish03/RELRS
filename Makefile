# ////////////////////////////////////////////////////////////////////////////////
# //# Copyright (c) 2018 Secantec
# //# No Permission to modify and distribute this program
# //# even if this copyright message remains unaltered.
# //#
# //# Author: Secantec 27 April, 2018
# //@ printf("//# \$Id: \$");
# //#
# //# Revision History
# //#       MM      17  April, 2018    Initial release
# //#
# ////////////////////////////////////////////////////////////////////////////////

USES_DPI = 1
ifdef UVM_NO_DPI
  USES_DPI=0
endif

#---------------------------------------------------------------
# Define Variables
#---------------------------------------------------------------

XFER = 120000
BIN = ../bin
UVM_TEST = fifoRdWrTest
ENCRYPT ?=0
UVM_VERBOSITY = UVM_DEBUG
MTI_HOME ?=
QUESTA_HOME = $(MTI_HOME)

UVM_HOME ?= $(MTI_HOME)/verilog_src/uvm-1.1d
MIN_GCC ?= $(MTI_HOME)
#/questasim-gcc-4.5.0-mingw64
LOCAL_LIB_DIR = libcc

LIBDIR  = $(MTI_HOME)/uvm-1.1d/win64
GCC     = $(MTI_HOME)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/bin/gcc
#GCC     = gcc
#GCC     = ../../../questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/bin/gcc.exe
TEST    = /usr/bin/test
BITS    ?= Win
BITS    ?= 32
LIBNAME = uvm_dpi
DPI_SRC = $(UVM_HOME)/src/dpi/uvm_dpi.cc
WIN_GCC = $(MTI_HOME)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/bin/g++.exe
GENSRCDIR=genSrcRs
RELDIR = RELRS
MANGLEDIR=$(RELDIR)/mangleRS
TST ?= 0
TIMEOUTFEC ?= 0
MANGLE_RUN ?= 0
# 1 - generate mangle
# 2 - run mangle
REL_RUN ?= 0
ERAS ?= 0
ERRS ?= 0
RELENCDIR = RELENC
VLOG_OPTS ?=
MYSEED ?= 800600
DUMP ?= 0
MAKEFILE1 = Makefile
#SVP_CLEAN = status=$$?; /bin/rm -rf _Inline; exit $$status
SVP_CLEAN = 

.NOTPARALLEL: build_sv old_mangle


GCCCMD =  $(GCC) \
        -m$(BITS) \
        -fPIC \
        -DQUESTA \
        -g \
        -W \
        -shared \
        -x c \
        -I$(MTI_HOME)/include \
        $(DPI_SRC) \
        -o $(LIBDIR)/$(LIBNAME).so

GCC_WINCMD = \
        $(WIN_GCC) \
        -g \
        -DQUESTA \
        -W \
        -shared \
        -Bsymbolic \
        -x c \
        -I$(MTI_HOME)/include \
        -I $(MTI_HOME)/gcc-4.5.0-mingw64/include \
	-I../../../questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/include \
        $(DPI_SRC) \
        -o $(LIBDIR)/$(LIBNAME).dll \
	$(MTI_HOME)/win32/mtipli.dll -lregex


VLIB =  vlib work

vlog =  vlog  \
        -lint \
        -timescale "1ns/1ns" \
        $(DPILIB_vlog_OPT) \
        $(vlog_OPT) \
        $(OPT_C) \
	+define+QUESTA \
	+define+SIMULATION \
        -mfcu \
        -suppress 2181 \
        +acc=rmb \
        -writetoplevels questa.tops \
        +incdir+$(UVM_HOME)/src \
        $(UVM_HOME)/src/uvm.sv


VSIM =  vsim \
        $(DPILIB_VSIM_OPT) \
        $(VSIM_OPT) \
        $(OPT_R) \
        -c \
        -do "run -all; q" \
        -l questa.log \
        -f questa.tops

IVERILOG ?= iverilog
VVP ?= vvp
IV_OUT ?= iv_sim.vvp
ifeq ($(DUMP),1)
IV_DUMP_DEFINE = -DIVERILOG_DUMP
else
IV_DUMP_DEFINE =
endif

N_ERRS = 0
N_FATALS = 0

CHECK = \
	@$(TEST) \( `grep -c 'UVM_ERROR :    $(N_ERRS)' questa.log` -eq 1 \) -a \
		 \( `grep -c 'UVM_FATAL :    $(N_FATALS)' questa.log` -eq 1 \)

include RScommon.mk
#---------------------------------------------------------------
# If USES_DPI is set, enables compilation and loading of DPI
# libraries. Enabling DPI adds +acc on command line, which
# may adversely affect simulator performance.
#---------------------------------------------------------------

ifeq ($(USES_DPI),1)
  DPILIB_vlog_OPT = 
  DPILIB_VSIM_OPT = -sv_lib $(LIBDIR)/uvm_dpi 
  DPILIB_TARGET = dpi_lib$(BITS)
else
  DPILIB_vlog_OPT = +define+UVM_NO_DPI 
  DPILIB_VSIM_OPT = 
  DPILIB_TARGET =
endif
  


SRC_FILESr = \
	$(GENSRCDIR)/sntc_lib.svp.sv   \
	$(GENSRCDIR)/sntc_rs_encode.svp.sv   \
	$(GENSRCDIR)/sntc_rs_gen_poly.svp.sv   \
	$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv   \
	$(GENSRCDIR)/sntc_chien.1.svp.sv   \
	$(GENSRCDIR)/sntc_chien.elem.svp.sv \
	$(GENSRCDIR)/sntc_chien.mult.svp.sv \
	$(GENSRCDIR)/sntc_chien.pow.svp.sv \
	$(GENSRCDIR)/sntc_forney.svp.sv   \
	$(GENSRCDIR)/sntc_rs_syn.svp.sv   \
	$(GENSRCDIR)/sntc_rs_decoder.svp.sv \
	$(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv \
	$(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv \
	$(GENSRCDIR)/sntc_rs_tb.svp.sv

	#$(GENSRCDIR)/sntc_rs_encode_tb.svp.sv   \
	#$(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv   \
	#$(GENSRCDIR)/sntc_rs_syn_tb.svp.sv   \
	#$(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv   \
	#$(GENSRCDIR)/sntc_chien_tb.svp.sv   \
	#$(GENSRCDIR)/sntc_rs_forney_tb.svp.sv   \


SRC_FILESo = \
	../$(RELDIR)/sntc_lib.svp.o.sv   \
	../$(RELDIR)/sntc_rs_encode.svp.o.sv   \
	../$(RELDIR)/sntc_rs_gen_poly.svp.o.sv   \
	../$(RELDIR)/sntc_rs_berlekamp.1.svp.o.sv   \
	../$(RELDIR)/sntc_chien.1.svp.o.sv   \
	../$(RELDIR)/sntc_chien.elem.svp.sv \
	../$(RELDIR)/sntc_chien.mult.svp.sv \
	../$(RELDIR)/sntc_chien.pow.svp.sv \
	../$(RELDIR)/sntc_forney.svp.o.sv   \
	../$(RELDIR)/sntc_rs_syn.svp.o.sv   \
	../$(RELDIR)/sntc_rs_decoder.svp.sv \
	../$(RELDIR)/sntc_rs_decoder_wrap.svp.sv \
	../$(RELDIR)/sntc_rs_encode_wrap.svp.sv \
	../$(RELDIR)/sntc_rs_tb.svp.sv

	#$(RELDIR)/sntc_rs_encode_tb.svp.sv   \
	#$(RELDIR)/sntc_rs_gen_poly_tb.svp.sv   \
	#$(RELDIR)/sntc_rs_syn_tb.svp.sv   \
	#$(RELDIR)/sntc_rs_berlekamp_tb.svp.sv   \
	#$(RELDIR)/sntc_chien_tb.svp.sv   \
	#$(RELDIR)/sntc_rs_forney_tb.svp.sv

SRC_FILESosvp = \
	../$(RELENCDIR)/sntc_lib.svp.svp   \
	../$(RELENCDIR)/sntc_rs_encode.svp.svp   \
	../$(RELENCDIR)/sntc_rs_gen_poly.svp.svp   \
	../$(RELENCDIR)/sntc_rs_berlekamp.1.svp.svp   \
	../$(RELENCDIR)/sntc_chien.1.svp.svp   \
	../$(RELENCDIR)/sntc_chien.elem.svp.svp \
	../$(RELENCDIR)/sntc_chien.mult.svp.svp \
	../$(RELENCDIR)/sntc_chien.pow.svp.svp \
	../$(RELENCDIR)/sntc_forney.svp.svp   \
	../$(RELENCDIR)/sntc_rs_syn.svp.svp   \

ifeq ($(MANGLE_RUN),1)
  SRC_FILES = $(SRC_FILESo)
else ifeq ($(MANGLE_RUN),2)
  SRC_FILES = $(SRC_FILESosvp)
  VLOG_OPTS =  +define+ENCRYPT
else
  SRC_FILES = $(SRC_FILESr)
  VLOG_OPTS = +protect
endif
#---------------------------------------------------------------
# Define Targets
#
# vlog  and vsim targets defined in individual examples
#---------------------------------------------------------------


help: 
	@echo "Usage:  make -f Makefile.questa [target(s)]"
	@echo ""
	@echo "Typical: make -f Makefile.questa all"
	@echo ""
	@echo "where target is any of"
	@echo ""
	@echo "  dpi_lib     - compile DPI lib (use BITS=XX, def=32)"
	@echo "  dpi_lib32   - compile DPI lib for 32-bit Linux (BITS=32)"
	@echo "  dpi_lib64   - compile DPI lib for 64-bit Linux (BITS=64)"
	@echo "  dpi_libWin  - compile DPI lib for Windows"
	@echo ""
	@echo "  clean       - removes all derived files"
	@echo "  vlib        - creates work library"
	@echo "  prepare     - invokes clean, vlib, and dpi_lib targets"
	@echo ""
	@echo "When this makefile is included by a Makefile from an example"
	@echo "sub-directory, additional targets should be available:"
	@echo ""
	@echo "  all       - invokes targets prepare, vlog +protect  , and vsim"
	@echo "  vlog      - invokes the vlog +protect   compiler"
	@echo "  vsim      - invokes the vsim simulator"
	@echo ""
	@echo "Variables: specify any of the following on the make command line"
	@echo ""
	@echo "  UVM_HOME  - root directory of the UVM library (default:..)"
	@echo "  UVM_VERBOSITY - verbosity level for vsim (default:UVM_MEDIUM)"
	@echo "  BITS      - the bus architecture: 32 or 64 (default:32)"
	@echo "  LIBNAME   - the root name of the dpi library (default:uvm_dpi)"
	@echo "  LIBDIR    - the location to put the dpi lib (default:UVM_HOME/lib)"
	@echo ""

prepare: clean vlib $(DPILIB_TARGET)


dpi_lib:
	mkdir -p $(LIBDIR)
	$(GCCCMD)

dpi_libWin:
	mkdir -p $(LIBDIR)
	$(GCC_WINCMD)

dpi_lib32:
	make -f Makefile.questa BITS=32 dpi_lib

dpi_lib64:
	make -f Makefile.questa LIBNAME=uvm_dpi BITS=64 dpi_lib

vlib: $(DPILIB_TARGET)
	vlib work

#clean:
#	rm -rf *~ work vsim.wlf* *.log questa.tops transcript *.vstf



comp:
	vlog +protect   

worklib:
	vlib work

compile:  test.sv foreign.c
	#vlog +protect   test.sv -dpiheader dpi_types.h  \
        foreign.c

optimize:
	vopt +acc test -o opt_test

#sim:
#	vsim opt_test

all: worklib compile optimize sim

clean:
	rm -rf work transcript vsim.wlf dpi_types.h


        #$(UVM_HOME)/src/dpi/uvm_dpi.cc  \

foreign: foreign.c
	 $(GCC) -I$(QUESTA_HOME)/include -shared -g -o foreign.dll foreign.c

foreign_32: foreign.c
	 $(GCC) -I$(QUESTA_HOME)/include -shared -fPIC -m32 -g -o foreign.dll foreign.c

rs.mod_windows: rs.mod.c
	 if [ ! -d "libcc" ]; then  \
		 mkdir libcc;  \
	 fi
	 if [ -f "$(LOCAL_LIB_DIR)/rs.mod.dll" ]; then  \
	 	/bin/rm -rf $(LOCAL_LIB_DIR)/rs.mod.dll;  \
	 fi
	 #WORKS# $(GCC) -I$(QUESTA_HOME)/include -shared -g -o $(LOCAL_LIB_DIR)/rs.mod.dll rs.mod.c -lmtipli -L$(QUESTA_HOME)/win64 -DDPI_EN

build_sv: \
cleandir \
setup \
runC \
$(GENSRCDIR)/sntc_lib.svp.sv            \
$(GENSRCDIR)/sntc_rs_encode.svp.sv            \
$(GENSRCDIR)/sntc_rs_gen_poly.svp.sv            \
$(GENSRCDIR)/sntc_rs_syn.svp.sv               \
$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv           \
$(GENSRCDIR)/sntc_chien.1.svp.sv        \
$(GENSRCDIR)/sntc_chien.elem.svp.sv \
$(GENSRCDIR)/sntc_chien.mult.svp.sv \
$(GENSRCDIR)/sntc_chien.pow.svp.sv \
$(GENSRCDIR)/sntc_forney.svp.sv              \
$(GENSRCDIR)/sntc_rs_decoder.svp.sv \
$(GENSRCDIR)/sntc_rs_tb.svp.sv \
$(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv \
$(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv

old_mangle: \
cleandir \
$(GENSRCDIR)/sntc_lib.svp.svp            \
$(GENSRCDIR)/sntc_rs_encode.svp.svp            \
$(GENSRCDIR)/sntc_rs_gen_poly.svp.svp            \
$(GENSRCDIR)/sntc_rs_syn.svp.svp               \
$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.svp           \
$(GENSRCDIR)/sntc_chien.1.svp.svp        \
$(GENSRCDIR)/sntc_forney.svp.svp              \
$(GENSRCDIR)/sntc_rs_decoder.svp.svp           \
$(GENSRCDIR)/sntc_rs_tb.svp.svp           \
$(GENSRCDIR)/sntc_rs_ee_tb.svp.sv            \
copy_toMangleGENSRCDIR  \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_lib.svp.sv            \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_encode.svp.sv            \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_gen_poly.svp.sv            \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_syn.svp.sv               \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv           \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_chien.1.svp.sv        \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_forney.svp.sv              \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_decoder.svp.sv           \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_tb.svp.sv           \
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_ee_tb.svp.sv                \
copy_toGENSRCDIR                                  




#$(MANGLEDIR)o/rsSyn : $(GENSRCDIR)/sntc_rs_syn.svp.sv $(GENSRCDIR)/rsSyn/*.sv rsvdWords.rs.txt
#	 python3  $(BIN)/obfs.py  -t verilog $(GENSRCDIR)/rsSyn      $(MANGLEDIR)o/rsSyn      rsvdWords.rs.txt

$(MANGLEDIR)o/sntc_lib.svp.o.sv :  $(GENSRCDIR)/sntc_lib.svp.sv rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_lib.svp.sv -o $(MANGLEDIR)o/sntc_lib.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/sntc_rs_encode.svp.o.sv :  $(GENSRCDIR)/sntc_rs_encode.svp.sv rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_rs_encode.svp.sv -o $(MANGLEDIR)o/sntc_rs_encode.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/sntc_rs_gen_poly.svp.o.sv :  $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv -o $(MANGLEDIR)o/sntc_rs_gen_poly.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/sntc_rs_syn.svp.o.sv    :  $(GENSRCDIR)/sntc_rs_syn.svp.sv  rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_rs_syn.svp.sv -o $(MANGLEDIR)o/sntc_rs_syn.svp.o.sv -r rsvdWords.rs.txt
dirs = $(shell ls $(GENSRCDIR)/rsSyn)
$(MANGLEDIR)o/rsSyn : $(GENSRCDIR)/sntc_rs_syn.svp.sv $(wildcard $(GENSRCDIR)/rsSyn/sntc_rs_syn_*.svp.sv) rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o/rsSyn
	$(foreach dir,$(dirs),  python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/rsSyn/$(dir) -o $(MANGLEDIR)o/rsSyn/$(dir) -r rsvdWords.rs.txt; )
$(MANGLEDIR)o/sntc_rs_berlekamp.1.svp.o.sv    :  $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv  rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv -o $(MANGLEDIR)o/sntc_rs_berlekamp.1.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/sntc_chien.1.svp.o.sv    :  $(GENSRCDIR)/sntc_chien.1.svp.sv  rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.1.svp.sv -o $(MANGLEDIR)o/sntc_chien.1.svp.o.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.element.svp.sv -o $(MANGLEDIR)o/sntc_chien.element.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.element_param.svp.sv -o $(MANGLEDIR)o/sntc_chien.element_param.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.elem.svp.sv -o $(MANGLEDIR)o/sntc_chien.elem.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.mult.svp.sv -o $(MANGLEDIR)o/sntc_chien.mult.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.root.svp.sv -o $(MANGLEDIR)o/sntc_chien.root.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.cnt.svp.sv -o $(MANGLEDIR)o/sntc_chien.cnt.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.clk_en.svp.sv -o $(MANGLEDIR)o/sntc_chien.clk_en.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.pow.svp.sv -o $(MANGLEDIR)o/sntc_chien.pow.svp.sv -r rsvdWords.rs.txt
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_chien.inst.svp.sv -o $(MANGLEDIR)o/sntc_chien.inst.svp.sv -r rsvdWords.rs.txt
cleanChien:
	/bin/rm -rf $(MANGLEDIR)o/sntc_chien.1.svp.o.sv  $(GENSRCDIR)/sntc_chien.1.svp.sv
$(MANGLEDIR)o/sntc_forney.svp.o.sv    :  $(GENSRCDIR)/sntc_forney.svp.sv  rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/sntc_forney.svp.sv -o $(MANGLEDIR)o/sntc_forney.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/rs.mod.svp.o.sv    :  $(GENSRCDIR)/rs.mod.svp.sv  rsvdWords.rs.txt
	mkdir -p $(MANGLEDIR)o
	python3  $(BIN)/obfs.py  -t verilog -i $(GENSRCDIR)/rs.mod.svp.sv -o $(MANGLEDIR)o/rs.mod.svp.o.sv -r rsvdWords.rs.txt
$(MANGLEDIR)o/gfmult%.svp.sv : gfmult%.svp.sv  rsvdWords.rs.txt
	echo gfmult
	mkdir -p $(dir $@)
	python3  $(BIN)/obfs.py  -t verilog -i $< -o $@ -r rsvdWords.rs.txt
	/bin/cp $@ $(RELDIR)/.



#GFMULTSRC := $(shell find . -maxdepth 1 -type f -name "gfmult*.svp.sv" )
#GFMULT    := $(shell echo $(GFMULTSRC) | cut -b 3- )
#GFMULT    := $(shell find . -maxdepth 1 -type f -name "gfmult*.svp.sv" -exec basename {} \; )
#GFMULT    := $(wildcard gfmult*.svp.sv)
GFMULT    := $(shell ls -1 gfmult*.svp.sv)
GF_MULT_OBFS := $(patsubst %.svp.sv,$(MANGLEDIR)o/%.svp.sv,$(wildcard gfmult*.svp.sv))

check1: $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv \
	$(GENSRCDIR)/sntc_chien.1.svp.sv
	mkdir -p $(MANGLEDIR)o
	make -f $(MAKEFILE1) $(MANGLEDIR)o/$(GFMULT)
	echo $(MANGLEDIR)o/$(GFMULT)
	echo $(GFMULTSRC)
	echo $(GFMULT)
	/bin/cp  $(MANGLEDIR)o/$(GFMULT)                          $(RELDIR)


mangle: \
	$(GF_MULT_OBFS) \
	$(MANGLEDIR)o/sntc_lib.svp.o.sv \
	$(MANGLEDIR)o/sntc_rs_berlekamp.1.svp.o.sv    \
	$(MANGLEDIR)o/sntc_rs_encode.svp.o.sv \
	$(MANGLEDIR)o/sntc_rs_gen_poly.svp.o.sv \
	$(MANGLEDIR)o/sntc_rs_syn.svp.o.sv    \
	$(MANGLEDIR)o/rsSyn \
	$(MANGLEDIR)o/sntc_chien.1.svp.o.sv \
	$(MANGLEDIR)o/sntc_forney.svp.o.sv  \
	$(GENSRCDIR)/sntc_rs_decoder.svp.sv \
	$(GENSRCDIR)/sntc_rs_tb.svp.sv \
	$(GENSRCDIR)/sntc_rs_encode_tb.svp.sv         \
	$(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv         \
	$(GENSRCDIR)/sntc_rs_syn_tb.svp.sv            \
	$(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv        \
	$(GENSRCDIR)/sntc_chien_tb.svp.sv     \
	$(GENSRCDIR)/sntc_rs_forney_tb.svp.sv \

	echo $(PWD)
	find . -maxdepth 1 -type f -name gfmult*.svp.sv | cut -b 3- 
	echo $(GFMULTSRC)
	echo $(GFMULT)
	$(eval export GFMULT=$(GFMULT))
	echo $(GFMULT)

	mkdir   -p    $(RELDIR)/$(GENSRCDIR)
	/bin/cp -rf   $(MANGLEDIR)o/rsSyn                              $(RELDIR)/$(GENSRCDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_lib.svp.o.sv                  $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_rs_encode.svp.o.sv            $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_rs_gen_poly.svp.o.sv          $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_rs_syn.svp.o.sv               $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_rs_berlekamp.1.svp.o.sv       $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.1.svp.o.sv              $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.element.svp.sv          $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.element_param.svp.sv    $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.elem.svp.sv             $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.mult.svp.sv             $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.pow.svp.sv              $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.inst.svp.sv             $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.root.svp.sv             $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.cnt.svp.sv              $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.clk_en.svp.sv           $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.pow.svp.sv              $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_chien.inst.svp.sv             $(RELDIR)
	/bin/cp       $(MANGLEDIR)o/sntc_forney.svp.o.sv               $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_decoder.svp.sv              $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_tb.svp.sv                   $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_encode_tb.svp.sv            $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv          $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_syn_tb.svp.sv               $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv         $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_chien_tb.svp.sv                $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_forney_tb.svp.sv            $(RELDIR)
	/bin/cp       RScommon.mk                                      $(RELDIR)
	/bin/cp       setup.sh                                         $(RELDIR)
	/bin/cp       runme                                            $(RELDIR)
	/bin/cp       README                                           $(RELDIR)
	/bin/cp       *_mm-*                                           $(RELDIR) || true
	/bin/cp       $(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv         $(RELDIR)
	/bin/cp       $(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv          $(RELDIR)


genEncFiles: build
	/bin/cp -rf workRS/sntc_lib.svp.svp                   $(RELENCDIR)
	/bin/cp -rf workRS/sntc_rs_encode.svp.svp             $(RELENCDIR)
	/bin/cp -rf workRS/sntc_rs_gen_poly.svp.svp           $(RELENCDIR)
	/bin/cp -rf workRS/sntc_rs_berlekamp.1.svp.svp        $(RELENCDIR)
	/bin/cp -rf workRS/sntc_chien.1.svp.svp               $(RELENCDIR)
	/bin/cp -rf workRS/sntc_forney.svp.svp                $(RELENCDIR)
	/bin/cp -rf workRS/sntc_rs_syn.svp.svp                $(RELENCDIR)
	/bin/cp -rf workRS/sntc_rs_syn_*                      $(RELENCDIR)
	/bin/cp -rf $(GENSRCDIR)/sntc_rs_syn.svp.sv           $(RELENCDIR)/sntc_rs_syn.svp.svp
	/bin/cp -rf Makefile                                  $(RELENCDIR)
	/bin/cp -rf $(GENSRCDIR)/sntc_rs_decoder.svp.sv       $(RELENCDIR)/sntc_rs_decoder.svp.svp
	/bin/cp -rf $(GENSRCDIR)/sntc_rs_tb.svp.sv            $(RELENCDIR)/sntc_rs_tb.svp.svp
	#/bin/cp -rf cws.txt cws.in                           $(RELENCDIR)
	#/bin/cp -rf inputs_rs_erase.txt                      $(RELENCDIR)
	#ls -1 $(RELENCDIR)/*.svp | xargs -n 1 vim -s ../bin/rm_line.vim 



$(GENSRCDIR)/sntc_rs_tb.svp.sv               : sntc_rs_tb.sv          
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_tb.sv           > $(GENSRCDIR)/sntc_rs_tb.svp.sv                2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv   : sntc_rs_decoder_wrap.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_decoder_wrap.sv > $(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv      2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv    : sntc_rs_encode_wrap.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_encode_wrap.sv  > $(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv       2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_decoder.svp.sv               : sntc_rs_decoder.sv          
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_decoder.sv      > $(GENSRCDIR)/sntc_rs_decoder.svp.sv           2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_lib.svp.sv                : ../rs_ee_erasRel/sntc_lib.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl ../rs_ee_erasRel/sntc_lib.sv  > $(GENSRCDIR)/sntc_lib.svp.sv            2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_encode.svp.sv                : sntc_rs_encode.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_encode.sv       > $(GENSRCDIR)/sntc_rs_encode.svp.sv            2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_gen_poly.svp.sv                : sntc_rs_gen_poly.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_gen_poly.sv       > $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv            2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_syn.svp.sv                   : sntc_rs_syn.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_syn.sv          > $(GENSRCDIR)/sntc_rs_syn.svp.sv               2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv               : ../bchRel/sntc_berlekamp.1.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl ../bchRel/sntc_berlekamp.1.sv  > $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv       2>&1; $(SVP_CLEAN)
	/bin/cp gfmult* $(GENSRCDIR)/.

$(GENSRCDIR)/sntc_chien.1.svp.sv            : sntc_chien.1.sv
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.1.sv              > $(GENSRCDIR)/sntc_chien.1.svp.sv             2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.element.sv        > $(GENSRCDIR)/sntc_chien.element.svp.sv       2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.element_param.sv  > $(GENSRCDIR)/sntc_chien.element_param.svp.sv 2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.elem.sv           > $(GENSRCDIR)/sntc_chien.elem.svp.sv          2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.mult.sv           > $(GENSRCDIR)/sntc_chien.mult.svp.sv          2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.root.sv           > $(GENSRCDIR)/sntc_chien.root.svp.sv          2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.cnt.sv           > $(GENSRCDIR)/sntc_chien.cnt.svp.sv          2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.clk_en.sv           > $(GENSRCDIR)/sntc_chien.clk_en.svp.sv          2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.pow.sv            > $(GENSRCDIR)/sntc_chien.pow.svp.sv           2>&1; $(SVP_CLEAN)
	 mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien.inst.sv           > $(GENSRCDIR)/sntc_chien.inst.svp.sv          2>&1; $(SVP_CLEAN)

$(GENSRCDIR)/sntc_forney.svp.sv                  : sntc_forney.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_forney.sv          > $(GENSRCDIR)/sntc_forney.svp.sv               2>&1; $(SVP_CLEAN)
                                                                                                                                                       
                                                                                                                                                       
$(GENSRCDIR)/sntc_rs_encode_tb.svp.sv             : sntc_rs_encode_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_encode_tb.sv    > $(GENSRCDIR)/sntc_rs_encode_tb.svp.sv         2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv             : sntc_rs_gen_poly_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_gen_poly_tb.sv    > $(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv         2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_syn_tb.svp.sv                : sntc_rs_syn_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_syn_tb.sv       > $(GENSRCDIR)/sntc_rs_syn_tb.svp.sv            2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv            : sntc_rs_berlekamp_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_berlekamp_tb.sv > $(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv      2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_chien_tb.svp.sv         : sntc_chien_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_chien_tb.sv     > $(GENSRCDIR)/sntc_chien_tb.svp.sv          2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_forney_tb.svp.sv               : sntc_rs_forney_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_forney_tb.sv    > $(GENSRCDIR)/sntc_rs_forney_tb.svp.sv         2>&1; $(SVP_CLEAN)
                                                                                                                                                       
$(GENSRCDIR)/rs.mod.svp.sv                      : rs.mod.sv rs.mod.top.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl rs.mod.sv               > $(GENSRCDIR)/rs.mod.svp.sv                    2>&1; $(SVP_CLEAN)
$(GENSRCDIR)/sntc_rs_ee_tb.svp.sv                    : sntc_rs_ee_tb.sv
	mkdir -p $(GENSRCDIR); perl $(BIN)/svp.pl -perl sntc_rs_ee_tb.sv        > $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv             2>&1; $(SVP_CLEAN)



$(GENSRCDIR)/sntc_rs_encode.svp.svp            : $(GENSRCDIR)/sntc_rs_encode.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_lib.svp.svp             $(GENSRCDIR)/sntc_lib.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_encode.svp.svp             $(GENSRCDIR)/sntc_rs_encode.svp.sv
$(GENSRCDIR)/sntc_rs_gen_poly.svp.svp            : $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_gen_poly.svp.svp             $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv
$(GENSRCDIR)/sntc_rs_syn.svp.svp               : $(GENSRCDIR)/sntc_rs_syn.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_syn.svp.svp                $(GENSRCDIR)/sntc_rs_syn.svp.sv
$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.svp       : $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.svp            $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv
$(GENSRCDIR)/sntc_chien.1.svp.svp        : $(GENSRCDIR)/sntc_chien.1.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_chien.1.svp.svp         $(GENSRCDIR)/sntc_chien.1.svp.sv
$(GENSRCDIR)/sntc_forney.svp.svp              : $(GENSRCDIR)/sntc_forney.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_forney.svp.svp               $(GENSRCDIR)/sntc_forney.svp.sv
$(GENSRCDIR)/sntc_rs_tb.svp.svp           : $(GENSRCDIR)/sntc_rs_tb.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_tb.svp.svp            $(GENSRCDIR)/sntc_rs_tb.svp.sv           
$(GENSRCDIR)/sntc_rs_decoder.svp.svp           : $(GENSRCDIR)/sntc_rs_decoder.svp.sv
	vlog -sv +protect    -work workRS +protect=$(GENSRCDIR)/sntc_rs_decoder.svp.svp            $(GENSRCDIR)/sntc_rs_decoder.svp.sv           

$(GENSRCDIR)/rs.mod.svp.svp                  : $(GENSRCDIR)/rs.mod.svp.sv
	 vlog -sv +protect    -work workRS  +protect=$(GENSRCDIR)/rs.mod.svp.svp                 $(GENSRCDIR)/rs.mod.svp.sv

$(GENSRCDIR)/sntc_rs_ee_tb.svp.svp               : $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv
	 vlog -sv +protect    -work workRS  +protect=$(GENSRCDIR)/sntc_rs_ee_tb.svp.svp          $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv



copy_toGENSRCDIR:
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_encode_tb.svp.sv      $(GENSRCDIR)/sntc_rs_encode_tb.svp.svp     
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv      $(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.svp     
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_syn_tb.svp.sv         $(GENSRCDIR)/sntc_rs_syn_tb.svp.svp        
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv     $(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.svp    
	 /bin/cp -rf $(GENSRCDIR)/sntc_chien_tb.svp.sv  $(GENSRCDIR)/sntc_chien_tb.svp.svp 
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_forney_tb.svp.sv        $(GENSRCDIR)/sntc_rs_forney_tb.svp.svp       
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_tb.svp.sv        $(GENSRCDIR)/sntc_rs_tb.svp.svp       
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_decoder.svp.sv        $(GENSRCDIR)/sntc_rs_decoder.svp.svp       


$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_encode.svp.sv : $(GENSRCDIR)/sntc_rs_encode.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_encode.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_encode.svp.sv        
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_gen_poly.svp.sv : $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv        
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_syn.svp.sv : $(GENSRCDIR)/sntc_rs_syn.svp.sv 
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_syn.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_syn.svp.sv
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv : $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv
$(GENSRCDIR)/$(GENSRCDIR)/sntc_chien.1.svp.sv : $(GENSRCDIR)/sntc_chien.1.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_chien.1.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_chien.1.svp.sv
$(GENSRCDIR)/$(GENSRCDIR)/sntc_forney.svp.sv : $(GENSRCDIR)/sntc_forney.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_forney.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_forney.svp.sv
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_tb.svp.sv : $(GENSRCDIR)/sntc_rs_tb.svp.sv 
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_tb.svp.sv           
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_tb.svp.sv           
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_decoder.svp.sv : $(GENSRCDIR)/sntc_rs_decoder.svp.sv 
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_decoder.svp.sv           
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_decoder.svp.sv           
$(GENSRCDIR)/$(GENSRCDIR)/rs.mod.svp.sv    : $(GENSRCDIR)/rs.mod.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/rs.mod.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/rs.mod.svp.sv
$(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_ee_tb.svp.sv  : $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv
	Verilog-Perl/vrename --list --language 1800-2012  --xref                     $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv
	Verilog-Perl/vrename --change --crypt --language 1800-2012 -o $(GENSRCDIR)   $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv

copy_toMangleGENSRCDIR :
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_encode_tb.svp.sv     $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_encode_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv     $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_gen_poly_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_syn_tb.svp.sv        $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_syn_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv    $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_berlekamp_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_chien_tb.svp.sv $(GENSRCDIR)/$(GENSRCDIR)/sntc_chien_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_forney_tb.svp.sv       $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_forney_tb.svp.sv
	 /bin/cp -rf $(GENSRCDIR)/sntc_rs_ee_tb.svp.sv            $(GENSRCDIR)/$(GENSRCDIR)/sntc_rs_ee_tb.svp.sv

	


check-MTI_HOME: 
	if test "$(MTI_HOME)" = "" ; then \
         echo "ENV MTI_HOME not set"; \
        exit 1; \
     fi


ifeq ($(MANGLE_RUN),2)
build: setup check-MTI_HOME
else
build: setup check-MTI_HOME build_sv 
endif
	rm -rf 	build..RS.log 
	#rm -rf work
	rm -rf transcript
	#rm -rf vsim.wlf
	rm -rf dpi_types.h
	rm -rf workRS/_lock
	rm -rf work/_lock
	-vlib work
	##$(MTI_HOME)/win64/vlog +protect   -L ${UVM_HOME} -work workRS \
	#+define+QUESTA \
	#+define+SIMULATION \
	#-novopt \
        #+incdir+$(UVM_HOME)/src \
        #$(UVM_HOME)/src/uvm_pkg.sv \
	#+incdir+$(MTI_HOME)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/include \
        #-dpicpppath \
        #$(MIN_GCC)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/bin/gcc.exe
	#$(MTI_HOME)/win64/vlog +protect   -work workRS +incdir+$(UVM_HOME)/src +incdir+$(UVM_HOME)/../questa_uvm_pkg-1.2/src \
	#$(UVM_HOME)/../questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv

	vlog $(VLOG_OPTS) \
        $(DPILIB_vlog_OPT) \
        -mfcu \
	-note 2605,2275 \
	-novopt \
	+define+QUESTA \
	+define+SIMULATION \
        -ccflags -DQUESTA \
	-timescale "1ns/1ps" \
	+incdir+$(MIN_GCC)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/include \
	+incdir+$(UVM_HOME)/src \
	+incdir+myFifoGrayBin2 \
	+incdir+myFifoGrayBin2/fifoTb/frd \
	+incdir+myFifoGrayBin2/fifoTb/fwr \
	+incdir+myFifoGrayBin2/fifoTb/tb \
	+incdir+myFifoGrayBin2/fifoTb/env \
	-dpicpppath $(MIN_GCC)/questasim-gcc-4.5.0-mingw64/gcc-4.5.0-mingw64/bin/gcc.exe \
	-writetoplevels questa.tops \
	+UVM_TESTNAME=fifoRdWrTest -lint \
	+UVM_VERBOSITY=UVM_DEBUG \
	$(SRC_FILES)  +incdir+$(GENSRCDIR) +incdir+$(RELENCDIR) +incdir+$(RELDIR) \
	-l 	build.RS.log 
       

ifeq ($(DUMP),1)
#RUNCMD="log -r /* ; run -all ; q"
RUNCMD="vcd add -r /sntc_rs_tb/sntc_rs_decoder_wrap_U/sntc_rs_decoder_U/* ; run -all ; q"
else
RUNCMD="run -all ; q"
endif

sim:
	rm -rf vsim.RS.log
	#vopt sntc_rs_tb +acc -o sntc_rs_tb_opt
	vsim \
	-novopt \
	-note 2605 \
	-c \
	-sv_root . \
        -do $(RUNCMD) \
        -l vsim.RS.log sntc_rs_tb \
	+UVM_TESTNAME=$(UVM_TEST) \
	+UVM_VERBOSITY=$(UVM_VERBOSITY) \
        +maxCount=$(XFER) \
	+tst=$(TST) \
	+timeoutfec=$(TIMEOUTFEC) \
	+add_eras=$(ERAS) \
	+add_errs=$(ERRS)

	
	#-f questa.tops \
	#WORKS#-sv_lib  $(LIBDIR)/$(LIBNAME) \
	#$(DPILIB_VSIM_OPT) \
	#cd c:/cygwin64/home/$(USER)/$(USER)/backupcvs/hcb1/hcb/good.101/good.100/rs_ee_eras


view:
	cd c:/cygwin64/home/$(USER)/$(USER)/backupcvs/hcb1/hcb/good.101/good.100/rs_ee_eras
	vsim -view vsim.wlf
	#add wave /sntc_berklekamp_tb/sntc_rs_ee_chien_U/*
	add wave -position insertpoint /sntc_rs_ee_chien_tb/sntc_rs_ee_chien_U/*
	#grep -i "Fifo size" vsim.log > check_fifo.log


#clean:
	#/bin/rm -rf work transcript vsim.wlf data_mem.mem reloc.mem



rel:
	ln -s ../sntc_rs_encode.sv
	ln -s ../sntc_rs_gen_poly.sv
	ln -s ../sntc_rs_syn.sv
	ln -s ../sntc_rs_ee_berlekamp.1.sv
	ln -s ../sntc_rs_ee_chien.1.sv
	ln -s ../sntc_rs_ee_forney.sv
	ln -s ../sntc_rs_ee_tb.sv
	ln -s ../sntc_fc_encode.sv
	ln -s ../sntc_fc11_encode.sv
	ln -s ../sntc_fc21_encode.sv
	ln -s ../sntc_fc11Clk_encode.sv
	ln -s ../sntc_fc11Search_encode.sv
	ln -s ../sntc_fc_tb.sv
	ln -s ../sntc_bch_encode.sv
	ln -s ../sntc_bch_syn.sv
	ln -s ../sntc_berlekamp.1.sv
	ln -s ../sntc_chien.1.sv
	ln -s ../sntc_bch_tb.sv
	ln -s ../sntc_bch_encode_tb.sv
	ln -s ../sntc_bch_syn_tb.sv
	ln -s ../sntc_berlekamp_tb.sv
	ln -s ../sntc_chien_tb.sv
	ln -s ../sntc_rs_encode_tb.sv
	ln -s ../sntc_rs_syn_tb.sv
	ln -s ../sntc_rs_ee_berlekamp_tb.sv
	ln -s ../sntc_chien_tb.sv
	ln -s ../sntc_rs_ee_forney_tb.sv
	ln -s ../sntc_fc_encode_tb.sv
	ln -s ../sntc_fc11_encode_tb.sv
	ln -s ../sntc_fc21_encode_tb.sv
	ln -s ../sntc_fc11Clk_encode_tb.sv
	ln -s ../sntc_fc11Search_encode_tb.sv
	ln -s ../Makefile.bch.all*
	ln -s ../Makefile.bch.berk*
	ln -s ../Makefile.bch.chien*
	ln -s ../Makefile.bch.encode*
	ln -s ../Makefile.bch.syn*
	ln -s ../Makefile.fc.all*
	ln -s ../Makefile.fc.encode*
	ln -s ../Makefile*
	ln -s ../Makefile.rs.berk*
	ln -s ../Makefile.rs.chien*
	ln -s ../Makefile.rs.encode*
	ln -s ../Makefile.rs.forney*
	ln -s ../Makefile.rs.syn*
	ln -s ../bch.pl
	ln -s ../fc.pl
	ln -s ../rs.pl
	/bin/cp -rf ../pragma_protect_begin .
	ln -s ../$(BIN)/svp.pl
	mkdir -p Verilog-Perl
	ln -s ../../Verilog-Perl/vrename Verilog-Perl/vrename
rel1:
	mkdir -p                                  rel0
	mkdir -p                                  rel0/Verilog-Perl
	ln -s ../sntc_rs_encode.sv                rel0/sntc_rs_encode.sv
	ln -s ../sntc_rs_gen_poly.sv              rel0/sntc_rs_gen_poly.sv
	ln -s ../sntc_rs_syn.sv                   rel0/sntc_rs_syn.sv
	ln -s ../sntc_rs_ee_berlekamp.1.sv        rel0/sntc_rs_ee_berlekamp.1.sv
	ln -s ../sntc_rs_ee_chien.1.sv            rel0/sntc_rs_ee_chien.1.sv
	ln -s ../sntc_rs_ee_forney.sv             rel0/sntc_rs_ee_forney.sv
	ln -s ../sntc_rs_ee_tb.sv                 rel0/sntc_rs_ee_tb.sv
	ln -s ../sntc_fc_encode.sv                rel0/sntc_fc_encode.sv
	ln -s ../sntc_fc11_encode.sv              rel0/sntc_fc11_encode.sv
	ln -s ../sntc_fc21_encode.sv              rel0/sntc_fc21_encode.sv
	ln -s ../sntc_fc11Clk_encode.sv           rel0/sntc_fc11Clk_encode.sv
	ln -s ../sntc_fc11Search_encode.sv        rel0/sntc_fc11Search_encode.sv
	ln -s ../sntc_fc_tb.sv                    rel0/sntc_fc_tb.sv
	ln -s ../sntc_bch_encode.sv               rel0/sntc_bch_encode.sv
	ln -s ../sntc_bch_syn.sv                  rel0/sntc_bch_syn.sv
	ln -s ../sntc_berlekamp.1.sv              rel0/sntc_berlekamp.1.sv
	ln -s ../sntc_chien.1.sv                  rel0/sntc_chien.1.sv
	ln -s ../sntc_bch_tb.sv                   rel0/sntc_bch_tb.sv
	ln -s ../sntc_bch_encode_tb.sv            rel0/sntc_bch_encode_tb.sv
	ln -s ../sntc_bch_syn_tb.sv               rel0/sntc_bch_syn_tb.sv
	ln -s ../sntc_berlekamp_tb.sv             rel0/sntc_berlekamp_tb.sv
	ln -s ../sntc_chien_tb.sv                 rel0/sntc_chien_tb.sv
	ln -s ../sntc_rs_encode_tb.sv             rel0/sntc_rs_encode_tb.sv
	ln -s ../sntc_rs_syn_tb.sv                rel0/sntc_rs_syn_tb.sv
	ln -s ../sntc_rs_ee_berlekamp_tb.sv       rel0/sntc_rs_ee_berlekamp_tb.sv
	ln -s ../sntc_chien_tb.sv                 rel0/sntc_chien_tb.sv
	ln -s ../sntc_rs_ee_forney_tb.sv          rel0/sntc_rs_ee_forney_tb.sv
	ln -s ../sntc_fc_encode_tb.sv             rel0/sntc_fc_encode_tb.sv
	ln -s ../sntc_fc11_encode_tb.sv           rel0/sntc_fc11_encode_tb.sv
	ln -s ../sntc_fc21_encode_tb.sv           rel0/sntc_fc21_encode_tb.sv
	ln -s ../sntc_fc11Clk_encode_tb.sv        rel0/sntc_fc11Clk_encode_tb.sv
	ln -s ../sntc_fc11Search_encode_tb.sv     rel0/sntc_fc11Search_encode_tb.sv
	ln -s ../Makefile.bch.all*                rel0/Makefile.bch.all*
	ln -s ../Makefile.bch.berk*               rel0/Makefile.bch.berk*
	ln -s ../Makefile.bch.chien*              rel0/Makefile.bch.chien*
	ln -s ../Makefile.bch.encode*             rel0/Makefile.bch.encode*
	ln -s ../Makefile.bch.syn*                rel0/Makefile.bch.syn*
	ln -s ../Makefile.fc.all*                 rel0/Makefile.fc.all*
	ln -s ../Makefile.fc.encode*              rel0/Makefile.fc.encode*
	ln -s ../Makefile*                        rel0/Makefile*
	ln -s ../Makefile.rs.berk*                rel0/Makefile.rs.berk*
	ln -s ../Makefile.rs.chien*               rel0/Makefile.rs.chien*
	ln -s ../Makefile.rs.encode*              rel0/Makefile.rs.encode*
	ln -s ../Makefile.rs.gen_poly*            rel0/Makefile.rs.gen_poly*
	ln -s ../Makefile.rs.forney*              rel0/Makefile.rs.forney*
	ln -s ../Makefile.rs.syn*                 rel0/Makefile.rs.syn*
	ln -s ../bch.pl                           rel0/bch.pl
	ln -s ../fc.pl                            rel0/fc.pl
	ln -s ../rs.pl                            rel0/rs.pl
	ln -s ../$(BIN)/svp.pl                    rel0/$(BIN)/svp.pl
	/bin/cp -rf pragma_protect_begin          rel0/.
	ln -s ../../Verilog-Perl/vrename          rel0/Verilog-Perl/vrename
	/bin/cp -rf ../inputs.txt                 .


mangleall: build_sv mangle
	make -f Makefile build MANGLE_RUN=1
	make -f Makefile sim

ENCRYPT:
	make -f Makefile genEncFiles ENCRYPT=1
	cd RELENC && \
	make -f Makefile build MANGLE_RUN=2 sim




ifeq ($(MANGLE_RUN),1)
xvlog: setup 
	$(eval export RELDIR=.)
	$(eval export GENSRCDIR=.)
	$(eval export MANGLE=$(MANGLE))
else
xvlog: setup $(SRC_FILES) # $(wildcard $(GENSRCDIR)/rsSyn/sntc_rs_syn_*.svp.sv)
endif
	xvlog -d SIMULATION -d PLAIN --sv --incr --relax \
	--work worklib  $(SRC_FILES) --include $(GENSRCDIR) --include $(RELDIR)




xelab:
	 xelab --incr --debug typical --relax --mt 2 -L xil_defaultlib \
	-L unisims_ver -L unimacro_ver -L secureip --stats \
	--snapshot sntc_rs_tb_behav worklib.sntc_rs_tb
	# xelab --snapshot sntc_rs_tb_behav worklib.sntc_rs_tb

xsim:
	xsim sntc_rs_tb_behav  \
       -tclbatch sntc_rs_tb.tcl --sv_seed $(MYSEED)

ifeq ($(MANGLE_RUN),1)
iv_comp: setup build_sv mangle
	$(eval export MANGLE=$(MANGLE))
	/bin/cp  -rf Makefile RScommon.mk gfmult* a b $(RELDIR)
	$(IVERILOG) -g2012 -Wall -DSIMULATION -DPLAIN $(IV_DUMP_DEFINE) \
		-s sntc_rs_tb -o $(IV_OUT) \
		-I$(GENSRCDIR) -I$(RELDIR) $(SRC_FILESr)
else ifeq ($(MANGLE_RUN),2)
iv_comp: setup
	$(IVERILOG) -g2012 -Wall -DSIMULATION -DPLAIN $(IV_DUMP_DEFINE) \
		-s sntc_rs_tb -o $(IV_OUT) \
		-I$(RELDIR) $(SRC_FILESo)
else ifeq ($(REL_RUN),1)
iv_comp: setup
	$(IVERILOG) -g2012 -Wall -DSIMULATION -DPLAIN $(IV_DUMP_DEFINE) \
		-s sntc_rs_tb -o $(IV_OUT) \
		-I$(GENSRCDIR) -I$(RELDIR) $(SRC_FILESr)
else
iv_comp: setup build_sv
	mkdir -p $(RELDIR)/$(GENSRCDIR)
	/bin/cp  -rf $(GENSRCDIR)/*  $(RELDIR)/$(GENSRCDIR)
	/bin/cp  -rf Makefile RScommon.mk gfmult* a b $(RELDIR)
	$(IVERILOG) -g2012 -Wall -DSIMULATION -DPLAIN $(IV_DUMP_DEFINE) \
		-s sntc_rs_tb -o $(IV_OUT) \
		-I$(GENSRCDIR) -I$(RELDIR) $(SRC_FILES)
endif

iv_sim: iv_comp
	$(VVP) $(IV_OUT) +ntb_random_seed=$(MYSEED)

vcd:
	gtkwave xsim_dump.vcd

iv_vcd:
	gtkwave iv_sim.vcd

xbuild: setup build_sv xvlog xelab

xall: xbuild xsim

manglexall: runC setup check1 mangle

ifeq ($(MANGLE_RUN),0)
	/bin/cp *_mm-* sntc_rs_tb.tcl RScommon.mk Makefile $(GENSRCDIR) && \
	cd $(GENSRCDIR) && \
	make -f Makefile xvlog xelab MANGLE_RUN=1 && \
	make -f Makefile xsim
else
	/bin/cp *_mm-* sntc_rs_tb.tcl RScommon.mk Makefile $(RELDIR) && \
	cd $(RELDIR) && \
	make -f Makefile xvlog xelab MANGLE_RUN=1 && \
	make -f Makefile xsim
endif

makemangle:
	make -f Makefile manglexall MANGLE_RUN=1

makemangle255_223:
	make -f Makefile makemangle MYSEED=801600

makemangle255_223_user:
	#too much recursion !!!
	#make -f Makefile xvlog xelab MANGLE_RUN=1 xsim
	make -f Makefile cleandir manglexall MANGLE_RUN=1 MYSEED=801600


setup:
	$(eval export ENCRYPT=$(ENCRYPT))
	 #if [ -d "./$(GENSRCDIR)" ]; then \
	 #  /bin/rm -rf ./$(GENSRCDIR); \
	 #fi
	 mkdir -p a b
	 if [ -d "./$(MANGLEDIR)o" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(MANGLEDIR)o;  \
	 fi
	 if [ -d "./$(RELDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(RELDIR);  \
	 fi
	 if [ -d "./$(RELENCDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(RELENCDIR);  \
	 fi
	 if [ -d "./$(GENSRCDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(GENSRCDIR);  \
	 fi
	      if [ ! -d "./$(GENSRCDIR)/$(GENSRCDIR)" ]; then \
	         mkdir -p ./$(GENSRCDIR)/$(GENSRCDIR);  \
	      else \
	          echo "subDirectory exists"; \
	      fi
	$(eval export ENCRYPT=$(ENCRYPT))
	$(eval export MYSEED=$(MYSEED))
	$(eval export TIMEOUTFEC=$(TIMEOUTFEC))
	$(eval export MANGLE_RUN=$(MANGLE_RUN))
	 #if [ -d "./$(GENSRCDIR)" ]; then \
	 #  /bin/rm -rf ./$(GENSRCDIR); \
	 #fi
	 mkdir -p a b
	 if [ -d "./$(RELDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(RELDIR);  \
	 fi
	 if [ -d "./$(RELENCDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(RELENCDIR);  \
	 fi
	 if [ -d "./$(GENSRCDIR)" ]; then \
	      echo "Directory exists"; \
	 else  \
	      mkdir -p ./$(GENSRCDIR);  \
	 fi
	      if [ ! -d "./$(GENSRCDIR)/$(GENSRCDIR)" ]; then \
	         mkdir -p ./$(GENSRCDIR)/$(GENSRCDIR);  \
	      else \
	          echo "subDirectory exists"; \
	      fi

test1:
	make -f Makefile cleandir xall MYSEED=800800 DECODER_ONLY=1 PARAM_t_lower=4 DUMP=1

test2:
	make -f Makefile cleandir manglexall MYSEED=800800 DECODER_ONLY=1 PARAM_t_lower=4 MANGLE_RUN=1 DUMP=1

test84:
	make -f Makefile cleandir xall MYSEED=800800 PARAM_t_lower=4 t_inject=4 DUMP=1
	
test88:
	make -f Makefile cleandir xall MYSEED=800800 t_inject=8 DUMP=1
	
test88v:
	make -f Makefile cleandir build sim MYSEED=800800 t_inject=8 DUMP=1

test64:
	make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=4 t_inject=4 DUMP=1

test64_5:
	make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=5 t_inject=4 DUMP=1

test641:
	make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=2 t_inject=4 DUMP=1

test105:
	make -f Makefile cleandir xall MYSEED=1000500 PARAM_t_lower=5 t_inject=4 DUMP=1

test65:
	make -f Makefile cleandir xall MYSEED=600500 t_inject=5 DUMP=1


test3:
	/bin/rm -rf temp/tmp
	mkdir -p temp/tmp
	echo "6 5 5"
	make -f Makefile cleandir manglexall MYSEED=600500 PARAM_t_lower=5 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_6_5_5
	#sleep 10
	echo "6 5 4"
	make -f Makefile cleandir manglexall MYSEED=600500 PARAM_t_lower=4 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_6_5_4
	#sleep 10
	echo "6 5 3"
	make -f Makefile cleandir manglexall MYSEED=600500 PARAM_t_lower=3 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_6_5_3
	#sleep 10
	echo "7 5 5"
	make -f Makefile cleandir manglexall MYSEED=700500 PARAM_t_lower=5 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_7_5_5
	#sleep 10
	echo "7 5 4"
	make -f Makefile cleandir manglexall MYSEED=700500 PARAM_t_lower=4 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_7_5_4
	#sleep 10
	echo "7 5 3"
	make -f Makefile cleandir manglexall MYSEED=700500 PARAM_t_lower=3 MANGLE_RUN=1
	/bin/cp -rf RELRS temp/tmp/RELRS_7_5_3
	# make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=5
	# make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=4

test4:
	cd ../RELRS_6_5_5
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=600500 PARAM_t_lower=5
	cd ../RELRS_6_5_4
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=600500 PARAM_t_lower=4
	cd ../RELRS_6_5_3
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=600500 PARAM_t_lower=3
	cd ../RELRS_7_5_5
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=700500 PARAM_t_lower=5
	cd ../RELRS_7_5_4
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=700500 PARAM_t_lower=4
	cd ../RELRS_7_5_3
	make -f Makefile xvlog xelab MANGLE_RUN=1 && make -f Makefile xsim MYSEED=700500 PARAM_t_lower=3
	#make -f Makefile xrun MANGLE_RUN=1 MYSEED=600500 PARAM_t_lower=5



test5:
	make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=4 t_inject=5

test12:
	make -f Makefile cleandir build sim MYSEED=1 M=12 T=100 DUMP=0

testShort:
	 make -f Makefile cleandir xall MYSEED=700600 t_inject=6 DUMP=0

SRCDIR  := $(GENSRCDIR)/rsSyn
BUILDDIR:= .

SOURCES := $(shell find $(SRCDIR) -type f -name sntc_rs_syn_*.svp.sv)
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.svp.sv=.lint))


$(BUILDDIR)/sntc_rs_syn_%.lint: $(SRCDIR)/sntc_rs_syn_%.svp.sv
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall \
	--top-module $(subst .lint,,$@)  $(GENSRCDIR)/sntc_lib.svp.sv $< > $@ 2> $@

lint: $(OBJECTS)
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_rs_encode $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/sntc_rs_encode.svp.sv $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv -I$(GENSRCDIR) >  sntc_rs_encode.lint 2> sntc_rs_encode.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv > sntc_rs_berlekamp.1.lint 2> sntc_rs_berlekamp.1.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_chien $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/sntc_chien.1.svp.sv $(GENSRCDIR)/sntc_chien.elem.svp.sv -I$(GENSRCDIR) >  sntc_chien.lint 2> sntc_chien.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_forney $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/sntc_forney.svp.sv -I$(GENSRCDIR) > sntc_forney.lint 2> sntc_forney.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_rs_encode_wrap $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/sntc_rs_encode.svp.sv $(GENSRCDIR)/sntc_rs_gen_poly.svp.sv -I$(GENSRCDIR) $(GENSRCDIR)/sntc_rs_encode_wrap.svp.sv > sntc_rs_encode_wrap.lint 2> sntc_rs_encode_wrap.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_rs_decoder $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/rsSyn/sntc_rs_syn_*.svp.sv $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv $(GENSRCDIR)/sntc_chien.1.svp.sv $(GENSRCDIR)/sntc_chien.elem.svp.sv -I$(GENSRCDIR)   $(GENSRCDIR)/sntc_forney.svp.sv $(GENSRCDIR)/sntc_rs_decoder.svp.sv > sntc_rs_decoder.lint 2> sntc_rs_decoder.lint
	../../../tools/verilator-4.010/bin/verilator --lint-only -Wall --top-module sntc_rs_decoder_wrap $(GENSRCDIR)/sntc_lib.svp.sv $(GENSRCDIR)/rsSyn/sntc_rs_syn_*.svp.sv $(GENSRCDIR)/sntc_rs_berlekamp.1.svp.sv $(GENSRCDIR)/sntc_chien.1.svp.sv $(GENSRCDIR)/sntc_chien.elem.svp.sv -I$(GENSRCDIR)   $(GENSRCDIR)/sntc_forney.svp.sv $(GENSRCDIR)/sntc_rs_decoder.svp.sv  $(GENSRCDIR)/sntc_rs_decoder_wrap.svp.sv > sntc_rs_decoder_wrap.lint 2> sntc_rs_decoder_wrap.lint



lintall:
	make -f Makefile cleandir build_sv lint MYSEED=700500


checkmangle:
	make -f Makefile cleandir manglexall MYSEED=600500 PARAM_t_lower=5 MANGLE_RUN=1

wave:
	../../../tools/gtkwave64/bin/gtkwave.exe xsim_dump.vcd

C_DIR ?= temp.gcc
C_TT ?= 1
C_SEED ?= 1000500
gcc_b:
	gcc -DSTANDALONEC ../../rsC/b_wow.c
	/bin/rm -rf $(C_DIR)
	/bin/mkdir $(C_DIR)
	./a.exe $(C_SEED) 5 $(C_TT) 0 1 1 $(C_DIR) >  $(C_DIR)/b_wow.log 2>  $(C_DIR)/b_wow.log

demo:
	make -f Makefile cleandir xall MYSEED=600500 PARAM_t_lower=5 t_inject=4

#step 1
demo_iv:
	make -f Makefile cleandir iv_sim DUMP=1 MYSEED=600500 PARAM_t_lower=5 t_inject=4

#step 2
demo_iv_rel:
	make -f Makefile iv_sim DUMP=1 MYSEED=600500 PARAM_t_lower=5 t_inject=4 REL_RUN=1
	cd ../RELRS

#mangle step #1
demo_iv_mangle:
	make -f Makefile cleandir iv_sim DUMP=1 MYSEED=600500 PARAM_t_lower=5 t_inject=4 MANGLE_RUN=1

#mangle step #2
demo_iv_mangle_run:
	make -f Makefile iv_sim DUMP=1 MYSEED=600500 PARAM_t_lower=5 t_inject=4 MANGLE_RUN=2
	cd ../RELRS



#step 1
abs_ex_demo_iv:
	make -f Makefile cleandir iv_sim DUMP=1 MYSEED=1000151 PARAM_t_lower=15 t_inject=15

#step 2
abs_ex_demo_iv_rel:
	make -f Makefile iv_sim DUMP=1 MYSEED=1000151 PARAM_t_lower=15 t_inject=15 REL_RUN=1
	cd ../RELRS

#mangle step #1
demo_iv_mangle10:
	make -f Makefile cleandir iv_sim DUMP=1 MYSEED=1000151 PARAM_t_lower=15 t_inject=15 MANGLE_RUN=1

#mangle step #2
demo_iv_mangle_run10:
	make -f Makefile iv_sim DUMP=1 MYSEED=1000151 PARAM_t_lower=15 t_inject=15 MANGLE_RUN=2
	cd ../RELRS



