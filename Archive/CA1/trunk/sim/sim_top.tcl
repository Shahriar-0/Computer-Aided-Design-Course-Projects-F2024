alias clc ".main clear"

clc
exec vlib work
vmap work work

set TB					"PermutationTB"
set hdl_path			"../src/hdl"
set inc_path			"../src/inc"

set run_time			"-all"

#============================ Add verilog files  ===============================

vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter_modn.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mapper.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v

vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM ./tb/permutation_tb.sv
onerror {break}

#================================ simulation ====================================

vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

add wave -hex -group 	 	{TB}				sim:/$TB/*
add wave -hex -group 	 	{top}				sim:/$TB/perm/*
add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================

configure wave -signalnamewidth 2

#====================================== run =====================================

run $run_time
