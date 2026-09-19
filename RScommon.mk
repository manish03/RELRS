#////////////////////////////////////////////////////////////////////////////////
#//# Copyright (c) 2018 Secantec
#//# No Permission to modify and distribute this program
#//# even if this copyright message remains unaltered.
#//#
#//# Author: Secantec 27 April, 2018
#//@ printf("//# \$Id: \$");
#//#
#//# Revision History
#//#       MM      17  April, 2018    Initial release
#//#
#////////////////////////////////////////////////////////////////////////////////
cleanCComp:
	/bin/rm -rf rsC.log
	/bin/rm -rf rs.exe
	/bin/rm -rf rs

cleanC:
	/bin/rm -rf cycle_mm-*
	/bin/rm -rf ecc_x_mm-*
	/bin/rm -rf errCnt_x_mm-*
	/bin/rm -rf g_x_mm-*
	/bin/rm -rf glbl_mm-*
	/bin/rm -rf inputErrLoc_x_mm-*
	/bin/rm -rf ll_u_x_mm-*
	/bin/rm -rf rawData_x_mm-*
	/bin/rm -rf result_x_mm-*
	/bin/rm -rf sigma_x_mm-*
	/bin/rm -rf size_mm-*
	/bin/rm -rf sLoc_x_mm-*
	/bin/rm -rf syn_x_mm-*
	/bin/rm -rf eras_x_mm-* err_x_mm-* errCnt_x_mm-*
	/bin/rm -rf lambda_deg_x_mm-*
	/bin/rm -rf lambda_x_mm-*
	/bin/rm -rf no_eras_x_mm-* no_err_x_mm-*
	/bin/rm -rf phi_x_mm-*
	/bin/rm -rf corrData_x_mm-*
	/bin/rm -rf stat_x_mm-*


mtilong: cleandir build sim MYSEED=1408000 DUMP=0 TIMEOUTFEC=200000


runC: cleanCComp
	if [  -f ../../rsC/b_wow.c ]; then \
	   gcc ../../rsC/b_wow.c -lm -o ./rs -DSTANDALONEC=1 ; \
	fi

cleandir: cleanC cleanCComp
	/bin/rm -rf a b
	/bin/rm -rf mangle*
	/bin/rm -rf work*
	/bin/rm -rf libcc
	/bin/rm -rf *.svp.sv
	/bin/rm -rf *.log
	#/bin/rm -rf vsim.wlf
	#/bin/rm -rf *wlf
	/bin/rm -rf wlf*
	/bin/rm -rf signals.vrename
	/bin/rm -rf genSrcRs
	/bin/rm -rf RELRS
	/bin/rm -rf RELENC
	/bin/rm -rf questa.tops
	/bin/rm -rf cws.out vish_stacktrace.vstf

	/bin/rm -rf wlf*
	/bin/rm -rf webtalk*
	/bin/rm -rf xvlog*
	/bin/rm -rf xelab*
	/bin/rm -rf xsim*
	/bin/rm -rf *.wdb*
	/bin/rm -rf *.jou*
	/bin/rm -rf *.str*
	/bin/rm -rf *.vcd*
	/bin/rm -rf *.pb*
	/bin/rm -rf xsim.dir
	/bin/rm -rf .Xil

	du -am . | sort -n
	/bin/rm -rf RELBCH a b
	/bin/rm -rf RELENC
	/bin/rm -rf genSrcBCH
	/bin/rm -rf mangle*
	/bin/rm -rf work*
	/bin/rm -rf libcc
	/bin/rm -rf *.svp.sv
	/bin/rm -rf *.log
	#/bin/rm -rf vsim.wlf
	/bin/rm -rf wlf*
	/bin/rm -rf signals.vrename
	/bin/rm -rf questa.tops
	/bin/rm -rf _Inline
	/bin/rm -rf *.lint

	#/bin/rm -rf *wlf
	/bin/rm -rf wlf*
	/bin/rm -rf webtalk*
	/bin/rm -rf xvlog*
	/bin/rm -rf xelab*
	/bin/rm -rf xsim*
	/bin/rm -rf *.wdb*
	/bin/rm -rf *.jou*
	/bin/rm -rf *.str*
	/bin/rm -rf *.vcd*
	/bin/rm -rf *.pb*
	/bin/rm -rf xsim.dir
	/bin/rm -rf .Xil
	/bin/rm -rf g_x_mm*
	/bin/rm -rf glbl_mm*
	/bin/rm -rf cycle_mm*
	/bin/rm -rf size_mm*
	/bin/rm -rf inputDataErrLoc_x_mm-*
	/bin/rm -rf rawData_x_mm-*
	/bin/rm -rf z_x_mm-*
	/bin/rm -rf o 
	/bin/rm -rf perl.exe.stackdump
	/bin/rm -rf genSrcRs
	/bin/rm -rf RELRS
	/bin/rm -rf iv_sim.vvp

	du -am . | sort -n


