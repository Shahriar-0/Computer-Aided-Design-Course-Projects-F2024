	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TestBench"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
	# set run_time			"-all"

#============================   verilog files  ==================================
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v             
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AdderCascade.v      
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ADD_TB.v            
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND2.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND3.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND4.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND4NOT3.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND4NOT4.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/BIT_MULT.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/BUF.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Check.v             
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/CU.v                
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/CU2.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemory.v        
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Decoder.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DP.v                
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MULT.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MULT_TB.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2REG.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2REGSingle.v     
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2Single.v        
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux2to1.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4REG3.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4REGSingle.v     
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux4to1.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX8.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX8REG.v           
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX8REG_TB.v        
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/NOT.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR4.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR5.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ProcessingUnit.v    
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU1.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU2.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU3.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU4.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/REG.v               
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ReLU.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ThreeBitComparator.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TopModule.v         
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR2.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR3.v              
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Zeroetend2to3.v     
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ZeroExtend.v        
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ZeroExtend2to3_TB.v 
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_C1.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_C2.v          
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_S2.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    
#====================================== run =====================================

	run $run_time 
	