	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_C1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_C2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/__ACT_S2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ABS.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND6.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2PAR.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Comparator.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Controller.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FullAdder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Maxnet.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/bitmult.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplier.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/MUX4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/NOT.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OneHot4.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OneHot6.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR6.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/PU.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/REG.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemoryW.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemoryY.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/DataMemoryX.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/TwosComp.sv
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR2.v

		
	vlog 	+acc -incr -source  +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -bin -group 	 	{TB}				sim:/$TB/*

	
#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	run -all
	