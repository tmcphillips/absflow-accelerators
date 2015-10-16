////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: FourBitCounterWithLoad.v
// /___/   /\     Timestamp: Wed Feb 29 17:56:28 2012
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -ofmt verilog -intstyle silent -w FourBitCounterWithLoad.ngc FourBitCounterWithLoad.v 
// Device	: xc3s250etq144-5
// Input file	: FourBitCounterWithLoad.ngc
// Output file	: FourBitCounterWithLoad.v
// # of Modules	: 1
// Design Name	: FourBitCounterWithLoad
// Xilinx        : C:\Xilinx\10.1\ISE
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module FourBitCounterWithLoad (
  downButton, systemClock, loadButton, upButton, resetButton, counter, switches
);
  input downButton;
  input systemClock;
  input loadButton;
  input upButton;
  input resetButton;
  output [3 : 0] counter;
  input [3 : 0] switches;
  wire N01;
  wire N1;
  wire N15;
  wire N16;
  wire N22;
  wire N24;
  wire N26;
  wire N28;
  wire N29;
  wire N31;
  wire downButton_IBUF_15;
  wire loadButton_IBUF_17;
  wire resetButton_IBUF_19;
  wire switches_0_IBUF_24;
  wire switches_1_IBUF_25;
  wire switches_2_IBUF_26;
  wire switches_3_IBUF_27;
  wire systemClock_BUFGP_29;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_31 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_33 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_35 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_37 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_39 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_41 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_43 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_45 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_47 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_51 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_53 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_55 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_57 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_59 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_61 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_63 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_65 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/nq ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_67 ;
  wire \u1rs/u1rc/u0tff/nq ;
  wire \u1rs/u1rc/u0tff/q_69 ;
  wire \u2bpd/state_FSM_FFd1_70 ;
  wire \u2bpd/state_FSM_FFd1-In_71 ;
  wire \u2bpd/state_FSM_FFd2_72 ;
  wire \u2bpd/state_FSM_FFd2-In ;
  wire \u2bpd/state_FSM_FFd3_74 ;
  wire \u2bpd/state_FSM_FFd3-In ;
  wire \u3bpd/state_FSM_FFd1_76 ;
  wire \u3bpd/state_FSM_FFd1-In_77 ;
  wire \u3bpd/state_FSM_FFd2_78 ;
  wire \u3bpd/state_FSM_FFd2-In ;
  wire \u3bpd/state_FSM_FFd3_80 ;
  wire \u3bpd/state_FSM_FFd3-In ;
  wire \u4udc/Mcount_counter1 ;
  wire \u4udc/Mcount_counter10 ;
  wire \u4udc/Mcount_counter4 ;
  wire \u4udc/Mcount_counter7 ;
  wire \u4udc/Mcount_counter_xor<2>169_86 ;
  wire \u4udc/Mcount_counter_xor<2>170 ;
  wire \u4udc/counter_not0001_92 ;
  wire \u4udc/state_FSM_FFd1_93 ;
  wire \u4udc/state_FSM_FFd1-In ;
  wire \u4udc/state_FSM_FFd2_95 ;
  wire \u4udc/state_FSM_FFd2-In ;
  wire upButton_IBUF_98;
  wire NLW_dcm_instance_CLKIN_UNCONNECTED;
  wire NLW_dcm_instance_CLKFB_UNCONNECTED;
  wire NLW_dcm_instance_RST_UNCONNECTED;
  wire NLW_dcm_instance_DSSEN_UNCONNECTED;
  wire NLW_dcm_instance_PSINCDEC_UNCONNECTED;
  wire NLW_dcm_instance_PSEN_UNCONNECTED;
  wire NLW_dcm_instance_PSCLK_UNCONNECTED;
  wire NLW_dcm_instance_CLK0_UNCONNECTED;
  wire NLW_dcm_instance_CLK90_UNCONNECTED;
  wire NLW_dcm_instance_CLK180_UNCONNECTED;
  wire NLW_dcm_instance_CLK270_UNCONNECTED;
  wire NLW_dcm_instance_CLK2X_UNCONNECTED;
  wire NLW_dcm_instance_CLK2X180_UNCONNECTED;
  wire NLW_dcm_instance_CLKDV_UNCONNECTED;
  wire NLW_dcm_instance_CLKFX_UNCONNECTED;
  wire NLW_dcm_instance_CLKFX180_UNCONNECTED;
  wire NLW_dcm_instance_LOCKED_UNCONNECTED;
  wire NLW_dcm_instance_PSDONE_UNCONNECTED;
  wire \NLW_dcm_instance_STATUS<7>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<6>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<5>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<4>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<3>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<2>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<1>_UNCONNECTED ;
  wire \NLW_dcm_instance_STATUS<0>_UNCONNECTED ;
  wire [3 : 0] \u4udc/counter ;
  VCC   XST_VCC (
    .P(N1)
  );
  FDC   \u3bpd/state_FSM_FFd2  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u3bpd/state_FSM_FFd2-In ),
    .Q(\u3bpd/state_FSM_FFd2_78 )
  );
  FDC   \u3bpd/state_FSM_FFd1  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u3bpd/state_FSM_FFd1-In_77 ),
    .Q(\u3bpd/state_FSM_FFd1_76 )
  );
  FDC   \u3bpd/state_FSM_FFd3  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u3bpd/state_FSM_FFd3-In ),
    .Q(\u3bpd/state_FSM_FFd3_80 )
  );
  FDC   \u2bpd/state_FSM_FFd2  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u2bpd/state_FSM_FFd2-In ),
    .Q(\u2bpd/state_FSM_FFd2_72 )
  );
  FDC   \u2bpd/state_FSM_FFd1  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u2bpd/state_FSM_FFd1-In_71 ),
    .Q(\u2bpd/state_FSM_FFd1_70 )
  );
  FDC   \u2bpd/state_FSM_FFd3  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CLR(resetButton_IBUF_19),
    .D(\u2bpd/state_FSM_FFd3-In ),
    .Q(\u2bpd/state_FSM_FFd3_74 )
  );
  FDCE   \u4udc/state_FSM_FFd2  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/Mcount_counter_xor<2>170 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/state_FSM_FFd2-In ),
    .Q(\u4udc/state_FSM_FFd2_95 )
  );
  FDCE   \u4udc/state_FSM_FFd1  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/Mcount_counter_xor<2>170 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/state_FSM_FFd1-In ),
    .Q(\u4udc/state_FSM_FFd1_93 )
  );
  FDCE   \u4udc/counter_0  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/counter_not0001_92 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/Mcount_counter1 ),
    .Q(\u4udc/counter [0])
  );
  FDCE   \u4udc/counter_1  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/counter_not0001_92 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/Mcount_counter4 ),
    .Q(\u4udc/counter [1])
  );
  FDCE   \u4udc/counter_2  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/counter_not0001_92 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/Mcount_counter7 ),
    .Q(\u4udc/counter [2])
  );
  FDCE   \u4udc/counter_3  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .CE(\u4udc/counter_not0001_92 ),
    .CLR(resetButton_IBUF_19),
    .D(\u4udc/Mcount_counter10 ),
    .Q(\u4udc/counter [3])
  );
  DCM_SP #(
    .CLKDV_DIVIDE ( 2.000000 ),
    .CLKFX_DIVIDE ( 1 ),
    .CLKFX_MULTIPLY ( 4 ),
    .CLKIN_DIVIDE_BY_2 ( "FALSE" ),
    .CLKIN_PERIOD ( 10.0000000000000000 ),
    .CLKOUT_PHASE_SHIFT ( "NONE" ),
    .CLK_FEEDBACK ( "1X" ),
    .DESKEW_ADJUST ( "SYSTEM_SYNCHRONOUS" ),
    .DFS_FREQUENCY_MODE ( "LOW" ),
    .DLL_FREQUENCY_MODE ( "LOW" ),
    .DSS_MODE ( "NONE" ),
    .DUTY_CYCLE_CORRECTION ( "TRUE" ),
    .PHASE_SHIFT ( 0 ),
    .STARTUP_WAIT ( "FALSE" ),
    .FACTORY_JF ( 16'hC080 ))
  dcm_instance (
    .CLKIN(NLW_dcm_instance_CLKIN_UNCONNECTED),
    .CLKFB(NLW_dcm_instance_CLKFB_UNCONNECTED),
    .RST(NLW_dcm_instance_RST_UNCONNECTED),
    .DSSEN(NLW_dcm_instance_DSSEN_UNCONNECTED),
    .PSINCDEC(NLW_dcm_instance_PSINCDEC_UNCONNECTED),
    .PSEN(NLW_dcm_instance_PSEN_UNCONNECTED),
    .PSCLK(NLW_dcm_instance_PSCLK_UNCONNECTED),
    .CLK0(NLW_dcm_instance_CLK0_UNCONNECTED),
    .CLK90(NLW_dcm_instance_CLK90_UNCONNECTED),
    .CLK180(NLW_dcm_instance_CLK180_UNCONNECTED),
    .CLK270(NLW_dcm_instance_CLK270_UNCONNECTED),
    .CLK2X(NLW_dcm_instance_CLK2X_UNCONNECTED),
    .CLK2X180(NLW_dcm_instance_CLK2X180_UNCONNECTED),
    .CLKDV(NLW_dcm_instance_CLKDV_UNCONNECTED),
    .CLKFX(NLW_dcm_instance_CLKFX_UNCONNECTED),
    .CLKFX180(NLW_dcm_instance_CLKFX180_UNCONNECTED),
    .LOCKED(NLW_dcm_instance_LOCKED_UNCONNECTED),
    .PSDONE(NLW_dcm_instance_PSDONE_UNCONNECTED),
    .STATUS({\NLW_dcm_instance_STATUS<7>_UNCONNECTED , \NLW_dcm_instance_STATUS<6>_UNCONNECTED , \NLW_dcm_instance_STATUS<5>_UNCONNECTED , 
\NLW_dcm_instance_STATUS<4>_UNCONNECTED , \NLW_dcm_instance_STATUS<3>_UNCONNECTED , \NLW_dcm_instance_STATUS<2>_UNCONNECTED , 
\NLW_dcm_instance_STATUS<1>_UNCONNECTED , \NLW_dcm_instance_STATUS<0>_UNCONNECTED })
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/u0tff/q  (
    .C(systemClock_BUFGP_29),
    .CE(N1),
    .D(\u1rs/u1rc/u0tff/nq ),
    .Q(\u1rs/u1rc/u0tff/q_69 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q  (
    .C(\u1rs/u1rc/u0tff/q_69 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_31 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_31 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_51 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_51 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_53 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_53 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_55 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_55 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_57 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_57 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_59 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_59 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_61 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_61 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_63 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_63 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_65 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_65 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_67 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_67 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_33 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_33 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_35 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_35 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_37 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_37 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_39 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_39 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_41 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_41 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_43 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_43 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_45 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_45 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_47 )
  );
  FDE_1 #(
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q  (
    .C(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_47 ),
    .CE(N1),
    .D(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/nq ),
    .Q(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 )
  );
  LUT3 #(
    .INIT ( 8'hB1 ))
  \u4udc/Mcount_counter_xor<0>11  (
    .I0(loadButton_IBUF_17),
    .I1(\u4udc/counter [0]),
    .I2(switches_0_IBUF_24),
    .O(\u4udc/Mcount_counter1 )
  );
  LUT4 #(
    .INIT ( 16'hD5F1 ))
  \u3bpd/state_FSM_FFd2-In1  (
    .I0(downButton_IBUF_15),
    .I1(\u3bpd/state_FSM_FFd1_76 ),
    .I2(\u3bpd/state_FSM_FFd3_80 ),
    .I3(\u3bpd/state_FSM_FFd2_78 ),
    .O(\u3bpd/state_FSM_FFd2-In )
  );
  LUT4 #(
    .INIT ( 16'hD5F1 ))
  \u2bpd/state_FSM_FFd2-In1  (
    .I0(upButton_IBUF_98),
    .I1(\u2bpd/state_FSM_FFd1_70 ),
    .I2(\u2bpd/state_FSM_FFd3_74 ),
    .I3(\u2bpd/state_FSM_FFd2_72 ),
    .O(\u2bpd/state_FSM_FFd2-In )
  );
  LUT4 #(
    .INIT ( 16'h7F71 ))
  \u3bpd/state_FSM_FFd3-In1  (
    .I0(\u3bpd/state_FSM_FFd1_76 ),
    .I1(downButton_IBUF_15),
    .I2(\u3bpd/state_FSM_FFd2_78 ),
    .I3(\u3bpd/state_FSM_FFd3_80 ),
    .O(\u3bpd/state_FSM_FFd3-In )
  );
  LUT4 #(
    .INIT ( 16'h7F71 ))
  \u2bpd/state_FSM_FFd3-In1  (
    .I0(upButton_IBUF_98),
    .I1(\u2bpd/state_FSM_FFd1_70 ),
    .I2(\u2bpd/state_FSM_FFd2_72 ),
    .I3(\u2bpd/state_FSM_FFd3_74 ),
    .O(\u2bpd/state_FSM_FFd3-In )
  );
  LUT4 #(
    .INIT ( 16'h0455 ))
  \u4udc/state_FSM_FFd2-In1  (
    .I0(\u4udc/state_FSM_FFd2_95 ),
    .I1(\u3bpd/state_FSM_FFd1_76 ),
    .I2(\u3bpd/state_FSM_FFd2_78 ),
    .I3(N01),
    .O(\u4udc/state_FSM_FFd2-In )
  );
  LUT4 #(
    .INIT ( 16'h0400 ))
  \u4udc/state_FSM_FFd1-In1  (
    .I0(\u4udc/state_FSM_FFd2_95 ),
    .I1(\u3bpd/state_FSM_FFd1_76 ),
    .I2(\u3bpd/state_FSM_FFd2_78 ),
    .I3(N31),
    .O(\u4udc/state_FSM_FFd1-In )
  );
  LUT4 #(
    .INIT ( 16'hDD48 ))
  \u2bpd/state_FSM_FFd1-In_SW0  (
    .I0(\u2bpd/state_FSM_FFd2_72 ),
    .I1(upButton_IBUF_98),
    .I2(\u2bpd/state_FSM_FFd3_74 ),
    .I3(\u2bpd/state_FSM_FFd1_70 ),
    .O(N15)
  );
  LUT4 #(
    .INIT ( 16'hFD20 ))
  \u2bpd/state_FSM_FFd1-In  (
    .I0(\u4udc/state_FSM_FFd2_95 ),
    .I1(\u4udc/state_FSM_FFd1_93 ),
    .I2(N16),
    .I3(N15),
    .O(\u2bpd/state_FSM_FFd1-In_71 )
  );
  LUT4 #(
    .INIT ( 16'hB88B ))
  \u4udc/Mcount_counter_xor<3>1  (
    .I0(switches_3_IBUF_27),
    .I1(loadButton_IBUF_17),
    .I2(\u4udc/counter [3]),
    .I3(N22),
    .O(\u4udc/Mcount_counter10 )
  );
  IBUF   downButton_IBUF (
    .I(downButton),
    .O(downButton_IBUF_15)
  );
  IBUF   loadButton_IBUF (
    .I(loadButton),
    .O(loadButton_IBUF_17)
  );
  IBUF   upButton_IBUF (
    .I(upButton),
    .O(upButton_IBUF_98)
  );
  IBUF   resetButton_IBUF (
    .I(resetButton),
    .O(resetButton_IBUF_19)
  );
  IBUF   switches_3_IBUF (
    .I(switches[3]),
    .O(switches_3_IBUF_27)
  );
  IBUF   switches_2_IBUF (
    .I(switches[2]),
    .O(switches_2_IBUF_26)
  );
  IBUF   switches_1_IBUF (
    .I(switches[1]),
    .O(switches_1_IBUF_25)
  );
  IBUF   switches_0_IBUF (
    .I(switches[0]),
    .O(switches_0_IBUF_24)
  );
  OBUF   counter_3_OBUF (
    .I(\u4udc/counter [3]),
    .O(counter[3])
  );
  OBUF   counter_2_OBUF (
    .I(\u4udc/counter [2]),
    .O(counter[2])
  );
  OBUF   counter_1_OBUF (
    .I(\u4udc/counter [1]),
    .O(counter[1])
  );
  OBUF   counter_0_OBUF (
    .I(\u4udc/counter [0]),
    .O(counter[0])
  );
  LUT4 #(
    .INIT ( 16'hEAC0 ))
  \u4udc/Mcount_counter_xor<2>187  (
    .I0(\u4udc/Mcount_counter_xor<2>170 ),
    .I1(switches_2_IBUF_26),
    .I2(loadButton_IBUF_17),
    .I3(\u4udc/Mcount_counter_xor<2>169_86 ),
    .O(\u4udc/Mcount_counter7 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \u4udc/counter_not0001  (
    .I0(loadButton_IBUF_17),
    .I1(\u4udc/state_FSM_FFd2_95 ),
    .I2(N24),
    .O(\u4udc/counter_not0001_92 )
  );
  LUT4 #(
    .INIT ( 16'hED21 ))
  \u4udc/Mcount_counter_xor<1>1  (
    .I0(\u4udc/counter [1]),
    .I1(loadButton_IBUF_17),
    .I2(N26),
    .I3(switches_1_IBUF_25),
    .O(\u4udc/Mcount_counter4 )
  );
  MUXF5   \u3bpd/state_FSM_FFd1-In  (
    .I0(N28),
    .I1(N29),
    .S(\u4udc/state_FSM_FFd1_93 ),
    .O(\u3bpd/state_FSM_FFd1-In_77 )
  );
  LUT4 #(
    .INIT ( 16'hDD48 ))
  \u3bpd/state_FSM_FFd1-In_F  (
    .I0(\u3bpd/state_FSM_FFd2_78 ),
    .I1(downButton_IBUF_15),
    .I2(\u3bpd/state_FSM_FFd3_80 ),
    .I3(\u3bpd/state_FSM_FFd1_76 ),
    .O(N28)
  );
  LUT4 #(
    .INIT ( 16'hC848 ))
  \u3bpd/state_FSM_FFd1-In_G  (
    .I0(\u3bpd/state_FSM_FFd2_78 ),
    .I1(downButton_IBUF_15),
    .I2(\u3bpd/state_FSM_FFd3_80 ),
    .I3(\u3bpd/state_FSM_FFd1_76 ),
    .O(N29)
  );
  BUFGP   systemClock_BUFGP (
    .I(systemClock),
    .O(systemClock_BUFGP_29)
  );
  INV   \u4udc/state_FSM_ClkEn_inv1_INV_0  (
    .I(loadButton_IBUF_17),
    .O(\u4udc/Mcount_counter_xor<2>170 )
  );
  INV   \u1rs/u1rc/u0tff/nq1_INV_0  (
    .I(\u1rs/u1rc/u0tff/q_69 ),
    .O(\u1rs/u1rc/u0tff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_67 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_65 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_63 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_61 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_59 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_57 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_55 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_53 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_51 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_49 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_47 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_45 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_43 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_41 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_39 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_37 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_35 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_33 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/nq )
  );
  INV   \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/nq1_INV_0  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_31 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/nq )
  );
  LUT4_L #(
    .INIT ( 16'hC848 ))
  \u2bpd/state_FSM_FFd1-In_SW1  (
    .I0(\u2bpd/state_FSM_FFd2_72 ),
    .I1(upButton_IBUF_98),
    .I2(\u2bpd/state_FSM_FFd3_74 ),
    .I3(\u2bpd/state_FSM_FFd1_70 ),
    .LO(N16)
  );
  LUT4_L #(
    .INIT ( 16'hA96A ))
  \u4udc/Mcount_counter_xor<2>169  (
    .I0(\u4udc/counter [2]),
    .I1(\u4udc/counter [1]),
    .I2(\u4udc/counter [0]),
    .I3(N01),
    .LO(\u4udc/Mcount_counter_xor<2>169_86 )
  );
  LUT2_D #(
    .INIT ( 4'hD ))
  \u4udc/Mcount_counter_xor<3>111  (
    .I0(\u2bpd/state_FSM_FFd1_70 ),
    .I1(\u2bpd/state_FSM_FFd2_72 ),
    .LO(N31),
    .O(N01)
  );
  LUT4_L #(
    .INIT ( 16'hFE7F ))
  \u4udc/Mcount_counter_xor<3>1_SW0  (
    .I0(\u4udc/counter [2]),
    .I1(\u4udc/counter [1]),
    .I2(\u4udc/counter [0]),
    .I3(N01),
    .LO(N22)
  );
  LUT4_L #(
    .INIT ( 16'h4F44 ))
  \u4udc/counter_not0001_SW1  (
    .I0(\u3bpd/state_FSM_FFd2_78 ),
    .I1(\u3bpd/state_FSM_FFd1_76 ),
    .I2(\u2bpd/state_FSM_FFd2_72 ),
    .I3(\u2bpd/state_FSM_FFd1_70 ),
    .LO(N24)
  );
  LUT3_L #(
    .INIT ( 8'h9C ))
  \u4udc/Mcount_counter_xor<1>1_SW1  (
    .I0(\u2bpd/state_FSM_FFd2_72 ),
    .I1(\u4udc/counter [0]),
    .I2(\u2bpd/state_FSM_FFd1_70 ),
    .LO(N26)
  );
endmodule


`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

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

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

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

endmodule

