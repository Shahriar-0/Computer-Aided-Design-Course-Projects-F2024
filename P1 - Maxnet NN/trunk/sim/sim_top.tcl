	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"testbench"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
	# set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Check.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/CU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemory.dat
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Decoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DP.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FloatingAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FloatingMultiplier.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Matrix.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux2to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux4to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ReLU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TopModule.v		
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
	