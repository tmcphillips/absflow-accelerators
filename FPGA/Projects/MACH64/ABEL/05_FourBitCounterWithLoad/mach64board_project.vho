-- VHDL netlist-file
library mach;
use mach.components.all;

library ieee;
use ieee.std_logic_1164.all;
entity FourBitCounterWithLoad is
  port (
    oneMHzClock : in std_logic;
    upButton : in std_logic;
    downButton : in std_logic;
    loadButton : in std_logic;
    reset : in std_logic;
    stepDirectionUp : in std_logic;
    d0 : in std_logic;
    d1 : in std_logic;
    d2 : in std_logic;
    d3 : in std_logic;
    q0 : out std_logic;
    q1 : out std_logic;
    q2 : out std_logic;
    q3 : out std_logic
  );
end FourBitCounterWithLoad;

architecture NetList of FourBitCounterWithLoad is

  signal oneMHzClockPIN : std_logic;
  signal upButtonPIN : std_logic;
  signal downButtonPIN : std_logic;
  signal loadButtonPIN : std_logic;
  signal resetPIN : std_logic;
  signal stepDirectionUpPIN : std_logic;
  signal d0PIN : std_logic;
  signal d1PIN : std_logic;
  signal d2PIN : std_logic;
  signal d3PIN : std_logic;
  signal q0Q : std_logic;
  signal q1Q : std_logic;
  signal q2Q : std_logic;
  signal q3Q : std_logic;
  signal X0_debouncedQ : std_logic;
  signal B0_debouncedQ : std_logic;
  signal L0_debouncedQ : std_logic;
  signal S0_s9Q : std_logic;
  signal S0_s8Q : std_logic;
  signal S0_s7Q : std_logic;
  signal S0_s6Q : std_logic;
  signal S0_s5Q : std_logic;
  signal S0_s4Q : std_logic;
  signal S0_s3Q : std_logic;
  signal S0_s2Q : std_logic;
  signal S0_s1Q : std_logic;
  signal S0_s0Q : std_logic;
  signal X1_lastSampleQ : std_logic;
  signal B1_lastSampleQ : std_logic;
  signal L1_lastSampleQ : std_logic;
  signal q0_D : std_logic;
  signal T_0 : std_logic;
  signal q0_AR : std_logic;
  signal q1_D_X1 : std_logic;
  signal q1_D_X2 : std_logic;
  signal T_1 : std_logic;
  signal q1_AR : std_logic;
  signal q2_T : std_logic;
  signal T_2 : std_logic;
  signal q2_AR : std_logic;
  signal q3_T : std_logic;
  signal T_3 : std_logic;
  signal q3_AR : std_logic;
  signal X0_debounced_D : std_logic;
  signal B0_debounced_D : std_logic;
  signal L0_debounced_D : std_logic;
  signal S0_s9_T : std_logic;
  signal S0_s8_T : std_logic;
  signal S0_s7_T : std_logic;
  signal S0_s6_T : std_logic;
  signal S0_s5_T : std_logic;
  signal S0_s4_D_X2 : std_logic;
  signal S0_s3_D : std_logic;
  signal S0_s2_D : std_logic;
  signal S0_s1_D : std_logic;
  signal S0_s0_D : std_logic;
  signal X1_lastSample_D : std_logic;
  signal B1_lastSample_D : std_logic;
  signal L1_lastSample_D : std_logic;
  signal q1_D : std_logic;
  signal S0_s4_D : std_logic;
  signal q0_C : std_logic;
  signal q1_C : std_logic;
  signal q2_C : std_logic;
  signal q3_C : std_logic;
  signal T_4 : std_logic;
  signal T_5 : std_logic;
  signal T_6 : std_logic;
  signal T_7 : std_logic;
  signal T_8 : std_logic;
  signal T_9 : std_logic;
  signal T_10 : std_logic;
  signal T_11 : std_logic;
  signal T_12 : std_logic;
  signal T_13 : std_logic;
  signal T_14 : std_logic;
  signal T_15 : std_logic;
  signal T_16 : std_logic;
  signal T_17 : std_logic;
  signal T_18 : std_logic;
  signal T_19 : std_logic;
  signal T_20 : std_logic;
  signal T_21 : std_logic;
  signal T_22 : std_logic;
  signal T_23 : std_logic;
  signal T_24 : std_logic;
  signal T_25 : std_logic;
  signal T_26 : std_logic;
  signal T_27 : std_logic;
  signal T_28 : std_logic;
  signal T_29 : std_logic;
  signal T_30 : std_logic;
  signal T_31 : std_logic;
  signal T_32 : std_logic;
  signal T_33 : std_logic;
  signal T_34 : std_logic;
  signal T_35 : std_logic;
  signal T_36 : std_logic;
  signal T_37 : std_logic;
  signal T_38 : std_logic;
  signal T_39 : std_logic;
  signal T_40 : std_logic;
  signal T_41 : std_logic;
  signal T_42 : std_logic;
  signal T_43 : std_logic;
  signal T_44 : std_logic;
  signal T_45 : std_logic;
  signal T_46 : std_logic;
  signal T_47 : std_logic;
  signal T_48 : std_logic;
  signal T_49 : std_logic;
  signal T_50 : std_logic;
  signal T_51 : std_logic;
  signal T_52 : std_logic;
  signal T_53 : std_logic;
  signal T_54 : std_logic;
  signal T_55 : std_logic;
  signal T_56 : std_logic;
  signal T_57 : std_logic;
  signal T_58 : std_logic;
  signal T_59 : std_logic;
  signal T_60 : std_logic;
  signal T_61 : std_logic;
  signal T_62 : std_logic;
  signal T_63 : std_logic;
  signal T_64 : std_logic;
  signal T_65 : std_logic;
  signal T_66 : std_logic;
  signal T_67 : std_logic;
  signal T_68 : std_logic;
  signal T_69 : std_logic;
  signal T_70 : std_logic;
  signal T_71 : std_logic;
  signal T_72 : std_logic;
  signal GATE_q1_D_X2_A : std_logic;
  signal GATE_X0_debounced_D_A : std_logic;
  signal GATE_B0_debounced_D_A : std_logic;
  signal GATE_L0_debounced_D_A : std_logic;
  signal GATE_T_4_DN : std_logic;
  signal GATE_T_5_A : std_logic;
  signal GATE_T_6_B : std_logic;
  signal GATE_T_6_A : std_logic;
  signal GATE_T_9_A : std_logic;
  signal GATE_T_10_A : std_logic;
  signal GATE_T_11_A : std_logic;
  signal GATE_T_12_A : std_logic;
  signal GATE_T_13_A : std_logic;
  signal GATE_T_14_A : std_logic;
  signal GATE_T_15_A : std_logic;
  signal GATE_T_21_A : std_logic;
  signal GATE_T_22_A : std_logic;
  signal GATE_T_23_A : std_logic;
  signal GATE_T_27_A : std_logic;
  signal GATE_T_28_A : std_logic;
  signal GATE_T_52_A : std_logic;
  signal GATE_T_53_A : std_logic;
  signal GATE_T_56_A : std_logic;
  signal GATE_T_58_A : std_logic;
  signal GATE_T_66_A : std_logic;
  signal GATE_T_70_A : std_logic;

