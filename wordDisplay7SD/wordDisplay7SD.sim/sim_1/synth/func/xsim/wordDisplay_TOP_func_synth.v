// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Sun Apr  6 01:54:46 2025
// Host        : NUC_M15_NK running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/getni/ENGN4213-FPGA-Assignment/wordDisplay7SD/wordDisplay7SD.sim/sim_1/synth/func/xsim/wordDisplay_TOP_func_synth.v
// Design      : wordDisplay_TOP
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clockDividerHB
   (E,
    clk_IBUF_BUFG);
  output [0:0]E;
  input clk_IBUF_BUFG;

  wire [0:0]E;
  wire clk_IBUF_BUFG;
  wire \counter[0]_i_1__0_n_0 ;
  wire \counter[0]_i_3__0_n_0 ;
  wire \counter[0]_i_4__0_n_0 ;
  wire \counter[0]_i_5__0_n_0 ;
  wire \counter[0]_i_6__0_n_0 ;
  wire \counter[0]_i_7__1_n_0 ;
  wire [21:0]counter_reg;
  wire \counter_reg[0]_i_2__0_n_0 ;
  wire \counter_reg[0]_i_2__0_n_1 ;
  wire \counter_reg[0]_i_2__0_n_2 ;
  wire \counter_reg[0]_i_2__0_n_3 ;
  wire \counter_reg[0]_i_2__0_n_4 ;
  wire \counter_reg[0]_i_2__0_n_5 ;
  wire \counter_reg[0]_i_2__0_n_6 ;
  wire \counter_reg[0]_i_2__0_n_7 ;
  wire \counter_reg[12]_i_1__0_n_0 ;
  wire \counter_reg[12]_i_1__0_n_1 ;
  wire \counter_reg[12]_i_1__0_n_2 ;
  wire \counter_reg[12]_i_1__0_n_3 ;
  wire \counter_reg[12]_i_1__0_n_4 ;
  wire \counter_reg[12]_i_1__0_n_5 ;
  wire \counter_reg[12]_i_1__0_n_6 ;
  wire \counter_reg[12]_i_1__0_n_7 ;
  wire \counter_reg[16]_i_1__0_n_0 ;
  wire \counter_reg[16]_i_1__0_n_1 ;
  wire \counter_reg[16]_i_1__0_n_2 ;
  wire \counter_reg[16]_i_1__0_n_3 ;
  wire \counter_reg[16]_i_1__0_n_4 ;
  wire \counter_reg[16]_i_1__0_n_5 ;
  wire \counter_reg[16]_i_1__0_n_6 ;
  wire \counter_reg[16]_i_1__0_n_7 ;
  wire \counter_reg[20]_i_1__0_n_3 ;
  wire \counter_reg[20]_i_1__0_n_6 ;
  wire \counter_reg[20]_i_1__0_n_7 ;
  wire \counter_reg[4]_i_1__0_n_0 ;
  wire \counter_reg[4]_i_1__0_n_1 ;
  wire \counter_reg[4]_i_1__0_n_2 ;
  wire \counter_reg[4]_i_1__0_n_3 ;
  wire \counter_reg[4]_i_1__0_n_4 ;
  wire \counter_reg[4]_i_1__0_n_5 ;
  wire \counter_reg[4]_i_1__0_n_6 ;
  wire \counter_reg[4]_i_1__0_n_7 ;
  wire \counter_reg[8]_i_1__0_n_0 ;
  wire \counter_reg[8]_i_1__0_n_1 ;
  wire \counter_reg[8]_i_1__0_n_2 ;
  wire \counter_reg[8]_i_1__0_n_3 ;
  wire \counter_reg[8]_i_1__0_n_4 ;
  wire \counter_reg[8]_i_1__0_n_5 ;
  wire \counter_reg[8]_i_1__0_n_6 ;
  wire \counter_reg[8]_i_1__0_n_7 ;
  wire dividedClk_i_1__0_n_0;
  wire dividedClk_i_2__0_n_0;
  wire dividedClk_i_3__0_n_0;
  wire dividedClk_reg_n_0;
  wire \pipeline[0]_i_2__0_n_0 ;
  wire \pipeline[0]_i_3__0_n_0 ;
  wire \pipeline[0]_i_4__0_n_0 ;
  wire \pipeline[0]_i_5__0_n_0 ;
  wire \pipeline[0]_i_6__0_n_0 ;
  wire \pipeline[0]_i_7__0_n_0 ;
  wire [3:1]\NLW_counter_reg[20]_i_1__0_CO_UNCONNECTED ;
  wire [3:2]\NLW_counter_reg[20]_i_1__0_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hFFFF0000F8000000)) 
    \counter[0]_i_1__0 
       (.I0(\counter[0]_i_3__0_n_0 ),
        .I1(\counter[0]_i_4__0_n_0 ),
        .I2(counter_reg[16]),
        .I3(counter_reg[17]),
        .I4(\pipeline[0]_i_6__0_n_0 ),
        .I5(\pipeline[0]_i_7__0_n_0 ),
        .O(\counter[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0000000)) 
    \counter[0]_i_3__0 
       (.I0(\counter[0]_i_6__0_n_0 ),
        .I1(\counter[0]_i_7__1_n_0 ),
        .I2(counter_reg[12]),
        .I3(counter_reg[11]),
        .I4(counter_reg[10]),
        .I5(counter_reg[13]),
        .O(\counter[0]_i_3__0_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \counter[0]_i_4__0 
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .O(\counter[0]_i_4__0_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_5__0 
       (.I0(counter_reg[0]),
        .O(\counter[0]_i_5__0_n_0 ));
  LUT6 #(
    .INIT(64'h8888888080808080)) 
    \counter[0]_i_6__0 
       (.I0(counter_reg[7]),
        .I1(counter_reg[6]),
        .I2(counter_reg[5]),
        .I3(counter_reg[3]),
        .I4(counter_reg[2]),
        .I5(counter_reg[4]),
        .O(\counter[0]_i_6__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \counter[0]_i_7__1 
       (.I0(counter_reg[8]),
        .I1(counter_reg[9]),
        .O(\counter[0]_i_7__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__0_n_7 ),
        .Q(counter_reg[0]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\counter_reg[0]_i_2__0_n_0 ,\counter_reg[0]_i_2__0_n_1 ,\counter_reg[0]_i_2__0_n_2 ,\counter_reg[0]_i_2__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter_reg[0]_i_2__0_n_4 ,\counter_reg[0]_i_2__0_n_5 ,\counter_reg[0]_i_2__0_n_6 ,\counter_reg[0]_i_2__0_n_7 }),
        .S({counter_reg[3:1],\counter[0]_i_5__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__0_n_5 ),
        .Q(counter_reg[10]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__0_n_4 ),
        .Q(counter_reg[11]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__0_n_7 ),
        .Q(counter_reg[12]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[12]_i_1__0 
       (.CI(\counter_reg[8]_i_1__0_n_0 ),
        .CO({\counter_reg[12]_i_1__0_n_0 ,\counter_reg[12]_i_1__0_n_1 ,\counter_reg[12]_i_1__0_n_2 ,\counter_reg[12]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[12]_i_1__0_n_4 ,\counter_reg[12]_i_1__0_n_5 ,\counter_reg[12]_i_1__0_n_6 ,\counter_reg[12]_i_1__0_n_7 }),
        .S(counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__0_n_6 ),
        .Q(counter_reg[13]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__0_n_5 ),
        .Q(counter_reg[14]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__0_n_4 ),
        .Q(counter_reg[15]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1__0_n_7 ),
        .Q(counter_reg[16]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[16]_i_1__0 
       (.CI(\counter_reg[12]_i_1__0_n_0 ),
        .CO({\counter_reg[16]_i_1__0_n_0 ,\counter_reg[16]_i_1__0_n_1 ,\counter_reg[16]_i_1__0_n_2 ,\counter_reg[16]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[16]_i_1__0_n_4 ,\counter_reg[16]_i_1__0_n_5 ,\counter_reg[16]_i_1__0_n_6 ,\counter_reg[16]_i_1__0_n_7 }),
        .S(counter_reg[19:16]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1__0_n_6 ),
        .Q(counter_reg[17]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1__0_n_5 ),
        .Q(counter_reg[18]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1__0_n_4 ),
        .Q(counter_reg[19]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__0_n_6 ),
        .Q(counter_reg[1]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1__0_n_7 ),
        .Q(counter_reg[20]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[20]_i_1__0 
       (.CI(\counter_reg[16]_i_1__0_n_0 ),
        .CO({\NLW_counter_reg[20]_i_1__0_CO_UNCONNECTED [3:1],\counter_reg[20]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counter_reg[20]_i_1__0_O_UNCONNECTED [3:2],\counter_reg[20]_i_1__0_n_6 ,\counter_reg[20]_i_1__0_n_7 }),
        .S({1'b0,1'b0,counter_reg[21:20]}));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1__0_n_6 ),
        .Q(counter_reg[21]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__0_n_5 ),
        .Q(counter_reg[2]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__0_n_4 ),
        .Q(counter_reg[3]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__0_n_7 ),
        .Q(counter_reg[4]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[4]_i_1__0 
       (.CI(\counter_reg[0]_i_2__0_n_0 ),
        .CO({\counter_reg[4]_i_1__0_n_0 ,\counter_reg[4]_i_1__0_n_1 ,\counter_reg[4]_i_1__0_n_2 ,\counter_reg[4]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[4]_i_1__0_n_4 ,\counter_reg[4]_i_1__0_n_5 ,\counter_reg[4]_i_1__0_n_6 ,\counter_reg[4]_i_1__0_n_7 }),
        .S(counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__0_n_6 ),
        .Q(counter_reg[5]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__0_n_5 ),
        .Q(counter_reg[6]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__0_n_4 ),
        .Q(counter_reg[7]),
        .R(\counter[0]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__0_n_7 ),
        .Q(counter_reg[8]),
        .R(\counter[0]_i_1__0_n_0 ));
  CARRY4 \counter_reg[8]_i_1__0 
       (.CI(\counter_reg[4]_i_1__0_n_0 ),
        .CO({\counter_reg[8]_i_1__0_n_0 ,\counter_reg[8]_i_1__0_n_1 ,\counter_reg[8]_i_1__0_n_2 ,\counter_reg[8]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[8]_i_1__0_n_4 ,\counter_reg[8]_i_1__0_n_5 ,\counter_reg[8]_i_1__0_n_6 ,\counter_reg[8]_i_1__0_n_7 }),
        .S(counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__0_n_6 ),
        .Q(counter_reg[9]),
        .R(\counter[0]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h37373777C8C8C888)) 
    dividedClk_i_1__0
       (.I0(\pipeline[0]_i_7__0_n_0 ),
        .I1(\pipeline[0]_i_6__0_n_0 ),
        .I2(counter_reg[17]),
        .I3(counter_reg[16]),
        .I4(dividedClk_i_2__0_n_0),
        .I5(dividedClk_reg_n_0),
        .O(dividedClk_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h8880888088808080)) 
    dividedClk_i_2__0
       (.I0(counter_reg[15]),
        .I1(counter_reg[14]),
        .I2(counter_reg[13]),
        .I3(dividedClk_i_3__0_n_0),
        .I4(\counter[0]_i_7__1_n_0 ),
        .I5(\counter[0]_i_6__0_n_0 ),
        .O(dividedClk_i_2__0_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    dividedClk_i_3__0
       (.I0(counter_reg[12]),
        .I1(counter_reg[11]),
        .I2(counter_reg[10]),
        .O(dividedClk_i_3__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dividedClk_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(dividedClk_i_1__0_n_0),
        .Q(dividedClk_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \pipeline[0]_i_1__0 
       (.I0(\pipeline[0]_i_2__0_n_0 ),
        .I1(\pipeline[0]_i_3__0_n_0 ),
        .I2(\pipeline[0]_i_4__0_n_0 ),
        .I3(\pipeline[0]_i_5__0_n_0 ),
        .I4(\pipeline[0]_i_6__0_n_0 ),
        .I5(\pipeline[0]_i_7__0_n_0 ),
        .O(E));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    \pipeline[0]_i_2__0 
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .I2(counter_reg[12]),
        .I3(counter_reg[13]),
        .I4(counter_reg[16]),
        .I5(counter_reg[17]),
        .O(\pipeline[0]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \pipeline[0]_i_3__0 
       (.I0(counter_reg[3]),
        .I1(counter_reg[2]),
        .I2(counter_reg[9]),
        .I3(counter_reg[8]),
        .O(\pipeline[0]_i_3__0_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \pipeline[0]_i_4__0 
       (.I0(counter_reg[1]),
        .I1(counter_reg[0]),
        .I2(dividedClk_reg_n_0),
        .O(\pipeline[0]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \pipeline[0]_i_5__0 
       (.I0(counter_reg[6]),
        .I1(counter_reg[7]),
        .I2(counter_reg[4]),
        .I3(counter_reg[5]),
        .I4(counter_reg[11]),
        .I5(counter_reg[10]),
        .O(\pipeline[0]_i_5__0_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pipeline[0]_i_6__0 
       (.I0(counter_reg[20]),
        .I1(counter_reg[21]),
        .O(\pipeline[0]_i_6__0_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \pipeline[0]_i_7__0 
       (.I0(counter_reg[18]),
        .I1(counter_reg[19]),
        .O(\pipeline[0]_i_7__0_n_0 ));
endmodule

(* ORIG_REF_NAME = "clockDividerHB" *) 
module clockDividerHB_2
   (E,
    clk_IBUF_BUFG);
  output [0:0]E;
  input clk_IBUF_BUFG;

  wire [0:0]E;
  wire clk_IBUF_BUFG;
  wire \counter[0]_i_1_n_0 ;
  wire \counter[0]_i_3_n_0 ;
  wire \counter[0]_i_4_n_0 ;
  wire \counter[0]_i_5_n_0 ;
  wire \counter[0]_i_6_n_0 ;
  wire \counter[0]_i_7__0_n_0 ;
  wire [21:0]counter_reg;
  wire \counter_reg[0]_i_2_n_0 ;
  wire \counter_reg[0]_i_2_n_1 ;
  wire \counter_reg[0]_i_2_n_2 ;
  wire \counter_reg[0]_i_2_n_3 ;
  wire \counter_reg[0]_i_2_n_4 ;
  wire \counter_reg[0]_i_2_n_5 ;
  wire \counter_reg[0]_i_2_n_6 ;
  wire \counter_reg[0]_i_2_n_7 ;
  wire \counter_reg[12]_i_1_n_0 ;
  wire \counter_reg[12]_i_1_n_1 ;
  wire \counter_reg[12]_i_1_n_2 ;
  wire \counter_reg[12]_i_1_n_3 ;
  wire \counter_reg[12]_i_1_n_4 ;
  wire \counter_reg[12]_i_1_n_5 ;
  wire \counter_reg[12]_i_1_n_6 ;
  wire \counter_reg[12]_i_1_n_7 ;
  wire \counter_reg[16]_i_1_n_0 ;
  wire \counter_reg[16]_i_1_n_1 ;
  wire \counter_reg[16]_i_1_n_2 ;
  wire \counter_reg[16]_i_1_n_3 ;
  wire \counter_reg[16]_i_1_n_4 ;
  wire \counter_reg[16]_i_1_n_5 ;
  wire \counter_reg[16]_i_1_n_6 ;
  wire \counter_reg[16]_i_1_n_7 ;
  wire \counter_reg[20]_i_1_n_3 ;
  wire \counter_reg[20]_i_1_n_6 ;
  wire \counter_reg[20]_i_1_n_7 ;
  wire \counter_reg[4]_i_1_n_0 ;
  wire \counter_reg[4]_i_1_n_1 ;
  wire \counter_reg[4]_i_1_n_2 ;
  wire \counter_reg[4]_i_1_n_3 ;
  wire \counter_reg[4]_i_1_n_4 ;
  wire \counter_reg[4]_i_1_n_5 ;
  wire \counter_reg[4]_i_1_n_6 ;
  wire \counter_reg[4]_i_1_n_7 ;
  wire \counter_reg[8]_i_1_n_0 ;
  wire \counter_reg[8]_i_1_n_1 ;
  wire \counter_reg[8]_i_1_n_2 ;
  wire \counter_reg[8]_i_1_n_3 ;
  wire \counter_reg[8]_i_1_n_4 ;
  wire \counter_reg[8]_i_1_n_5 ;
  wire \counter_reg[8]_i_1_n_6 ;
  wire \counter_reg[8]_i_1_n_7 ;
  wire dividedClk_i_1_n_0;
  wire dividedClk_i_2_n_0;
  wire dividedClk_i_3_n_0;
  wire dividedClk_reg_n_0;
  wire \pipeline[0]_i_2_n_0 ;
  wire \pipeline[0]_i_3_n_0 ;
  wire \pipeline[0]_i_4_n_0 ;
  wire \pipeline[0]_i_5_n_0 ;
  wire \pipeline[0]_i_6_n_0 ;
  wire \pipeline[0]_i_7_n_0 ;
  wire [3:1]\NLW_counter_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_counter_reg[20]_i_1_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hFFFF0000F8000000)) 
    \counter[0]_i_1 
       (.I0(\counter[0]_i_3_n_0 ),
        .I1(\counter[0]_i_4_n_0 ),
        .I2(counter_reg[16]),
        .I3(counter_reg[17]),
        .I4(\pipeline[0]_i_6_n_0 ),
        .I5(\pipeline[0]_i_7_n_0 ),
        .O(\counter[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0000000)) 
    \counter[0]_i_3 
       (.I0(\counter[0]_i_6_n_0 ),
        .I1(\counter[0]_i_7__0_n_0 ),
        .I2(counter_reg[12]),
        .I3(counter_reg[11]),
        .I4(counter_reg[10]),
        .I5(counter_reg[13]),
        .O(\counter[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \counter[0]_i_4 
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .O(\counter[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_5 
       (.I0(counter_reg[0]),
        .O(\counter[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8888888080808080)) 
    \counter[0]_i_6 
       (.I0(counter_reg[7]),
        .I1(counter_reg[6]),
        .I2(counter_reg[5]),
        .I3(counter_reg[3]),
        .I4(counter_reg[2]),
        .I5(counter_reg[4]),
        .O(\counter[0]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \counter[0]_i_7__0 
       (.I0(counter_reg[8]),
        .I1(counter_reg[9]),
        .O(\counter[0]_i_7__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_7 ),
        .Q(counter_reg[0]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\counter_reg[0]_i_2_n_0 ,\counter_reg[0]_i_2_n_1 ,\counter_reg[0]_i_2_n_2 ,\counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter_reg[0]_i_2_n_4 ,\counter_reg[0]_i_2_n_5 ,\counter_reg[0]_i_2_n_6 ,\counter_reg[0]_i_2_n_7 }),
        .S({counter_reg[3:1],\counter[0]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_5 ),
        .Q(counter_reg[10]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_4 ),
        .Q(counter_reg[11]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_7 ),
        .Q(counter_reg[12]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[12]_i_1 
       (.CI(\counter_reg[8]_i_1_n_0 ),
        .CO({\counter_reg[12]_i_1_n_0 ,\counter_reg[12]_i_1_n_1 ,\counter_reg[12]_i_1_n_2 ,\counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[12]_i_1_n_4 ,\counter_reg[12]_i_1_n_5 ,\counter_reg[12]_i_1_n_6 ,\counter_reg[12]_i_1_n_7 }),
        .S(counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_6 ),
        .Q(counter_reg[13]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_5 ),
        .Q(counter_reg[14]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1_n_4 ),
        .Q(counter_reg[15]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[16] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_7 ),
        .Q(counter_reg[16]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[16]_i_1 
       (.CI(\counter_reg[12]_i_1_n_0 ),
        .CO({\counter_reg[16]_i_1_n_0 ,\counter_reg[16]_i_1_n_1 ,\counter_reg[16]_i_1_n_2 ,\counter_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[16]_i_1_n_4 ,\counter_reg[16]_i_1_n_5 ,\counter_reg[16]_i_1_n_6 ,\counter_reg[16]_i_1_n_7 }),
        .S(counter_reg[19:16]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[17] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_6 ),
        .Q(counter_reg[17]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[18] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_5 ),
        .Q(counter_reg[18]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[19] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[16]_i_1_n_4 ),
        .Q(counter_reg[19]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_6 ),
        .Q(counter_reg[1]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[20] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_7 ),
        .Q(counter_reg[20]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[20]_i_1 
       (.CI(\counter_reg[16]_i_1_n_0 ),
        .CO({\NLW_counter_reg[20]_i_1_CO_UNCONNECTED [3:1],\counter_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_counter_reg[20]_i_1_O_UNCONNECTED [3:2],\counter_reg[20]_i_1_n_6 ,\counter_reg[20]_i_1_n_7 }),
        .S({1'b0,1'b0,counter_reg[21:20]}));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[21] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[20]_i_1_n_6 ),
        .Q(counter_reg[21]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_5 ),
        .Q(counter_reg[2]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2_n_4 ),
        .Q(counter_reg[3]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_7 ),
        .Q(counter_reg[4]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[4]_i_1 
       (.CI(\counter_reg[0]_i_2_n_0 ),
        .CO({\counter_reg[4]_i_1_n_0 ,\counter_reg[4]_i_1_n_1 ,\counter_reg[4]_i_1_n_2 ,\counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[4]_i_1_n_4 ,\counter_reg[4]_i_1_n_5 ,\counter_reg[4]_i_1_n_6 ,\counter_reg[4]_i_1_n_7 }),
        .S(counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_6 ),
        .Q(counter_reg[5]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_5 ),
        .Q(counter_reg[6]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1_n_4 ),
        .Q(counter_reg[7]),
        .R(\counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_7 ),
        .Q(counter_reg[8]),
        .R(\counter[0]_i_1_n_0 ));
  CARRY4 \counter_reg[8]_i_1 
       (.CI(\counter_reg[4]_i_1_n_0 ),
        .CO({\counter_reg[8]_i_1_n_0 ,\counter_reg[8]_i_1_n_1 ,\counter_reg[8]_i_1_n_2 ,\counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[8]_i_1_n_4 ,\counter_reg[8]_i_1_n_5 ,\counter_reg[8]_i_1_n_6 ,\counter_reg[8]_i_1_n_7 }),
        .S(counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1_n_6 ),
        .Q(counter_reg[9]),
        .R(\counter[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h37373777C8C8C888)) 
    dividedClk_i_1
       (.I0(\pipeline[0]_i_7_n_0 ),
        .I1(\pipeline[0]_i_6_n_0 ),
        .I2(counter_reg[17]),
        .I3(counter_reg[16]),
        .I4(dividedClk_i_2_n_0),
        .I5(dividedClk_reg_n_0),
        .O(dividedClk_i_1_n_0));
  LUT6 #(
    .INIT(64'h8880888088808080)) 
    dividedClk_i_2
       (.I0(counter_reg[15]),
        .I1(counter_reg[14]),
        .I2(counter_reg[13]),
        .I3(dividedClk_i_3_n_0),
        .I4(\counter[0]_i_7__0_n_0 ),
        .I5(\counter[0]_i_6_n_0 ),
        .O(dividedClk_i_2_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    dividedClk_i_3
       (.I0(counter_reg[12]),
        .I1(counter_reg[11]),
        .I2(counter_reg[10]),
        .O(dividedClk_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dividedClk_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(dividedClk_i_1_n_0),
        .Q(dividedClk_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \pipeline[0]_i_1 
       (.I0(\pipeline[0]_i_2_n_0 ),
        .I1(\pipeline[0]_i_3_n_0 ),
        .I2(\pipeline[0]_i_4_n_0 ),
        .I3(\pipeline[0]_i_5_n_0 ),
        .I4(\pipeline[0]_i_6_n_0 ),
        .I5(\pipeline[0]_i_7_n_0 ),
        .O(E));
  LUT6 #(
    .INIT(64'h0000008000000000)) 
    \pipeline[0]_i_2 
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .I2(counter_reg[12]),
        .I3(counter_reg[13]),
        .I4(counter_reg[16]),
        .I5(counter_reg[17]),
        .O(\pipeline[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \pipeline[0]_i_3 
       (.I0(counter_reg[3]),
        .I1(counter_reg[2]),
        .I2(counter_reg[9]),
        .I3(counter_reg[8]),
        .O(\pipeline[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \pipeline[0]_i_4 
       (.I0(counter_reg[1]),
        .I1(counter_reg[0]),
        .I2(dividedClk_reg_n_0),
        .O(\pipeline[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \pipeline[0]_i_5 
       (.I0(counter_reg[6]),
        .I1(counter_reg[7]),
        .I2(counter_reg[4]),
        .I3(counter_reg[5]),
        .I4(counter_reg[11]),
        .I5(counter_reg[10]),
        .O(\pipeline[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pipeline[0]_i_6 
       (.I0(counter_reg[20]),
        .I1(counter_reg[21]),
        .O(\pipeline[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \pipeline[0]_i_7 
       (.I0(counter_reg[18]),
        .I1(counter_reg[19]),
        .O(\pipeline[0]_i_7_n_0 ));
endmodule

(* ORIG_REF_NAME = "clockDividerHB" *) 
module clockDividerHB__parameterized0
   (CLK,
    clk_IBUF_BUFG);
  output CLK;
  input clk_IBUF_BUFG;

  wire CLK;
  wire \activeDisplay[3]_i_2_n_0 ;
  wire \activeDisplay[3]_i_3_n_0 ;
  wire clk_IBUF_BUFG;
  wire \counter[0]_i_1__1_n_0 ;
  wire \counter[0]_i_3__1_n_0 ;
  wire \counter[0]_i_4__1_n_0 ;
  wire \counter[0]_i_5__1_n_0 ;
  wire \counter[0]_i_6__1_n_0 ;
  wire \counter[0]_i_7_n_0 ;
  wire [15:0]counter_reg;
  wire \counter_reg[0]_i_2__1_n_0 ;
  wire \counter_reg[0]_i_2__1_n_1 ;
  wire \counter_reg[0]_i_2__1_n_2 ;
  wire \counter_reg[0]_i_2__1_n_3 ;
  wire \counter_reg[0]_i_2__1_n_4 ;
  wire \counter_reg[0]_i_2__1_n_5 ;
  wire \counter_reg[0]_i_2__1_n_6 ;
  wire \counter_reg[0]_i_2__1_n_7 ;
  wire \counter_reg[12]_i_1__1_n_1 ;
  wire \counter_reg[12]_i_1__1_n_2 ;
  wire \counter_reg[12]_i_1__1_n_3 ;
  wire \counter_reg[12]_i_1__1_n_4 ;
  wire \counter_reg[12]_i_1__1_n_5 ;
  wire \counter_reg[12]_i_1__1_n_6 ;
  wire \counter_reg[12]_i_1__1_n_7 ;
  wire \counter_reg[4]_i_1__1_n_0 ;
  wire \counter_reg[4]_i_1__1_n_1 ;
  wire \counter_reg[4]_i_1__1_n_2 ;
  wire \counter_reg[4]_i_1__1_n_3 ;
  wire \counter_reg[4]_i_1__1_n_4 ;
  wire \counter_reg[4]_i_1__1_n_5 ;
  wire \counter_reg[4]_i_1__1_n_6 ;
  wire \counter_reg[4]_i_1__1_n_7 ;
  wire \counter_reg[8]_i_1__1_n_0 ;
  wire \counter_reg[8]_i_1__1_n_1 ;
  wire \counter_reg[8]_i_1__1_n_2 ;
  wire \counter_reg[8]_i_1__1_n_3 ;
  wire \counter_reg[8]_i_1__1_n_4 ;
  wire \counter_reg[8]_i_1__1_n_5 ;
  wire \counter_reg[8]_i_1__1_n_6 ;
  wire \counter_reg[8]_i_1__1_n_7 ;
  wire dividedClk_i_1__1_n_0;
  wire dividedClk_reg_n_0;
  wire [3:3]\NLW_counter_reg[12]_i_1__1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \activeDisplay[3]_i_1 
       (.I0(counter_reg[11]),
        .I1(counter_reg[10]),
        .I2(counter_reg[13]),
        .I3(counter_reg[12]),
        .I4(\activeDisplay[3]_i_2_n_0 ),
        .I5(\activeDisplay[3]_i_3_n_0 ),
        .O(CLK));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \activeDisplay[3]_i_2 
       (.I0(counter_reg[4]),
        .I1(counter_reg[5]),
        .I2(\counter[0]_i_5__1_n_0 ),
        .I3(dividedClk_reg_n_0),
        .I4(counter_reg[0]),
        .I5(counter_reg[1]),
        .O(\activeDisplay[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    \activeDisplay[3]_i_3 
       (.I0(counter_reg[6]),
        .I1(counter_reg[7]),
        .I2(counter_reg[2]),
        .I3(counter_reg[3]),
        .I4(counter_reg[9]),
        .I5(counter_reg[8]),
        .O(\activeDisplay[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000F8000000)) 
    \counter[0]_i_1__1 
       (.I0(counter_reg[6]),
        .I1(\counter[0]_i_3__1_n_0 ),
        .I2(counter_reg[7]),
        .I3(\counter[0]_i_4__1_n_0 ),
        .I4(\counter[0]_i_5__1_n_0 ),
        .I5(\counter[0]_i_6__1_n_0 ),
        .O(\counter[0]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    \counter[0]_i_3__1 
       (.I0(counter_reg[2]),
        .I1(counter_reg[3]),
        .I2(counter_reg[0]),
        .I3(counter_reg[1]),
        .I4(counter_reg[5]),
        .I5(counter_reg[4]),
        .O(\counter[0]_i_3__1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \counter[0]_i_4__1 
       (.I0(counter_reg[8]),
        .I1(counter_reg[9]),
        .O(\counter[0]_i_4__1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \counter[0]_i_5__1 
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .O(\counter[0]_i_5__1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \counter[0]_i_6__1 
       (.I0(counter_reg[11]),
        .I1(counter_reg[10]),
        .I2(counter_reg[13]),
        .I3(counter_reg[12]),
        .O(\counter[0]_i_6__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_7 
       (.I0(counter_reg[0]),
        .O(\counter[0]_i_7_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__1_n_7 ),
        .Q(counter_reg[0]),
        .R(\counter[0]_i_1__1_n_0 ));
  CARRY4 \counter_reg[0]_i_2__1 
       (.CI(1'b0),
        .CO({\counter_reg[0]_i_2__1_n_0 ,\counter_reg[0]_i_2__1_n_1 ,\counter_reg[0]_i_2__1_n_2 ,\counter_reg[0]_i_2__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter_reg[0]_i_2__1_n_4 ,\counter_reg[0]_i_2__1_n_5 ,\counter_reg[0]_i_2__1_n_6 ,\counter_reg[0]_i_2__1_n_7 }),
        .S({counter_reg[3:1],\counter[0]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__1_n_5 ),
        .Q(counter_reg[10]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__1_n_4 ),
        .Q(counter_reg[11]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__1_n_7 ),
        .Q(counter_reg[12]),
        .R(\counter[0]_i_1__1_n_0 ));
  CARRY4 \counter_reg[12]_i_1__1 
       (.CI(\counter_reg[8]_i_1__1_n_0 ),
        .CO({\NLW_counter_reg[12]_i_1__1_CO_UNCONNECTED [3],\counter_reg[12]_i_1__1_n_1 ,\counter_reg[12]_i_1__1_n_2 ,\counter_reg[12]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[12]_i_1__1_n_4 ,\counter_reg[12]_i_1__1_n_5 ,\counter_reg[12]_i_1__1_n_6 ,\counter_reg[12]_i_1__1_n_7 }),
        .S(counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__1_n_6 ),
        .Q(counter_reg[13]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__1_n_5 ),
        .Q(counter_reg[14]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[12]_i_1__1_n_4 ),
        .Q(counter_reg[15]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__1_n_6 ),
        .Q(counter_reg[1]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__1_n_5 ),
        .Q(counter_reg[2]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[0]_i_2__1_n_4 ),
        .Q(counter_reg[3]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__1_n_7 ),
        .Q(counter_reg[4]),
        .R(\counter[0]_i_1__1_n_0 ));
  CARRY4 \counter_reg[4]_i_1__1 
       (.CI(\counter_reg[0]_i_2__1_n_0 ),
        .CO({\counter_reg[4]_i_1__1_n_0 ,\counter_reg[4]_i_1__1_n_1 ,\counter_reg[4]_i_1__1_n_2 ,\counter_reg[4]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[4]_i_1__1_n_4 ,\counter_reg[4]_i_1__1_n_5 ,\counter_reg[4]_i_1__1_n_6 ,\counter_reg[4]_i_1__1_n_7 }),
        .S(counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__1_n_6 ),
        .Q(counter_reg[5]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__1_n_5 ),
        .Q(counter_reg[6]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[4]_i_1__1_n_4 ),
        .Q(counter_reg[7]),
        .R(\counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__1_n_7 ),
        .Q(counter_reg[8]),
        .R(\counter[0]_i_1__1_n_0 ));
  CARRY4 \counter_reg[8]_i_1__1 
       (.CI(\counter_reg[4]_i_1__1_n_0 ),
        .CO({\counter_reg[8]_i_1__1_n_0 ,\counter_reg[8]_i_1__1_n_1 ,\counter_reg[8]_i_1__1_n_2 ,\counter_reg[8]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[8]_i_1__1_n_4 ,\counter_reg[8]_i_1__1_n_5 ,\counter_reg[8]_i_1__1_n_6 ,\counter_reg[8]_i_1__1_n_7 }),
        .S(counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\counter_reg[8]_i_1__1_n_6 ),
        .Q(counter_reg[9]),
        .R(\counter[0]_i_1__1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    dividedClk_i_1__1
       (.I0(\counter[0]_i_1__1_n_0 ),
        .I1(dividedClk_reg_n_0),
        .O(dividedClk_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dividedClk_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(dividedClk_i_1__1_n_0),
        .Q(dividedClk_reg_n_0),
        .R(1'b0));
endmodule

module debouncer
   (D,
    \pipeline_reg[0]_0 ,
    btn_E_deb,
    clk_IBUF_BUFG,
    Q,
    B,
    \pipeline_reg[0]_1 );
  output [2:0]D;
  output \pipeline_reg[0]_0 ;
  output btn_E_deb;
  input clk_IBUF_BUFG;
  input [3:0]Q;
  input B;
  input [0:0]\pipeline_reg[0]_1 ;

  wire B;
  wire [2:0]D;
  wire [3:0]Q;
  wire beat;
  wire btn_E_deb;
  wire clk_IBUF_BUFG;
  wire [2:1]p_0_in;
  wire \pipeline[1]_i_1_n_0 ;
  wire \pipeline[2]_i_1_n_0 ;
  wire \pipeline_reg[0]_0 ;
  wire [0:0]\pipeline_reg[0]_1 ;
  wire \pipeline_reg_n_0_[2] ;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h80)) 
    B_i_1
       (.I0(p_0_in[1]),
        .I1(p_0_in[2]),
        .I2(\pipeline_reg_n_0_[2] ),
        .O(btn_E_deb));
  clockDividerHB_2 clockdividerHB_inst
       (.E(beat),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipeline[1]_i_1 
       (.I0(p_0_in[1]),
        .I1(beat),
        .I2(p_0_in[2]),
        .O(\pipeline[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipeline[2]_i_1 
       (.I0(p_0_in[2]),
        .I1(beat),
        .I2(\pipeline_reg_n_0_[2] ),
        .O(\pipeline[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(beat),
        .D(\pipeline_reg[0]_1 ),
        .Q(p_0_in[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\pipeline[1]_i_1_n_0 ),
        .Q(p_0_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\pipeline[2]_i_1_n_0 ),
        .Q(\pipeline_reg_n_0_[2] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h9699999999999999)) 
    \wordCount[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(B),
        .I3(\pipeline_reg_n_0_[2] ),
        .I4(p_0_in[2]),
        .I5(p_0_in[1]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hC69C)) 
    \wordCount[2]_i_1 
       (.I0(Q[1]),
        .I1(Q[2]),
        .I2(\pipeline_reg[0]_0 ),
        .I3(Q[0]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hB4F0F0D2)) 
    \wordCount[3]_i_2 
       (.I0(\pipeline_reg[0]_0 ),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[2]),
        .I4(Q[0]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    \wordCount[3]_i_3 
       (.I0(p_0_in[1]),
        .I1(p_0_in[2]),
        .I2(\pipeline_reg_n_0_[2] ),
        .I3(B),
        .O(\pipeline_reg[0]_0 ));
endmodule

(* ORIG_REF_NAME = "debouncer" *) 
module debouncer_0
   (E,
    btn_W_deb,
    clk_IBUF_BUFG,
    B,
    \wordCount_reg[3] ,
    D);
  output [0:0]E;
  output btn_W_deb;
  input clk_IBUF_BUFG;
  input B;
  input \wordCount_reg[3] ;
  input [0:0]D;

  wire B;
  wire [0:0]D;
  wire [0:0]E;
  wire beat;
  wire btn_W_deb;
  wire clk_IBUF_BUFG;
  wire [2:1]p_0_in__0;
  wire \pipeline[1]_i_1_n_0 ;
  wire \pipeline[2]_i_1_n_0 ;
  wire \pipeline_reg_n_0_[2] ;
  wire \wordCount_reg[3] ;

  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h80)) 
    B_i_1__0
       (.I0(\pipeline_reg_n_0_[2] ),
        .I1(p_0_in__0[2]),
        .I2(p_0_in__0[1]),
        .O(btn_W_deb));
  clockDividerHB clockdividerHB_inst
       (.E(beat),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipeline[1]_i_1 
       (.I0(p_0_in__0[1]),
        .I1(beat),
        .I2(p_0_in__0[2]),
        .O(\pipeline[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \pipeline[2]_i_1 
       (.I0(p_0_in__0[2]),
        .I1(beat),
        .I2(\pipeline_reg_n_0_[2] ),
        .O(\pipeline[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(beat),
        .D(D),
        .Q(p_0_in__0[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\pipeline[1]_i_1_n_0 ),
        .Q(p_0_in__0[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \pipeline_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\pipeline[2]_i_1_n_0 ),
        .Q(\pipeline_reg_n_0_[2] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h0080FFFF)) 
    \wordCount[3]_i_1 
       (.I0(p_0_in__0[2]),
        .I1(\pipeline_reg_n_0_[2] ),
        .I2(p_0_in__0[1]),
        .I3(B),
        .I4(\wordCount_reg[3] ),
        .O(E));
endmodule

module displayDriver
   (ssdAnode_OBUF,
    ssdCathode_OBUF,
    clk_IBUF_BUFG,
    Q);
  output [5:0]ssdAnode_OBUF;
  output [3:0]ssdCathode_OBUF;
  input clk_IBUF_BUFG;
  input [3:0]Q;

  wire [3:0]Q;
  wire [3:0]activeDisplay;
  wire beat;
  wire clk_IBUF_BUFG;
  wire [5:0]ssdAnode_OBUF;
  wire \ssdAnode_OBUF[1]_inst_i_2_n_0 ;
  wire \ssdAnode_OBUF[6]_inst_i_2_n_0 ;
  wire [3:0]ssdCathode_OBUF;

  FDRE #(
    .INIT(1'b1)) 
    \activeDisplay_reg[0] 
       (.C(beat),
        .CE(1'b1),
        .D(activeDisplay[3]),
        .Q(activeDisplay[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \activeDisplay_reg[1] 
       (.C(beat),
        .CE(1'b1),
        .D(activeDisplay[0]),
        .Q(activeDisplay[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \activeDisplay_reg[2] 
       (.C(beat),
        .CE(1'b1),
        .D(activeDisplay[1]),
        .Q(activeDisplay[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \activeDisplay_reg[3] 
       (.C(beat),
        .CE(1'b1),
        .D(activeDisplay[2]),
        .Q(activeDisplay[3]),
        .R(1'b0));
  clockDividerHB__parameterized0 clk_div_inst
       (.CLK(beat),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  LUT6 #(
    .INIT(64'h0400400040000000)) 
    \ssdAnode_OBUF[1]_inst_i_1 
       (.I0(Q[3]),
        .I1(activeDisplay[3]),
        .I2(activeDisplay[0]),
        .I3(\ssdAnode_OBUF[1]_inst_i_2_n_0 ),
        .I4(activeDisplay[2]),
        .I5(activeDisplay[1]),
        .O(ssdAnode_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \ssdAnode_OBUF[1]_inst_i_2 
       (.I0(Q[1]),
        .I1(Q[2]),
        .O(\ssdAnode_OBUF[1]_inst_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hFFFFF8FF)) 
    \ssdAnode_OBUF[2]_inst_i_1 
       (.I0(Q[1]),
        .I1(Q[2]),
        .I2(Q[3]),
        .I3(activeDisplay[0]),
        .I4(\ssdAnode_OBUF[6]_inst_i_2_n_0 ),
        .O(ssdAnode_OBUF[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
    \ssdAnode_OBUF[3]_inst_i_1 
       (.I0(Q[1]),
        .I1(\ssdAnode_OBUF[6]_inst_i_2_n_0 ),
        .I2(Q[3]),
        .I3(activeDisplay[0]),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(ssdAnode_OBUF[2]));
  LUT6 #(
    .INIT(64'hFFFFFFDFFFEFFFDF)) 
    \ssdAnode_OBUF[4]_inst_i_1 
       (.I0(Q[0]),
        .I1(\ssdAnode_OBUF[6]_inst_i_2_n_0 ),
        .I2(activeDisplay[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(Q[1]),
        .O(ssdAnode_OBUF[3]));
  LUT6 #(
    .INIT(64'hFFFBFBFBFFFBFFFF)) 
    \ssdAnode_OBUF[5]_inst_i_1 
       (.I0(\ssdAnode_OBUF[6]_inst_i_2_n_0 ),
        .I1(activeDisplay[0]),
        .I2(Q[3]),
        .I3(Q[1]),
        .I4(Q[2]),
        .I5(Q[0]),
        .O(ssdAnode_OBUF[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFAEFFFF)) 
    \ssdAnode_OBUF[6]_inst_i_1 
       (.I0(\ssdAnode_OBUF[6]_inst_i_2_n_0 ),
        .I1(Q[2]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(activeDisplay[0]),
        .I5(Q[1]),
        .O(ssdAnode_OBUF[5]));
  LUT3 #(
    .INIT(8'hF7)) 
    \ssdAnode_OBUF[6]_inst_i_2 
       (.I0(activeDisplay[2]),
        .I1(activeDisplay[1]),
        .I2(activeDisplay[3]),
        .O(\ssdAnode_OBUF[6]_inst_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hDFFF)) 
    \ssdCathode_OBUF[0]_inst_i_1 
       (.I0(activeDisplay[3]),
        .I1(activeDisplay[0]),
        .I2(activeDisplay[2]),
        .I3(activeDisplay[1]),
        .O(ssdCathode_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hDFFF)) 
    \ssdCathode_OBUF[1]_inst_i_1 
       (.I0(activeDisplay[0]),
        .I1(activeDisplay[1]),
        .I2(activeDisplay[3]),
        .I3(activeDisplay[2]),
        .O(ssdCathode_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    \ssdCathode_OBUF[2]_inst_i_1 
       (.I0(activeDisplay[1]),
        .I1(activeDisplay[0]),
        .I2(activeDisplay[3]),
        .I3(activeDisplay[2]),
        .O(ssdCathode_OBUF[2]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hBFFF)) 
    \ssdCathode_OBUF[3]_inst_i_1 
       (.I0(activeDisplay[3]),
        .I1(activeDisplay[1]),
        .I2(activeDisplay[2]),
        .I3(activeDisplay[0]),
        .O(ssdCathode_OBUF[3]));
endmodule

module spot
   (B,
    btn_E_deb,
    clk_IBUF_BUFG);
  output B;
  input btn_E_deb;
  input clk_IBUF_BUFG;

  wire B;
  wire btn_E_deb;
  wire clk_IBUF_BUFG;

  FDRE #(
    .INIT(1'b0)) 
    B_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(btn_E_deb),
        .Q(B),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "spot" *) 
module spot_1
   (B,
    btn_W_deb,
    clk_IBUF_BUFG);
  output B;
  input btn_W_deb;
  input clk_IBUF_BUFG;

  wire B;
  wire btn_W_deb;
  wire clk_IBUF_BUFG;

  FDRE #(
    .INIT(1'b0)) 
    B_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(btn_W_deb),
        .Q(B),
        .R(1'b0));
endmodule

(* NotValidForBitStream *)
module wordDisplay_TOP
   (clk,
    btn_E,
    btn_W,
    ssdAnode,
    ssdCathode);
  input clk;
  input btn_E;
  input btn_W;
  output [6:0]ssdAnode;
  output [3:0]ssdCathode;

  wire B;
  wire B_0;
  wire btn_E;
  wire btn_E_IBUF;
  wire btn_E_deb;
  wire btn_W;
  wire btn_W_IBUF;
  wire btn_W_deb;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire debounce_inst_E_n_0;
  wire debounce_inst_E_n_1;
  wire debounce_inst_E_n_2;
  wire debounce_inst_E_n_3;
  wire debounce_inst_W_n_0;
  wire [6:0]ssdAnode;
  wire [6:1]ssdAnode_OBUF;
  wire [3:0]ssdCathode;
  wire [3:0]ssdCathode_OBUF;
  wire \wordCount[0]_i_1_n_0 ;
  wire [3:0]wordCount_reg;

  IBUF btn_E_IBUF_inst
       (.I(btn_E),
        .O(btn_E_IBUF));
  IBUF btn_W_IBUF_inst
       (.I(btn_W),
        .O(btn_W_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  debouncer debounce_inst_E
       (.B(B),
        .D({debounce_inst_E_n_0,debounce_inst_E_n_1,debounce_inst_E_n_2}),
        .Q(wordCount_reg),
        .btn_E_deb(btn_E_deb),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .\pipeline_reg[0]_0 (debounce_inst_E_n_3),
        .\pipeline_reg[0]_1 (btn_E_IBUF));
  debouncer_0 debounce_inst_W
       (.B(B_0),
        .D(btn_W_IBUF),
        .E(debounce_inst_W_n_0),
        .btn_W_deb(btn_W_deb),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .\wordCount_reg[3] (debounce_inst_E_n_3));
  displayDriver seven_seg_inst
       (.Q(wordCount_reg),
        .clk_IBUF_BUFG(clk_IBUF_BUFG),
        .ssdAnode_OBUF(ssdAnode_OBUF),
        .ssdCathode_OBUF(ssdCathode_OBUF));
  spot spot_inst_E
       (.B(B),
        .btn_E_deb(btn_E_deb),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  spot_1 spot_inst_W
       (.B(B_0),
        .btn_W_deb(btn_W_deb),
        .clk_IBUF_BUFG(clk_IBUF_BUFG));
  OBUF \ssdAnode_OBUF[0]_inst 
       (.I(1'b0),
        .O(ssdAnode[0]));
  OBUF \ssdAnode_OBUF[1]_inst 
       (.I(ssdAnode_OBUF[1]),
        .O(ssdAnode[1]));
  OBUF \ssdAnode_OBUF[2]_inst 
       (.I(ssdAnode_OBUF[2]),
        .O(ssdAnode[2]));
  OBUF \ssdAnode_OBUF[3]_inst 
       (.I(ssdAnode_OBUF[3]),
        .O(ssdAnode[3]));
  OBUF \ssdAnode_OBUF[4]_inst 
       (.I(ssdAnode_OBUF[4]),
        .O(ssdAnode[4]));
  OBUF \ssdAnode_OBUF[5]_inst 
       (.I(ssdAnode_OBUF[5]),
        .O(ssdAnode[5]));
  OBUF \ssdAnode_OBUF[6]_inst 
       (.I(ssdAnode_OBUF[6]),
        .O(ssdAnode[6]));
  OBUF \ssdCathode_OBUF[0]_inst 
       (.I(ssdCathode_OBUF[0]),
        .O(ssdCathode[0]));
  OBUF \ssdCathode_OBUF[1]_inst 
       (.I(ssdCathode_OBUF[1]),
        .O(ssdCathode[1]));
  OBUF \ssdCathode_OBUF[2]_inst 
       (.I(ssdCathode_OBUF[2]),
        .O(ssdCathode[2]));
  OBUF \ssdCathode_OBUF[3]_inst 
       (.I(ssdCathode_OBUF[3]),
        .O(ssdCathode[3]));
  LUT1 #(
    .INIT(2'h1)) 
    \wordCount[0]_i_1 
       (.I0(wordCount_reg[0]),
        .O(\wordCount[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \wordCount_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(debounce_inst_W_n_0),
        .D(\wordCount[0]_i_1_n_0 ),
        .Q(wordCount_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wordCount_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(debounce_inst_W_n_0),
        .D(debounce_inst_E_n_2),
        .Q(wordCount_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wordCount_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(debounce_inst_W_n_0),
        .D(debounce_inst_E_n_1),
        .Q(wordCount_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \wordCount_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(debounce_inst_W_n_0),
        .D(debounce_inst_E_n_0),
        .Q(wordCount_reg[3]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
