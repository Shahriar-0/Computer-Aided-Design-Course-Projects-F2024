alias clc ".main clear"

clc
exec vlib work
vmap work work

set TB					"EncoderTB"
set hdl_path			"../src/hdl"
set inc_path			"../src/inc"

set run_time			"-all"

#============================ Add verilog files  ===============================

vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addrc_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addrc_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addrc_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addrc.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/bit_changer.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity_calc.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colparity.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter_modn.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/five_bit_selector.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mapper.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/matrix_mult.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/memory.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/multiplier.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity_calc.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permutation.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate_datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_register.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_size.v

vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM ./tb/encoder_tb.sv
onerror {break}

#================================ simulation ====================================

vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

add wave -hex -group 	 	{TB}				sim:/$TB/*
add wave -hex -group 	 	{top}				sim:/$TB/enc/*
add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================

configure wave -signalnamewidth 2

#====================================== run =====================================

run $run_time
