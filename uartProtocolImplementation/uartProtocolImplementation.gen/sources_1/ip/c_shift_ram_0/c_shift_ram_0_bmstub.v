// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module c_shift_ram_0 (
  D,
  CLK,
  CE,
  Q
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 d_intf DATA" *)
  (* X_INTERFACE_MODE = "slave d_intf" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *)
  input [31:0]D;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk_intf CLK" *)
  (* X_INTERFACE_MODE = "slave clk_intf" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:d_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_PORT , INSERT_VIP 0" *)
  input CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *)
  (* X_INTERFACE_MODE = "slave ce_intf" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *)
  input CE;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 q_intf DATA" *)
  (* X_INTERFACE_MODE = "master q_intf" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *)
  output [31:0]Q;

  // stub module has no contents

endmodule
