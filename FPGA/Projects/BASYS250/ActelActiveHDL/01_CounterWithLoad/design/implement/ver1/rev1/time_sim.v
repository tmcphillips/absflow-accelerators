////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: time_sim.v
// /___/   /\     Timestamp: Wed Feb 29 17:34:46 2012
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog -pcf FourBitCounterWithLoad.pcf -s 5 -sdf_anno true -sdf_path C:\Users\tmcphillips\Designs\Projects\BASYS250\VerilogHDL\01_CounterWithLoad\design\implement -insert_glbl true FourBitCounterWithLoad.ncd time_sim.v 
// Device	: 3s250etq144-5 (PRODUCTION 1.27 2008-01-09)
// Input file	: FourBitCounterWithLoad.ncd
// Output file	: time_sim.v
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
  wire switches_0_IBUF_244;
  wire switches_1_IBUF_245;
  wire switches_2_IBUF_246;
  wire switches_3_IBUF_247;
  wire resetButton_IBUF_248;
  wire downButton_IBUF_249;
  wire loadButton_IBUF_250;
  wire upButton_IBUF_251;
  wire GLOBAL_LOGIC1;
  wire systemClock_BUFGP;
  wire \u4udc/state_FSM_FFd1_259 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ;
  wire \u3bpd/state_FSM_FFd2_261 ;
  wire \u3bpd/state_FSM_FFd3_262 ;
  wire \u3bpd/state_FSM_FFd1_263 ;
  wire \u4udc/state_FSM_FFd2_264 ;
  wire \u4udc/counter_not0001_SW1/O ;
  wire \u2bpd/state_FSM_FFd2_266 ;
  wire \u2bpd/state_FSM_FFd1_267 ;
  wire \u4udc/counter_not0001_0 ;
  wire \u4udc/Mcount_counter_xor<2>169/O ;
  wire N01;
  wire \u4udc/Mcount_counter_xor<1>1_SW1/O ;
  wire \u4udc/Mcount_counter_xor<3>1_SW0/O ;
  wire \u2bpd/state_FSM_FFd1-In_SW1/O ;
  wire N15_0;
  wire \u2bpd/state_FSM_FFd3_275 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_276 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_277 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_278 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_279 ;
  wire \u1rs/u1rc/u0tff/q_280 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_281 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_282 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_283 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_284 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_285 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_286 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_287 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_288 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_289 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_290 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_291 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_292 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_293 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_294 ;
  wire \switches<0>/INBUF ;
  wire \switches<1>/INBUF ;
  wire \switches<2>/INBUF ;
  wire \switches<3>/INBUF ;
  wire \resetButton/INBUF ;
  wire \downButton/INBUF ;
  wire \loadButton/INBUF ;
  wire \upButton/INBUF ;
  wire \counter<0>/O ;
  wire \counter<1>/O ;
  wire \systemClock/INBUF ;
  wire \counter<2>/O ;
  wire \counter<3>/O ;
  wire \systemClock_BUFGP/BUFG/S_INVNOT ;
  wire \systemClock_BUFGP/BUFG/I0_INV ;
  wire \u3bpd/state_FSM_FFd1/DXMUX_415 ;
  wire \u3bpd/state_FSM_FFd1/F5MUX_413 ;
  wire N29;
  wire \u3bpd/state_FSM_FFd1/BXINV_406 ;
  wire N28;
  wire \u3bpd/state_FSM_FFd1/CLKINV_398 ;
  wire \u4udc/counter_not0001_443 ;
  wire \u4udc/counter_not0001_SW1/O_pack_1 ;
  wire \u4udc/counter<2>/DXMUX_476 ;
  wire \u4udc/Mcount_counter7 ;
  wire \u4udc/Mcount_counter_xor<2>169/O_pack_1 ;
  wire \u4udc/counter<2>/CLKINV_459 ;
  wire \u4udc/counter<2>/CEINV_458 ;
  wire \u4udc/state_FSM_FFd1/DXMUX_514 ;
  wire \u4udc/state_FSM_FFd1-In ;
  wire N01_pack_1;
  wire \u4udc/state_FSM_FFd1/CLKINV_496 ;
  wire \u4udc/state_FSM_FFd1/CEINVNOT ;
  wire \u4udc/counter<1>/DXMUX_552 ;
  wire \u4udc/Mcount_counter4 ;
  wire \u4udc/Mcount_counter_xor<1>1_SW1/O_pack_1 ;
  wire \u4udc/counter<1>/CLKINV_535 ;
  wire \u4udc/counter<1>/CEINV_534 ;
  wire \u4udc/counter<3>/DXMUX_590 ;
  wire \u4udc/Mcount_counter10 ;
  wire \u4udc/Mcount_counter_xor<3>1_SW0/O_pack_1 ;
  wire \u4udc/counter<3>/CLKINV_574 ;
  wire \u4udc/counter<3>/CEINV_573 ;
  wire \u2bpd/state_FSM_FFd1/DXMUX_626 ;
  wire \u2bpd/state_FSM_FFd1-In_623 ;
  wire \u2bpd/state_FSM_FFd1-In_SW1/O_pack_1 ;
  wire \u2bpd/state_FSM_FFd1/CLKINV_610 ;
  wire N15;
  wire \u2bpd/state_FSM_FFd2/DYMUX_654 ;
  wire \u2bpd/state_FSM_FFd2-In ;
  wire \u2bpd/state_FSM_FFd2/CLKINV_645 ;
  wire \u2bpd/state_FSM_FFd3/DYMUX_684 ;
  wire \u2bpd/state_FSM_FFd3-In ;
  wire \u2bpd/state_FSM_FFd3/CLKINV_675 ;
  wire \u4udc/state_FSM_FFd2/DYMUX_709 ;
  wire \u4udc/state_FSM_FFd2-In ;
  wire \u4udc/state_FSM_FFd2/CLKINV_700 ;
  wire \u4udc/state_FSM_FFd2/CEINVNOT ;
  wire \u4udc/counter<0>/DYMUX_735 ;
  wire \u4udc/Mcount_counter1 ;
  wire \u4udc/counter<0>/CLKINV_725 ;
  wire \u4udc/counter<0>/CEINV_724 ;
  wire \u3bpd/state_FSM_FFd3/DXMUX_778 ;
  wire \u3bpd/state_FSM_FFd3-In ;
  wire \u3bpd/state_FSM_FFd3/DYMUX_764 ;
  wire \u3bpd/state_FSM_FFd2-In ;
  wire \u3bpd/state_FSM_FFd3/SRINV_756 ;
  wire \u3bpd/state_FSM_FFd3/CLKINV_755 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/DYMUX_790 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/DYMUX_799 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/DYMUX_808 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/u0tff/q/DYMUX_817 ;
  wire \u1rs/u1rc/u0tff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/DYMUX_826 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/DYMUX_835 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/DYMUX_844 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/DYMUX_853 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/DYMUX_862 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/DYMUX_871 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/DYMUX_880 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/DYMUX_889 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/DYMUX_898 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/DYMUX_907 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/DYMUX_916 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/DYMUX_925 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/DYMUX_934 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/DYMUX_943 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/DYMUX_952 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/CLKINVNOT ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/DYMUX_961 ;
  wire \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/CLKINVNOT ;
  wire \u3bpd/state_FSM_FFd1/FFX/RSTAND_420 ;
  wire \u4udc/counter<3>/FFX/RSTAND_596 ;
  wire \u2bpd/state_FSM_FFd1/FFX/RSTAND_631 ;
  wire \u2bpd/state_FSM_FFd2/FFY/RSTAND_659 ;
  wire \u2bpd/state_FSM_FFd3/FFY/RSTAND_689 ;
  wire \u4udc/state_FSM_FFd2/FFY/RSTAND_715 ;
  wire \u4udc/counter<2>/FFX/RSTAND_482 ;
  wire \u4udc/state_FSM_FFd1/FFX/RSTAND_520 ;
  wire \u4udc/counter<1>/FFX/RSTAND_558 ;
  wire \u4udc/counter<0>/FFY/RSTAND_741 ;
  wire GND;
  wire VCC;
  wire [3 : 0] \u4udc/counter ;
  initial $sdf_annotate("c:/users/tmcphillips/designs/projects/basys250/veriloghdl/01_counterwithload/design/implement/time_sim.sdf");
  X_IPAD #(
    .LOC ( "IPAD130" ))
  \switches<0>/PAD  (
    .PAD(switches[0])
  );
  X_BUF #(
    .LOC ( "IPAD130" ))
  switches_0_IBUF (
    .I(switches[0]),
    .O(\switches<0>/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD130" ))
  \switches<0>/IFF/IMUX  (
    .I(\switches<0>/INBUF ),
    .O(switches_0_IBUF_244)
  );
  X_IPAD #(
    .LOC ( "IPAD131" ))
  \switches<1>/PAD  (
    .PAD(switches[1])
  );
  X_BUF #(
    .LOC ( "IPAD131" ))
  switches_1_IBUF (
    .I(switches[1]),
    .O(\switches<1>/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD131" ))
  \switches<1>/IFF/IMUX  (
    .I(\switches<1>/INBUF ),
    .O(switches_1_IBUF_245)
  );
  X_IPAD #(
    .LOC ( "IPAD137" ))
  \switches<2>/PAD  (
    .PAD(switches[2])
  );
  X_BUF #(
    .LOC ( "IPAD137" ))
  switches_2_IBUF (
    .I(switches[2]),
    .O(\switches<2>/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD137" ))
  \switches<2>/IFF/IMUX  (
    .I(\switches<2>/INBUF ),
    .O(switches_2_IBUF_246)
  );
  X_IPAD #(
    .LOC ( "IPAD147" ))
  \switches<3>/PAD  (
    .PAD(switches[3])
  );
  X_BUF #(
    .LOC ( "IPAD147" ))
  switches_3_IBUF (
    .I(switches[3]),
    .O(\switches<3>/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD147" ))
  \switches<3>/IFF/IMUX  (
    .I(\switches<3>/INBUF ),
    .O(switches_3_IBUF_247)
  );
  X_IPAD #(
    .LOC ( "IPAD89" ))
  \resetButton/PAD  (
    .PAD(resetButton)
  );
  X_BUF #(
    .LOC ( "IPAD89" ))
  resetButton_IBUF (
    .I(resetButton),
    .O(\resetButton/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD89" ))
  \resetButton/IFF/IMUX  (
    .I(\resetButton/INBUF ),
    .O(resetButton_IBUF_248)
  );
  X_IPAD #(
    .LOC ( "IPAD115" ))
  \downButton/PAD  (
    .PAD(downButton)
  );
  X_BUF #(
    .LOC ( "IPAD115" ))
  downButton_IBUF (
    .I(downButton),
    .O(\downButton/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD115" ))
  \downButton/IFF/IMUX  (
    .I(\downButton/INBUF ),
    .O(downButton_IBUF_249)
  );
  X_IPAD #(
    .LOC ( "IPAD114" ))
  \loadButton/PAD  (
    .PAD(loadButton)
  );
  X_BUF #(
    .LOC ( "IPAD114" ))
  loadButton_IBUF (
    .I(loadButton),
    .O(\loadButton/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD114" ))
  \loadButton/IFF/IMUX  (
    .I(\loadButton/INBUF ),
    .O(loadButton_IBUF_250)
  );
  X_IPAD #(
    .LOC ( "IPAD126" ))
  \upButton/PAD  (
    .PAD(upButton)
  );
  X_BUF #(
    .LOC ( "IPAD126" ))
  upButton_IBUF (
    .I(upButton),
    .O(\upButton/INBUF )
  );
  X_BUF #(
    .LOC ( "IPAD126" ))
  \upButton/IFF/IMUX  (
    .I(\upButton/INBUF ),
    .O(upButton_IBUF_251)
  );
  X_OPAD #(
    .LOC ( "PAD155" ))
  \counter<0>/PAD  (
    .PAD(counter[0])
  );
  X_OBUF #(
    .LOC ( "PAD155" ))
  counter_0_OBUF (
    .I(\counter<0>/O ),
    .O(counter[0])
  );
  X_OPAD #(
    .LOC ( "PAD156" ))
  \counter<1>/PAD  (
    .PAD(counter[1])
  );
  X_OBUF #(
    .LOC ( "PAD156" ))
  counter_1_OBUF (
    .I(\counter<1>/O ),
    .O(counter[1])
  );
  X_IPAD #(
    .LOC ( "PAD109" ))
  \systemClock/PAD  (
    .PAD(systemClock)
  );
  X_BUF #(
    .LOC ( "PAD109" ))
  \systemClock_BUFGP/IBUFG  (
    .I(systemClock),
    .O(\systemClock/INBUF )
  );
  X_OPAD #(
    .LOC ( "PAD165" ))
  \counter<2>/PAD  (
    .PAD(counter[2])
  );
  X_OBUF #(
    .LOC ( "PAD165" ))
  counter_2_OBUF (
    .I(\counter<2>/O ),
    .O(counter[2])
  );
  X_OPAD #(
    .LOC ( "PAD166" ))
  \counter<3>/PAD  (
    .PAD(counter[3])
  );
  X_OBUF #(
    .LOC ( "PAD166" ))
  counter_3_OBUF (
    .I(\counter<3>/O ),
    .O(counter[3])
  );
  X_BUFGMUX #(
    .LOC ( "BUFGMUX_X1Y0" ))
  \systemClock_BUFGP/BUFG  (
    .I0(\systemClock_BUFGP/BUFG/I0_INV ),
    .I1(GND),
    .S(\systemClock_BUFGP/BUFG/S_INVNOT ),
    .O(systemClock_BUFGP)
  );
  X_INV #(
    .LOC ( "BUFGMUX_X1Y0" ))
  \systemClock_BUFGP/BUFG/SINV  (
    .I(GLOBAL_LOGIC1),
    .O(\systemClock_BUFGP/BUFG/S_INVNOT )
  );
  X_BUF #(
    .LOC ( "BUFGMUX_X1Y0" ))
  \systemClock_BUFGP/BUFG/I0_USED  (
    .I(\systemClock/INBUF ),
    .O(\systemClock_BUFGP/BUFG/I0_INV )
  );
  X_LUT4 #(
    .INIT ( 16'hC488 ),
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1-In_G  (
    .ADR0(\u3bpd/state_FSM_FFd2_261 ),
    .ADR1(downButton_IBUF_249),
    .ADR2(\u3bpd/state_FSM_FFd1_263 ),
    .ADR3(\u3bpd/state_FSM_FFd3_262 ),
    .O(N29)
  );
  X_LUT4 #(
    .INIT ( 16'hD4D8 ),
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1-In_F  (
    .ADR0(\u3bpd/state_FSM_FFd2_261 ),
    .ADR1(downButton_IBUF_249),
    .ADR2(\u3bpd/state_FSM_FFd1_263 ),
    .ADR3(\u3bpd/state_FSM_FFd3_262 ),
    .O(N28)
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1/DXMUX  (
    .I(\u3bpd/state_FSM_FFd1/F5MUX_413 ),
    .O(\u3bpd/state_FSM_FFd1/DXMUX_415 )
  );
  X_MUX2 #(
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1/F5MUX  (
    .IA(N28),
    .IB(N29),
    .SEL(\u3bpd/state_FSM_FFd1/BXINV_406 ),
    .O(\u3bpd/state_FSM_FFd1/F5MUX_413 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1/BXINV  (
    .I(\u4udc/state_FSM_FFd1_259 ),
    .O(\u3bpd/state_FSM_FFd1/BXINV_406 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u3bpd/state_FSM_FFd1/CLKINV_398 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y3" ))
  \u4udc/counter_not0001/XUSED  (
    .I(\u4udc/counter_not0001_443 ),
    .O(\u4udc/counter_not0001_0 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y3" ))
  \u4udc/counter_not0001/YUSED  (
    .I(\u4udc/counter_not0001_SW1/O_pack_1 ),
    .O(\u4udc/counter_not0001_SW1/O )
  );
  X_LUT4 #(
    .INIT ( 16'h50DC ),
    .LOC ( "SLICE_X13Y3" ))
  \u4udc/counter_not0001_SW1  (
    .ADR0(\u2bpd/state_FSM_FFd2_266 ),
    .ADR1(\u3bpd/state_FSM_FFd1_263 ),
    .ADR2(\u2bpd/state_FSM_FFd1_267 ),
    .ADR3(\u3bpd/state_FSM_FFd2_261 ),
    .O(\u4udc/counter_not0001_SW1/O_pack_1 )
  );
  X_LUT4 #(
    .INIT ( 16'hC96C ),
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/Mcount_counter_xor<2>169  (
    .ADR0(\u4udc/counter [0]),
    .ADR1(\u4udc/counter [2]),
    .ADR2(\u4udc/counter [1]),
    .ADR3(N01),
    .O(\u4udc/Mcount_counter_xor<2>169/O_pack_1 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/counter<2>/DXMUX  (
    .I(\u4udc/Mcount_counter7 ),
    .O(\u4udc/counter<2>/DXMUX_476 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/counter<2>/YUSED  (
    .I(\u4udc/Mcount_counter_xor<2>169/O_pack_1 ),
    .O(\u4udc/Mcount_counter_xor<2>169/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/counter<2>/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/counter<2>/CLKINV_459 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/counter<2>/CEINV  (
    .I(\u4udc/counter_not0001_0 ),
    .O(\u4udc/counter<2>/CEINV_458 )
  );
  X_LUT4 #(
    .INIT ( 16'hBBBB ),
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/Mcount_counter_xor<3>111  (
    .ADR0(\u2bpd/state_FSM_FFd2_266 ),
    .ADR1(\u2bpd/state_FSM_FFd1_267 ),
    .ADR2(VCC),
    .ADR3(VCC),
    .O(N01_pack_1)
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1/DXMUX  (
    .I(\u4udc/state_FSM_FFd1-In ),
    .O(\u4udc/state_FSM_FFd1/DXMUX_514 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1/YUSED  (
    .I(N01_pack_1),
    .O(N01)
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/state_FSM_FFd1/CLKINV_496 )
  );
  X_INV #(
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1/CEINV  (
    .I(loadButton_IBUF_250),
    .O(\u4udc/state_FSM_FFd1/CEINVNOT )
  );
  X_LUT4 #(
    .INIT ( 16'h99CC ),
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/Mcount_counter_xor<1>1_SW1  (
    .ADR0(\u2bpd/state_FSM_FFd2_266 ),
    .ADR1(\u4udc/counter [0]),
    .ADR2(VCC),
    .ADR3(\u2bpd/state_FSM_FFd1_267 ),
    .O(\u4udc/Mcount_counter_xor<1>1_SW1/O_pack_1 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/counter<1>/DXMUX  (
    .I(\u4udc/Mcount_counter4 ),
    .O(\u4udc/counter<1>/DXMUX_552 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/counter<1>/YUSED  (
    .I(\u4udc/Mcount_counter_xor<1>1_SW1/O_pack_1 ),
    .O(\u4udc/Mcount_counter_xor<1>1_SW1/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/counter<1>/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/counter<1>/CLKINV_535 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/counter<1>/CEINV  (
    .I(\u4udc/counter_not0001_0 ),
    .O(\u4udc/counter<1>/CEINV_534 )
  );
  X_LUT4 #(
    .INIT ( 16'hFE7F ),
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/Mcount_counter_xor<3>1_SW0  (
    .ADR0(\u4udc/counter [0]),
    .ADR1(\u4udc/counter [2]),
    .ADR2(\u4udc/counter [1]),
    .ADR3(N01),
    .O(\u4udc/Mcount_counter_xor<3>1_SW0/O_pack_1 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/counter<3>/DXMUX  (
    .I(\u4udc/Mcount_counter10 ),
    .O(\u4udc/counter<3>/DXMUX_590 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/counter<3>/YUSED  (
    .I(\u4udc/Mcount_counter_xor<3>1_SW0/O_pack_1 ),
    .O(\u4udc/Mcount_counter_xor<3>1_SW0/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/counter<3>/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/counter<3>/CLKINV_574 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/counter<3>/CEINV  (
    .I(\u4udc/counter_not0001_0 ),
    .O(\u4udc/counter<3>/CEINV_573 )
  );
  X_LUT4 #(
    .INIT ( 16'hC488 ),
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1-In_SW1  (
    .ADR0(\u2bpd/state_FSM_FFd2_266 ),
    .ADR1(upButton_IBUF_251),
    .ADR2(\u2bpd/state_FSM_FFd1_267 ),
    .ADR3(\u2bpd/state_FSM_FFd3_275 ),
    .O(\u2bpd/state_FSM_FFd1-In_SW1/O_pack_1 )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1/DXMUX  (
    .I(\u2bpd/state_FSM_FFd1-In_623 ),
    .O(\u2bpd/state_FSM_FFd1/DXMUX_626 )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1/YUSED  (
    .I(\u2bpd/state_FSM_FFd1-In_SW1/O_pack_1 ),
    .O(\u2bpd/state_FSM_FFd1-In_SW1/O )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u2bpd/state_FSM_FFd1/CLKINV_610 )
  );
  X_LUT4 #(
    .INIT ( 16'h8FAB ),
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd2-In1  (
    .ADR0(\u2bpd/state_FSM_FFd3_275 ),
    .ADR1(\u2bpd/state_FSM_FFd1_267 ),
    .ADR2(upButton_IBUF_251),
    .ADR3(\u2bpd/state_FSM_FFd2_266 ),
    .O(\u2bpd/state_FSM_FFd2-In )
  );
  X_BUF #(
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd2/XUSED  (
    .I(N15),
    .O(N15_0)
  );
  X_BUF #(
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd2/DYMUX  (
    .I(\u2bpd/state_FSM_FFd2-In ),
    .O(\u2bpd/state_FSM_FFd2/DYMUX_654 )
  );
  X_BUF #(
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd2/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u2bpd/state_FSM_FFd2/CLKINV_645 )
  );
  X_LUT4 #(
    .INIT ( 16'h7F2B ),
    .LOC ( "SLICE_X15Y2" ))
  \u2bpd/state_FSM_FFd3-In1  (
    .ADR0(\u2bpd/state_FSM_FFd2_266 ),
    .ADR1(upButton_IBUF_251),
    .ADR2(\u2bpd/state_FSM_FFd1_267 ),
    .ADR3(\u2bpd/state_FSM_FFd3_275 ),
    .O(\u2bpd/state_FSM_FFd3-In )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y2" ))
  \u2bpd/state_FSM_FFd3/DYMUX  (
    .I(\u2bpd/state_FSM_FFd3-In ),
    .O(\u2bpd/state_FSM_FFd3/DYMUX_684 )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y2" ))
  \u2bpd/state_FSM_FFd3/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u2bpd/state_FSM_FFd3/CLKINV_675 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y2" ))
  \u4udc/state_FSM_FFd2/DYMUX  (
    .I(\u4udc/state_FSM_FFd2-In ),
    .O(\u4udc/state_FSM_FFd2/DYMUX_709 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y2" ))
  \u4udc/state_FSM_FFd2/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/state_FSM_FFd2/CLKINV_700 )
  );
  X_INV #(
    .LOC ( "SLICE_X13Y2" ))
  \u4udc/state_FSM_FFd2/CEINV  (
    .I(loadButton_IBUF_250),
    .O(\u4udc/state_FSM_FFd2/CEINVNOT )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y4" ))
  \u4udc/counter<0>/DYMUX  (
    .I(\u4udc/Mcount_counter1 ),
    .O(\u4udc/counter<0>/DYMUX_735 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y4" ))
  \u4udc/counter<0>/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u4udc/counter<0>/CLKINV_725 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y4" ))
  \u4udc/counter<0>/CEINV  (
    .I(\u4udc/counter_not0001_0 ),
    .O(\u4udc/counter<0>/CEINV_724 )
  );
  X_LUT4 #(
    .INIT ( 16'h8FAB ),
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd2-In1  (
    .ADR0(\u3bpd/state_FSM_FFd3_262 ),
    .ADR1(\u3bpd/state_FSM_FFd1_263 ),
    .ADR2(downButton_IBUF_249),
    .ADR3(\u3bpd/state_FSM_FFd2_261 ),
    .O(\u3bpd/state_FSM_FFd2-In )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd3/DXMUX  (
    .I(\u3bpd/state_FSM_FFd3-In ),
    .O(\u3bpd/state_FSM_FFd3/DXMUX_778 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd3/DYMUX  (
    .I(\u3bpd/state_FSM_FFd2-In ),
    .O(\u3bpd/state_FSM_FFd3/DYMUX_764 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd3/SRINV  (
    .I(resetButton_IBUF_248),
    .O(\u3bpd/state_FSM_FFd3/SRINV_756 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd3/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u3bpd/state_FSM_FFd3/CLKINV_755 )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_276 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/DYMUX_790 )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_277 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_278 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/DYMUX_799 )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_276 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_279 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/DYMUX_808 )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_278 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X12Y0" ))
  \u1rs/u1rc/u0tff/q/DYMUX  (
    .I(\u1rs/u1rc/u0tff/q_280 ),
    .O(\u1rs/u1rc/u0tff/q/DYMUX_817 )
  );
  X_INV #(
    .LOC ( "SLICE_X12Y0" ))
  \u1rs/u1rc/u0tff/q/CLKINV  (
    .I(systemClock_BUFGP),
    .O(\u1rs/u1rc/u0tff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_281 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/DYMUX_826 )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_279 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_282 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/DYMUX_835 )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/u0tff/q_280 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_283 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/DYMUX_844 )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_281 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_284 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/DYMUX_853 )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_282 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_285 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/DYMUX_862 )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y5" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_283 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_286 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/DYMUX_871 )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_284 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_287 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/DYMUX_880 )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_285 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_288 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/DYMUX_889 )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_286 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y6" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_289 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/DYMUX_898 )
  );
  X_INV #(
    .LOC ( "SLICE_X14Y6" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_287 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_290 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/DYMUX_907 )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_288 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y6" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/DYMUX_916 )
  );
  X_INV #(
    .LOC ( "SLICE_X15Y6" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_289 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_291 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/DYMUX_925 )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y1" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_290 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_292 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/DYMUX_934 )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_291 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_293 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/DYMUX_943 )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y0" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_292 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y3" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_294 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/DYMUX_952 )
  );
  X_INV #(
    .LOC ( "SLICE_X16Y3" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_293 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/CLKINVNOT )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/DYMUX  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_277 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/DYMUX_961 )
  );
  X_INV #(
    .LOC ( "SLICE_X17Y4" ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/CLKINV  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_294 ),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/CLKINVNOT )
  );
  X_FF #(
    .LOC ( "SLICE_X13Y5" ),
    .INIT ( 1'b0 ))
  \u3bpd/state_FSM_FFd1  (
    .I(\u3bpd/state_FSM_FFd1/DXMUX_415 ),
    .CE(VCC),
    .CLK(\u3bpd/state_FSM_FFd1/CLKINV_398 ),
    .SET(GND),
    .RST(\u3bpd/state_FSM_FFd1/FFX/RSTAND_420 ),
    .O(\u3bpd/state_FSM_FFd1_263 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y5" ))
  \u3bpd/state_FSM_FFd1/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u3bpd/state_FSM_FFd1/FFX/RSTAND_420 )
  );
  X_LUT4 #(
    .INIT ( 16'hD88D ),
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/Mcount_counter_xor<3>1  (
    .ADR0(loadButton_IBUF_250),
    .ADR1(switches_3_IBUF_247),
    .ADR2(\u4udc/Mcount_counter_xor<3>1_SW0/O ),
    .ADR3(\u4udc/counter [3]),
    .O(\u4udc/Mcount_counter10 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y7" ),
    .INIT ( 1'b0 ))
  \u4udc/counter_3  (
    .I(\u4udc/counter<3>/DXMUX_590 ),
    .CE(\u4udc/counter<3>/CEINV_573 ),
    .CLK(\u4udc/counter<3>/CLKINV_574 ),
    .SET(GND),
    .RST(\u4udc/counter<3>/FFX/RSTAND_596 ),
    .O(\u4udc/counter [3])
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y7" ))
  \u4udc/counter<3>/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/counter<3>/FFX/RSTAND_596 )
  );
  X_LUT4 #(
    .INIT ( 16'hBA8A ),
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1-In  (
    .ADR0(N15_0),
    .ADR1(\u4udc/state_FSM_FFd1_259 ),
    .ADR2(\u4udc/state_FSM_FFd2_264 ),
    .ADR3(\u2bpd/state_FSM_FFd1-In_SW1/O ),
    .O(\u2bpd/state_FSM_FFd1-In_623 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y3" ),
    .INIT ( 1'b0 ))
  \u2bpd/state_FSM_FFd1  (
    .I(\u2bpd/state_FSM_FFd1/DXMUX_626 ),
    .CE(VCC),
    .CLK(\u2bpd/state_FSM_FFd1/CLKINV_610 ),
    .SET(GND),
    .RST(\u2bpd/state_FSM_FFd1/FFX/RSTAND_631 ),
    .O(\u2bpd/state_FSM_FFd1_267 )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y3" ))
  \u2bpd/state_FSM_FFd1/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u2bpd/state_FSM_FFd1/FFX/RSTAND_631 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y3" ),
    .INIT ( 1'b0 ))
  \u2bpd/state_FSM_FFd2  (
    .I(\u2bpd/state_FSM_FFd2/DYMUX_654 ),
    .CE(VCC),
    .CLK(\u2bpd/state_FSM_FFd2/CLKINV_645 ),
    .SET(GND),
    .RST(\u2bpd/state_FSM_FFd2/FFY/RSTAND_659 ),
    .O(\u2bpd/state_FSM_FFd2_266 )
  );
  X_BUF #(
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd2/FFY/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u2bpd/state_FSM_FFd2/FFY/RSTAND_659 )
  );
  X_LUT4 #(
    .INIT ( 16'hD0EC ),
    .LOC ( "SLICE_X14Y3" ))
  \u2bpd/state_FSM_FFd1-In_SW0  (
    .ADR0(\u2bpd/state_FSM_FFd3_275 ),
    .ADR1(\u2bpd/state_FSM_FFd1_267 ),
    .ADR2(upButton_IBUF_251),
    .ADR3(\u2bpd/state_FSM_FFd2_266 ),
    .O(N15)
  );
  X_FF #(
    .LOC ( "SLICE_X15Y2" ),
    .INIT ( 1'b0 ))
  \u2bpd/state_FSM_FFd3  (
    .I(\u2bpd/state_FSM_FFd3/DYMUX_684 ),
    .CE(VCC),
    .CLK(\u2bpd/state_FSM_FFd3/CLKINV_675 ),
    .SET(GND),
    .RST(\u2bpd/state_FSM_FFd3/FFY/RSTAND_689 ),
    .O(\u2bpd/state_FSM_FFd3_275 )
  );
  X_BUF #(
    .LOC ( "SLICE_X15Y2" ))
  \u2bpd/state_FSM_FFd3/FFY/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u2bpd/state_FSM_FFd3/FFY/RSTAND_689 )
  );
  X_LUT4 #(
    .INIT ( 16'h005D ),
    .LOC ( "SLICE_X13Y2" ))
  \u4udc/state_FSM_FFd2-In1  (
    .ADR0(N01),
    .ADR1(\u3bpd/state_FSM_FFd1_263 ),
    .ADR2(\u3bpd/state_FSM_FFd2_261 ),
    .ADR3(\u4udc/state_FSM_FFd2_264 ),
    .O(\u4udc/state_FSM_FFd2-In )
  );
  X_FF #(
    .LOC ( "SLICE_X13Y2" ),
    .INIT ( 1'b0 ))
  \u4udc/state_FSM_FFd2  (
    .I(\u4udc/state_FSM_FFd2/DYMUX_709 ),
    .CE(\u4udc/state_FSM_FFd2/CEINVNOT ),
    .CLK(\u4udc/state_FSM_FFd2/CLKINV_700 ),
    .SET(GND),
    .RST(\u4udc/state_FSM_FFd2/FFY/RSTAND_715 ),
    .O(\u4udc/state_FSM_FFd2_264 )
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y2" ))
  \u4udc/state_FSM_FFd2/FFY/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/state_FSM_FFd2/FFY/RSTAND_715 )
  );
  X_LUT4 #(
    .INIT ( 16'hBBAA ),
    .LOC ( "SLICE_X13Y3" ))
  \u4udc/counter_not0001  (
    .ADR0(loadButton_IBUF_250),
    .ADR1(\u4udc/state_FSM_FFd2_264 ),
    .ADR2(VCC),
    .ADR3(\u4udc/counter_not0001_SW1/O ),
    .O(\u4udc/counter_not0001_443 )
  );
  X_LUT4 #(
    .INIT ( 16'hCFC0 ),
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/Mcount_counter_xor<2>187  (
    .ADR0(VCC),
    .ADR1(switches_2_IBUF_246),
    .ADR2(loadButton_IBUF_250),
    .ADR3(\u4udc/Mcount_counter_xor<2>169/O ),
    .O(\u4udc/Mcount_counter7 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y6" ),
    .INIT ( 1'b0 ))
  \u4udc/counter_2  (
    .I(\u4udc/counter<2>/DXMUX_476 ),
    .CE(\u4udc/counter<2>/CEINV_458 ),
    .CLK(\u4udc/counter<2>/CLKINV_459 ),
    .SET(GND),
    .RST(\u4udc/counter<2>/FFX/RSTAND_482 ),
    .O(\u4udc/counter [2])
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y6" ))
  \u4udc/counter<2>/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/counter<2>/FFX/RSTAND_482 )
  );
  X_LUT4 #(
    .INIT ( 16'h1000 ),
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1-In1  (
    .ADR0(\u4udc/state_FSM_FFd2_264 ),
    .ADR1(\u3bpd/state_FSM_FFd2_261 ),
    .ADR2(\u3bpd/state_FSM_FFd1_263 ),
    .ADR3(N01),
    .O(\u4udc/state_FSM_FFd1-In )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y2" ),
    .INIT ( 1'b0 ))
  \u4udc/state_FSM_FFd1  (
    .I(\u4udc/state_FSM_FFd1/DXMUX_514 ),
    .CE(\u4udc/state_FSM_FFd1/CEINVNOT ),
    .CLK(\u4udc/state_FSM_FFd1/CLKINV_496 ),
    .SET(GND),
    .RST(\u4udc/state_FSM_FFd1/FFX/RSTAND_520 ),
    .O(\u4udc/state_FSM_FFd1_259 )
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y2" ))
  \u4udc/state_FSM_FFd1/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/state_FSM_FFd1/FFX/RSTAND_520 )
  );
  X_LUT4 #(
    .INIT ( 16'hB88B ),
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/Mcount_counter_xor<1>1  (
    .ADR0(switches_1_IBUF_245),
    .ADR1(loadButton_IBUF_250),
    .ADR2(\u4udc/Mcount_counter_xor<1>1_SW1/O ),
    .ADR3(\u4udc/counter [1]),
    .O(\u4udc/Mcount_counter4 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y3" ),
    .INIT ( 1'b0 ))
  \u4udc/counter_1  (
    .I(\u4udc/counter<1>/DXMUX_552 ),
    .CE(\u4udc/counter<1>/CEINV_534 ),
    .CLK(\u4udc/counter<1>/CLKINV_535 ),
    .SET(GND),
    .RST(\u4udc/counter<1>/FFX/RSTAND_558 ),
    .O(\u4udc/counter [1])
  );
  X_BUF #(
    .LOC ( "SLICE_X12Y3" ))
  \u4udc/counter<1>/FFX/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/counter<1>/FFX/RSTAND_558 )
  );
  X_LUT4 #(
    .INIT ( 16'hAA33 ),
    .LOC ( "SLICE_X13Y4" ))
  \u4udc/Mcount_counter_xor<0>11  (
    .ADR0(switches_0_IBUF_244),
    .ADR1(\u4udc/counter [0]),
    .ADR2(VCC),
    .ADR3(loadButton_IBUF_250),
    .O(\u4udc/Mcount_counter1 )
  );
  X_FF #(
    .LOC ( "SLICE_X13Y4" ),
    .INIT ( 1'b0 ))
  \u4udc/counter_0  (
    .I(\u4udc/counter<0>/DYMUX_735 ),
    .CE(\u4udc/counter<0>/CEINV_724 ),
    .CLK(\u4udc/counter<0>/CLKINV_725 ),
    .SET(GND),
    .RST(\u4udc/counter<0>/FFY/RSTAND_741 ),
    .O(\u4udc/counter [0])
  );
  X_BUF #(
    .LOC ( "SLICE_X13Y4" ))
  \u4udc/counter<0>/FFY/RSTAND  (
    .I(resetButton_IBUF_248),
    .O(\u4udc/counter<0>/FFY/RSTAND_741 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y5" ),
    .INIT ( 1'b0 ))
  \u3bpd/state_FSM_FFd2  (
    .I(\u3bpd/state_FSM_FFd3/DYMUX_764 ),
    .CE(VCC),
    .CLK(\u3bpd/state_FSM_FFd3/CLKINV_755 ),
    .SET(GND),
    .RST(\u3bpd/state_FSM_FFd3/SRINV_756 ),
    .O(\u3bpd/state_FSM_FFd2_261 )
  );
  X_LUT4 #(
    .INIT ( 16'h3FAB ),
    .LOC ( "SLICE_X12Y5" ))
  \u3bpd/state_FSM_FFd3-In1  (
    .ADR0(\u3bpd/state_FSM_FFd3_262 ),
    .ADR1(\u3bpd/state_FSM_FFd1_263 ),
    .ADR2(downButton_IBUF_249),
    .ADR3(\u3bpd/state_FSM_FFd2_261 ),
    .O(\u3bpd/state_FSM_FFd3-In )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y5" ),
    .INIT ( 1'b0 ))
  \u3bpd/state_FSM_FFd3  (
    .I(\u3bpd/state_FSM_FFd3/DXMUX_778 ),
    .CE(VCC),
    .CLK(\u3bpd/state_FSM_FFd3/CLKINV_755 ),
    .SET(GND),
    .RST(\u3bpd/state_FSM_FFd3/SRINV_756 ),
    .O(\u3bpd/state_FSM_FFd3_262 )
  );
  X_FF #(
    .LOC ( "SLICE_X17Y5" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/DYMUX_790 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[10].uitff/q_276 )
  );
  X_FF #(
    .LOC ( "SLICE_X16Y4" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/DYMUX_799 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[11].uitff/q_278 )
  );
  X_FF #(
    .LOC ( "SLICE_X16Y5" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/DYMUX_808 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[12].uitff/q_279 )
  );
  X_FF #(
    .LOC ( "SLICE_X12Y0" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/u0tff/q  (
    .I(\u1rs/u1rc/u0tff/q/DYMUX_817 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/u0tff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/u0tff/q_280 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y4" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/DYMUX_826 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[13].uitff/q_281 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y0" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/DYMUX_835 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[0].uitff/q_282 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y5" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/DYMUX_844 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[14].uitff/q_283 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y1" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/DYMUX_853 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[1].uitff/q_284 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y5" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/DYMUX_862 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[15].uitff/q_285 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y0" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/DYMUX_871 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[2].uitff/q_286 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y4" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/DYMUX_880 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[16].uitff/q_287 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y1" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/DYMUX_889 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[3].uitff/q_288 )
  );
  X_FF #(
    .LOC ( "SLICE_X14Y6" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/DYMUX_898 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[17].uitff/q_289 )
  );
  X_FF #(
    .LOC ( "SLICE_X16Y1" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/DYMUX_907 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[4].uitff/q_290 )
  );
  X_FF #(
    .LOC ( "SLICE_X15Y6" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/DYMUX_916 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[18].uitff/q_260 )
  );
  X_FF #(
    .LOC ( "SLICE_X17Y1" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/DYMUX_925 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[5].uitff/q_291 )
  );
  X_FF #(
    .LOC ( "SLICE_X17Y0" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/DYMUX_934 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[6].uitff/q_292 )
  );
  X_FF #(
    .LOC ( "SLICE_X16Y0" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/DYMUX_943 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[7].uitff/q_293 )
  );
  X_FF #(
    .LOC ( "SLICE_X16Y3" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/DYMUX_952 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[8].uitff/q_294 )
  );
  X_FF #(
    .LOC ( "SLICE_X17Y4" ),
    .INIT ( 1'b0 ))
  \u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q  (
    .I(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/DYMUX_961 ),
    .CE(VCC),
    .CLK(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q/CLKINVNOT ),
    .SET(GND),
    .RST(GND),
    .O(\u1rs/u1rc/sizeMinusOneFlipFlops[9].uitff/q_277 )
  );
  X_ONE   GLOBAL_LOGIC1_VCC (
    .O(GLOBAL_LOGIC1)
  );
  X_BUF #(
    .LOC ( "PAD155" ))
  \counter<0>/OUTPUT/OFF/OMUX  (
    .I(\u4udc/counter [0]),
    .O(\counter<0>/O )
  );
  X_BUF #(
    .LOC ( "PAD156" ))
  \counter<1>/OUTPUT/OFF/OMUX  (
    .I(\u4udc/counter [1]),
    .O(\counter<1>/O )
  );
  X_BUF #(
    .LOC ( "PAD165" ))
  \counter<2>/OUTPUT/OFF/OMUX  (
    .I(\u4udc/counter [2]),
    .O(\counter<2>/O )
  );
  X_BUF #(
    .LOC ( "PAD166" ))
  \counter<3>/OUTPUT/OFF/OMUX  (
    .I(\u4udc/counter [3]),
    .O(\counter<3>/O )
  );
  X_ZERO   NlwBlock_FourBitCounterWithLoad_GND (
    .O(GND)
  );
  X_ONE   NlwBlock_FourBitCounterWithLoad_VCC (
    .O(VCC)
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

