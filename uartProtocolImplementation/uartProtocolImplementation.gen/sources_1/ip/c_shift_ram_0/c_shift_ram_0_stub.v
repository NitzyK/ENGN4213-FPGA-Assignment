// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Thu Apr 10 10:45:40 2025
// Host        : NUC_M15_NK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/getni/ENGN4213-FPGA-Assignment/uartProtocolImplementation/uartProtocolImplementation.gen/sources_1/ip/c_shift_ram_0/c_shift_ram_0_stub.v
// Design      : c_shift_ram_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "c_shift_ram_0,c_shift_ram_v12_0_18,{}" *) (* core_generation_info = "c_shift_ram_0,c_shift_ram_v12_0_18,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_shift_ram,x_ipVersion=12.0,x_ipCoreRevision=18,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_XDEVICEFAMILY=artix7,C_VERBOSITY=0,C_WIDTH=32,C_DEPTH=8,C_ADDR_WIDTH=4,C_SHIFT_TYPE=0,C_OPT_GOAL=0,C_AINIT_VAL=00000000000000000000000000000000,C_SINIT_VAL=00000000000000000000000000000000,C_DEFAULT_DATA=00000000000000000000000000000000,C_HAS_A=0,C_HAS_CE=1,C_REG_LAST_BIT=1,C_SYNC_PRIORITY=1,C_SYNC_ENABLE=0,C_HAS_SCLR=0,C_HAS_SSET=0,C_HAS_SINIT=0,C_MEM_INIT_FILE=no_coe_file_loaded,C_ELABORATION_DIR=./,C_READ_MIF=0,C_PARSER_TYPE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "c_shift_ram_v12_0_18,Vivado 2024.2" *) 
module c_shift_ram_0(D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="D[31:0],CE,Q[31:0]" */
/* synthesis syn_force_seq_prim="CLK" */;
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_mode = "slave d_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [31:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_mode = "slave clk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:d_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_mode = "slave ce_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_mode = "master q_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [31:0]Q;
endmodule