begin
  IN_oneMHzClock_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>oneMHzClockPIN, 
            I0=>oneMHzClock );
  IN_upButton_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>upButtonPIN, 
            I0=>upButton );
  IN_downButton_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>downButtonPIN, 
            I0=>downButton );
  IN_loadButton_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>loadButtonPIN, 
            I0=>loadButton );
  IN_reset_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>resetPIN, 
            I0=>reset );
  IN_stepDirectionUp_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>stepDirectionUpPIN, 
            I0=>stepDirectionUp );
  IN_d0_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d0PIN, 
            I0=>d0 );
  IN_d1_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d1PIN, 
            I0=>d1 );
  IN_d2_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d2PIN, 
            I0=>d2 );
  IN_d3_I_1:   IBUF
 generic map( PULL => "Up")
 port map ( O=>d3PIN, 
            I0=>d3 );
  OUT_q0_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>q0, 
            I0=>q0Q );
  OUT_q1_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>q1, 
            I0=>q1Q );
  OUT_q2_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>q2, 
            I0=>q2Q );
  OUT_q3_I_1:   OBUF
 generic map( PULL => "Up")
 port map ( O=>q3, 
            I0=>q3Q );
  FF_q0_I_1:   DFFRH port map ( Q=>q0Q, 
            R=>q0_AR, 
            CLK=>q0_C, 
            D=>q0_D );
  FF_q1_I_1:   DFFRH port map ( Q=>q1Q, 
            R=>q1_AR, 
            CLK=>q1_C, 
            D=>q1_D );
  FF_q2_I_1:   TFFRH port map ( T=>q2_T, 
            Q=>q2Q, 
            CLK=>q2_C, 
            R=>q2_AR );
  FF_q3_I_1:   TFFRH port map ( T=>q3_T, 
            Q=>q3Q, 
            CLK=>q3_C, 
            R=>q3_AR );
  FF_X0_debounced_I_1:   DFF port map ( D=>X0_debounced_D, 
            Q=>X0_debouncedQ, 
            CLK=>S0_s9Q );
  FF_B0_debounced_I_1:   DFF port map ( D=>B0_debounced_D, 
            Q=>B0_debouncedQ, 
            CLK=>S0_s9Q );
  FF_L0_debounced_I_1:   DFF port map ( D=>L0_debounced_D, 
            Q=>L0_debouncedQ, 
            CLK=>S0_s9Q );
  FF_S0_s9_I_1:   TFF port map ( T=>S0_s9_T, 
            Q=>S0_s9Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s8_I_1:   TFF port map ( T=>S0_s8_T, 
            Q=>S0_s8Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s7_I_1:   TFF port map ( T=>S0_s7_T, 
            Q=>S0_s7Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s6_I_1:   TFF port map ( T=>S0_s6_T, 
            Q=>S0_s6Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s5_I_1:   TFF port map ( T=>S0_s5_T, 
            Q=>S0_s5Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s4_I_1:   DFF port map ( D=>S0_s4_D, 
            Q=>S0_s4Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s3_I_1:   DFF port map ( D=>S0_s3_D, 
            Q=>S0_s3Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s2_I_1:   DFF port map ( D=>S0_s2_D, 
            Q=>S0_s2Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s1_I_1:   DFF port map ( D=>S0_s1_D, 
            Q=>S0_s1Q, 
            CLK=>oneMHzClockPIN );
  FF_S0_s0_I_1:   DFF port map ( D=>S0_s0_D, 
            Q=>S0_s0Q, 
            CLK=>oneMHzClockPIN );
  FF_X1_lastSample_I_1:   DFF port map ( D=>X1_lastSample_D, 
            Q=>X1_lastSampleQ, 
            CLK=>S0_s9Q );
  FF_B1_lastSample_I_1:   DFF port map ( D=>B1_lastSample_D, 
            Q=>B1_lastSampleQ, 
            CLK=>S0_s9Q );
  FF_L1_lastSample_I_1:   DFF port map ( D=>L1_lastSample_D, 
            Q=>L1_lastSampleQ, 
            CLK=>S0_s9Q );
  GATE_q0_D_I_1:   OR2 port map ( O=>q0_D, 
            I1=>T_29, 
            I0=>T_28 );
  GATE_T_0_I_1:   NOR3 port map ( O=>T_0, 
            I2=>B0_debouncedQ, 
            I1=>X0_debouncedQ, 
            I0=>L0_debouncedQ );
  GATE_q0_AR_I_1:   INV port map ( I0=>resetPIN, 
            O=>q0_AR );
  GATE_q1_D_X1_I_1:   OR3 port map ( O=>q1_D_X1, 
            I2=>T_31, 
            I1=>T_8, 
            I0=>T_30 );
  GATE_q1_D_X2_I_1:   AND2 port map ( O=>q1_D_X2, 
            I1=>loadButtonPIN, 
            I0=>GATE_q1_D_X2_A );
  GATE_q1_D_X2_I_2:   INV port map ( O=>GATE_q1_D_X2_A, 
            I0=>q1Q );
  GATE_T_1_I_1:   NOR3 port map ( O=>T_1, 
            I2=>B0_debouncedQ, 
            I1=>X0_debouncedQ, 
            I0=>L0_debouncedQ );
  GATE_q1_AR_I_1:   INV port map ( I0=>resetPIN, 
            O=>q1_AR );
  GATE_q2_T_I_1:   OR3 port map ( O=>q2_T, 
            I2=>T_63, 
            I1=>T_64, 
            I0=>T_62 );
  GATE_T_2_I_1:   NOR3 port map ( O=>T_2, 
            I2=>B0_debouncedQ, 
            I1=>X0_debouncedQ, 
            I0=>L0_debouncedQ );
  GATE_q2_AR_I_1:   INV port map ( I0=>resetPIN, 
            O=>q2_AR );
  GATE_q3_T_I_1:   OR3 port map ( O=>q3_T, 
            I2=>T_48, 
            I1=>T_49, 
            I0=>T_47 );
  GATE_T_3_I_1:   NOR3 port map ( O=>T_3, 
            I2=>B0_debouncedQ, 
            I1=>X0_debouncedQ, 
            I0=>L0_debouncedQ );
  GATE_q3_AR_I_1:   INV port map ( I0=>resetPIN, 
            O=>q3_AR );
  GATE_X0_debounced_D_I_1:   AND2 port map ( O=>X0_debounced_D, 
            I1=>X1_lastSampleQ, 
            I0=>GATE_X0_debounced_D_A );
  GATE_X0_debounced_D_I_2:   INV port map ( O=>GATE_X0_debounced_D_A, 
            I0=>upButtonPIN );
  GATE_B0_debounced_D_I_1:   AND2 port map ( O=>B0_debounced_D, 
            I1=>B1_lastSampleQ, 
            I0=>GATE_B0_debounced_D_A );
  GATE_B0_debounced_D_I_2:   INV port map ( O=>GATE_B0_debounced_D_A, 
            I0=>downButtonPIN );
  GATE_L0_debounced_D_I_1:   AND2 port map ( O=>L0_debounced_D, 
            I1=>L1_lastSampleQ, 
            I0=>GATE_L0_debounced_D_A );
  GATE_L0_debounced_D_I_2:   INV port map ( O=>GATE_L0_debounced_D_A, 
            I0=>loadButtonPIN );
  GATE_S0_s9_T_I_1:   AND3 port map ( O=>S0_s9_T, 
            I2=>T_45, 
            I1=>T_46, 
            I0=>T_44 );
  GATE_S0_s8_T_I_1:   AND4 port map ( O=>S0_s8_T, 
            I3=>T_40, 
            I2=>T_41, 
            I1=>T_42, 
            I0=>T_43 );
  GATE_S0_s7_T_I_1:   AND4 port map ( O=>S0_s7_T, 
            I3=>T_37, 
            I2=>T_38, 
            I1=>T_39, 
            I0=>S0_s0Q );
  GATE_S0_s6_T_I_1:   AND3 port map ( O=>S0_s6_T, 
            I2=>T_35, 
            I1=>T_36, 
            I0=>T_34 );
  GATE_S0_s5_T_I_1:   AND3 port map ( O=>S0_s5_T, 
            I2=>T_33, 
            I1=>S0_s0Q, 
            I0=>T_32 );
  GATE_S0_s4_D_X2_I_1:   AND4 port map ( O=>S0_s4_D_X2, 
            I3=>S0_s0Q, 
            I2=>S0_s1Q, 
            I1=>S0_s2Q, 
            I0=>S0_s3Q );
  GATE_S0_s3_D_I_1:   OR4 port map ( I0=>T_12, 
            I1=>T_13, 
            O=>S0_s3_D, 
            I2=>T_14, 
            I3=>T_15 );
  GATE_S0_s2_D_I_1:   OR3 port map ( O=>S0_s2_D, 
            I2=>T_10, 
            I1=>T_9, 
            I0=>T_11 );
  GATE_S0_s1_D_I_1:   XOR2 port map ( O=>S0_s1_D, 
            I1=>S0_s0Q, 
            I0=>S0_s1Q );
  GATE_S0_s0_D_I_1:   INV port map ( I0=>S0_s0Q, 
            O=>S0_s0_D );
  GATE_X1_lastSample_D_I_1:   INV port map ( I0=>upButtonPIN, 
            O=>X1_lastSample_D );
  GATE_B1_lastSample_D_I_1:   INV port map ( I0=>downButtonPIN, 
            O=>B1_lastSample_D );
  GATE_L1_lastSample_D_I_1:   INV port map ( I0=>loadButtonPIN, 
            O=>L1_lastSample_D );
  GATE_q1_D_I_1:   XOR2 port map ( O=>q1_D, 
            I1=>q1_D_X2, 
            I0=>q1_D_X1 );
  GATE_S0_s4_D_I_1:   XOR2 port map ( O=>S0_s4_D, 
            I1=>S0_s4_D_X2, 
            I0=>S0_s4Q );
  GATE_q0_C_I_1:   INV port map ( I0=>T_0, 
            O=>q0_C );
  GATE_q1_C_I_1:   INV port map ( I0=>T_1, 
            O=>q1_C );
  GATE_q2_C_I_1:   INV port map ( I0=>T_2, 
            O=>q2_C );
  GATE_q3_C_I_1:   INV port map ( I0=>T_3, 
            O=>q3_C );
  GATE_T_4_I_1:   NOR4 port map ( I0=>q0Q, 
            I1=>stepDirectionUpPIN, 
            O=>T_4, 
            I2=>upButtonPIN, 
            I3=>GATE_T_4_DN );
  GATE_T_4_I_2:   INV port map ( I0=>loadButtonPIN, 
            O=>GATE_T_4_DN );
  GATE_T_5_I_1:   AND4 port map ( O=>T_5, 
            I3=>loadButtonPIN, 
            I2=>upButtonPIN, 
            I1=>q0Q, 
            I0=>GATE_T_5_A );
  GATE_T_5_I_2:   INV port map ( I0=>stepDirectionUpPIN, 
            O=>GATE_T_5_A );
  GATE_T_6_I_3:   AND4 port map ( O=>T_6, 
            I3=>stepDirectionUpPIN, 
            I2=>loadButtonPIN, 
            I1=>GATE_T_6_B, 
            I0=>GATE_T_6_A );
  GATE_T_6_I_2:   INV port map ( I0=>q0Q, 
            O=>GATE_T_6_B );
  GATE_T_6_I_1:   INV port map ( I0=>downButtonPIN, 
            O=>GATE_T_6_A );
  GATE_T_7_I_1:   AND4 port map ( O=>T_7, 
            I3=>stepDirectionUpPIN, 
            I2=>q0Q, 
            I1=>loadButtonPIN, 
            I0=>downButtonPIN );
  GATE_T_8_I_1:   NOR2 port map ( O=>T_8, 
            I1=>d1PIN, 
            I0=>loadButtonPIN );
  GATE_T_9_I_1:   INV port map ( I0=>S0_s2Q, 
            O=>GATE_T_9_A );
  GATE_T_9_I_2:   AND3 port map ( O=>T_9, 
            I2=>S0_s1Q, 
            I1=>S0_s0Q, 
            I0=>GATE_T_9_A );
  GATE_T_10_I_1:   AND2 port map ( O=>T_10, 
            I1=>S0_s2Q, 
            I0=>GATE_T_10_A );
  GATE_T_10_I_2:   INV port map ( O=>GATE_T_10_A, 
            I0=>S0_s0Q );
  GATE_T_11_I_1:   AND2 port map ( O=>T_11, 
            I1=>S0_s2Q, 
            I0=>GATE_T_11_A );
  GATE_T_11_I_2:   INV port map ( O=>GATE_T_11_A, 
            I0=>S0_s1Q );
  GATE_T_12_I_1:   AND4 port map ( O=>T_12, 
            I3=>S0_s0Q, 
            I2=>S0_s1Q, 
            I1=>S0_s2Q, 
            I0=>GATE_T_12_A );
  GATE_T_12_I_2:   INV port map ( I0=>S0_s3Q, 
            O=>GATE_T_12_A );
  GATE_T_13_I_1:   AND2 port map ( O=>T_13, 
            I1=>S0_s3Q, 
            I0=>GATE_T_13_A );
  GATE_T_13_I_2:   INV port map ( O=>GATE_T_13_A, 
            I0=>S0_s0Q );
  GATE_T_14_I_1:   AND2 port map ( O=>T_14, 
            I1=>S0_s3Q, 
            I0=>GATE_T_14_A );
  GATE_T_14_I_2:   INV port map ( O=>GATE_T_14_A, 
            I0=>S0_s1Q );
  GATE_T_15_I_1:   AND2 port map ( O=>T_15, 
            I1=>S0_s3Q, 
            I0=>GATE_T_15_A );
  GATE_T_15_I_2:   INV port map ( O=>GATE_T_15_A, 
            I0=>S0_s2Q );
  GATE_T_16_I_1:   AND3 port map ( O=>T_16, 
            I2=>T_60, 
            I1=>T_61, 
            I0=>T_59 );
  GATE_T_17_I_1:   AND3 port map ( O=>T_17, 
            I2=>T_57, 
            I1=>T_58, 
            I0=>T_56 );
  GATE_T_18_I_1:   AND3 port map ( O=>T_18, 
            I2=>T_54, 
            I1=>T_55, 
            I0=>T_53 );
  GATE_T_19_I_1:   AND3 port map ( O=>T_19, 
            I2=>T_51, 
            I1=>T_52, 
            I0=>T_50 );
  GATE_T_20_I_1:   NOR3 port map ( O=>T_20, 
            I2=>d3PIN, 
            I1=>loadButtonPIN, 
            I0=>q3Q );
  GATE_T_21_I_1:   INV port map ( I0=>loadButtonPIN, 
            O=>GATE_T_21_A );
  GATE_T_21_I_2:   AND3 port map ( O=>T_21, 
            I2=>d3PIN, 
            I1=>q3Q, 
            I0=>GATE_T_21_A );
  GATE_T_22_I_1:   INV port map ( I0=>stepDirectionUpPIN, 
            O=>GATE_T_22_A );
  GATE_T_22_I_2:   AND3 port map ( O=>T_22, 
            I2=>T_72, 
            I1=>T_71, 
            I0=>GATE_T_22_A );
  GATE_T_23_I_1:   INV port map ( I0=>stepDirectionUpPIN, 
            O=>GATE_T_23_A );
  GATE_T_23_I_2:   AND3 port map ( O=>T_23, 
            I2=>T_70, 
            I1=>T_69, 
            I0=>GATE_T_23_A );
  GATE_T_24_I_1:   AND3 port map ( O=>T_24, 
            I2=>T_68, 
            I1=>stepDirectionUpPIN, 
            I0=>T_67 );
  GATE_T_25_I_1:   AND3 port map ( O=>T_25, 
            I2=>T_66, 
            I1=>stepDirectionUpPIN, 
            I0=>T_65 );
  GATE_T_26_I_1:   NOR3 port map ( O=>T_26, 
            I2=>d2PIN, 
            I1=>loadButtonPIN, 
            I0=>q2Q );
  GATE_T_27_I_1:   INV port map ( I0=>loadButtonPIN, 
            O=>GATE_T_27_A );
  GATE_T_27_I_2:   AND3 port map ( O=>T_27, 
            I2=>d2PIN, 
            I1=>q2Q, 
            I0=>GATE_T_27_A );
  GATE_T_28_I_1:   AND2 port map ( O=>T_28, 
            I1=>loadButtonPIN, 
            I0=>GATE_T_28_A );
  GATE_T_28_I_2:   INV port map ( O=>GATE_T_28_A, 
            I0=>q0Q );
  GATE_T_29_I_1:   NOR2 port map ( O=>T_29, 
            I1=>d0PIN, 
            I0=>loadButtonPIN );
  GATE_T_30_I_1:   OR2 port map ( O=>T_30, 
            I1=>T_7, 
            I0=>T_6 );
  GATE_T_31_I_1:   OR2 port map ( O=>T_31, 
            I1=>T_5, 
            I0=>T_4 );
  GATE_T_32_I_1:   AND2 port map ( O=>T_32, 
            I1=>S0_s1Q, 
            I0=>S0_s2Q );
  GATE_T_33_I_1:   AND2 port map ( O=>T_33, 
            I1=>S0_s3Q, 
            I0=>S0_s4Q );
  GATE_T_34_I_1:   AND2 port map ( O=>T_34, 
            I1=>S0_s0Q, 
            I0=>S0_s1Q );
  GATE_T_35_I_1:   AND2 port map ( O=>T_35, 
            I1=>S0_s2Q, 
            I0=>S0_s3Q );
  GATE_T_36_I_1:   AND2 port map ( O=>T_36, 
            I1=>S0_s4Q, 
            I0=>S0_s5Q );
  GATE_T_37_I_1:   AND2 port map ( O=>T_37, 
            I1=>S0_s1Q, 
            I0=>S0_s2Q );
  GATE_T_38_I_1:   AND2 port map ( O=>T_38, 
            I1=>S0_s3Q, 
            I0=>S0_s4Q );
  GATE_T_39_I_1:   AND2 port map ( O=>T_39, 
            I1=>S0_s5Q, 
            I0=>S0_s6Q );
  GATE_T_40_I_1:   AND2 port map ( O=>T_40, 
            I1=>S0_s0Q, 
            I0=>S0_s1Q );
  GATE_T_41_I_1:   AND2 port map ( O=>T_41, 
            I1=>S0_s2Q, 
            I0=>S0_s3Q );
  GATE_T_42_I_1:   AND2 port map ( O=>T_42, 
            I1=>S0_s4Q, 
            I0=>S0_s5Q );
  GATE_T_43_I_1:   AND2 port map ( O=>T_43, 
            I1=>S0_s6Q, 
            I0=>S0_s7Q );
  GATE_T_44_I_1:   AND3 port map ( O=>T_44, 
            I2=>S0_s1Q, 
            I1=>S0_s2Q, 
            I0=>S0_s0Q );
  GATE_T_45_I_1:   AND3 port map ( O=>T_45, 
            I2=>S0_s4Q, 
            I1=>S0_s5Q, 
            I0=>S0_s3Q );
  GATE_T_46_I_1:   AND3 port map ( O=>T_46, 
            I2=>S0_s7Q, 
            I1=>S0_s8Q, 
            I0=>S0_s6Q );
  GATE_T_47_I_1:   OR2 port map ( O=>T_47, 
            I1=>T_21, 
            I0=>T_20 );
  GATE_T_48_I_1:   OR2 port map ( O=>T_48, 
            I1=>T_19, 
            I0=>T_18 );
  GATE_T_49_I_1:   OR2 port map ( O=>T_49, 
            I1=>T_17, 
            I0=>T_16 );
  GATE_T_50_I_1:   AND2 port map ( O=>T_50, 
            I1=>stepDirectionUpPIN, 
            I0=>q0Q );
  GATE_T_51_I_1:   AND2 port map ( O=>T_51, 
            I1=>q1Q, 
            I0=>q2Q );
  GATE_T_52_I_1:   AND2 port map ( O=>T_52, 
            I1=>loadButtonPIN, 
            I0=>GATE_T_52_A );
  GATE_T_52_I_2:   INV port map ( O=>GATE_T_52_A, 
            I0=>downButtonPIN );
  GATE_T_53_I_1:   AND2 port map ( O=>T_53, 
            I1=>stepDirectionUpPIN, 
            I0=>GATE_T_53_A );
  GATE_T_53_I_2:   INV port map ( O=>GATE_T_53_A, 
            I0=>q0Q );
  GATE_T_54_I_1:   NOR2 port map ( O=>T_54, 
            I1=>q1Q, 
            I0=>q2Q );
  GATE_T_55_I_1:   AND2 port map ( O=>T_55, 
            I1=>loadButtonPIN, 
            I0=>downButtonPIN );
  GATE_T_56_I_1:   AND2 port map ( O=>T_56, 
            I1=>q0Q, 
            I0=>GATE_T_56_A );
  GATE_T_56_I_2:   INV port map ( O=>GATE_T_56_A, 
            I0=>stepDirectionUpPIN );
  GATE_T_57_I_1:   AND2 port map ( O=>T_57, 
            I1=>q1Q, 
            I0=>q2Q );
  GATE_T_58_I_1:   AND2 port map ( O=>T_58, 
            I1=>loadButtonPIN, 
            I0=>GATE_T_58_A );
  GATE_T_58_I_2:   INV port map ( O=>GATE_T_58_A, 
            I0=>upButtonPIN );
  GATE_T_59_I_1:   NOR2 port map ( O=>T_59, 
            I1=>stepDirectionUpPIN, 
            I0=>q0Q );
  GATE_T_60_I_1:   NOR2 port map ( O=>T_60, 
            I1=>q1Q, 
            I0=>q2Q );
  GATE_T_61_I_1:   AND2 port map ( O=>T_61, 
            I1=>loadButtonPIN, 
            I0=>upButtonPIN );
  GATE_T_62_I_1:   OR2 port map ( O=>T_62, 
            I1=>T_27, 
            I0=>T_26 );
  GATE_T_63_I_1:   OR2 port map ( O=>T_63, 
            I1=>T_25, 
            I0=>T_24 );
  GATE_T_64_I_1:   OR2 port map ( O=>T_64, 
            I1=>T_23, 
            I0=>T_22 );
  GATE_T_65_I_1:   AND2 port map ( O=>T_65, 
            I1=>q0Q, 
            I0=>q1Q );
  GATE_T_66_I_1:   AND2 port map ( O=>T_66, 
            I1=>loadButtonPIN, 
            I0=>GATE_T_66_A );
  GATE_T_66_I_2:   INV port map ( O=>GATE_T_66_A, 
            I0=>downButtonPIN );
  GATE_T_67_I_1:   NOR2 port map ( O=>T_67, 
            I1=>q0Q, 
            I0=>q1Q );
  GATE_T_68_I_1:   AND2 port map ( O=>T_68, 
            I1=>loadButtonPIN, 
            I0=>downButtonPIN );
  GATE_T_69_I_1:   AND2 port map ( O=>T_69, 
            I1=>q0Q, 
            I0=>q1Q );
  GATE_T_70_I_1:   AND2 port map ( O=>T_70, 
            I1=>loadButtonPIN, 
            I0=>GATE_T_70_A );
  GATE_T_70_I_2:   INV port map ( O=>GATE_T_70_A, 
            I0=>upButtonPIN );
  GATE_T_71_I_1:   NOR2 port map ( O=>T_71, 
            I1=>q0Q, 
            I0=>q1Q );
  GATE_T_72_I_1:   AND2 port map ( O=>T_72, 
            I1=>loadButtonPIN, 
            I0=>upButtonPIN );

end NetList;
