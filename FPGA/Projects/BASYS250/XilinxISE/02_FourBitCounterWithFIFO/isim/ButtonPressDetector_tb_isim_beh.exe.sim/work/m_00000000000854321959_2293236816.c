/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x2f00eba5 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/tmcphillips/Designs/Projects/BASYS250/VerilogHDL/02_FourBitCounterWithFIFO/buttonpressdetector_tb.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {0U, 0U};
static const char *ng3 = "*** FAILURE ****  simulation assertion failure at t = %t \n";
static unsigned int ng4[] = {2U, 0U};
static unsigned int ng5[] = {3U, 0U};
static unsigned int ng6[] = {4U, 0U};
static unsigned int ng7[] = {5U, 0U};
static const char *ng8 = "1us/1ns";
static const char *ng9 = "ButtonPressDetector_tb";
static int ng10[] = {6, 0};
static int ng11[] = {10, 0};
static const char *ng12 = "";
static const char *ng13 = "*** SUCCESS ***  Simulation ended succesfully at t = %t \n";



static int sp_resetSystem(char *t1, char *t2)
{
    char t9[8];
    char t10[8];
    char t37[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    double t36;
    char *t38;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 484);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(53, ng0);

LAB5:    xsi_set_current_line(55, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(55, ng0);
    t7 = ((char*)((ng1)));
    t8 = (t1 + 2732);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 1);
    xsi_set_current_line(56, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB7;
    t0 = 1;
    goto LAB1;

LAB7:    xsi_set_current_line(56, ng0);
    t6 = ((char*)((ng2)));
    t7 = (t1 + 2732);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 1);
    xsi_set_current_line(57, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t4);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t7);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t7);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB11;

LAB8:    if (t20 != 0)
        goto LAB10;

LAB9:    *((unsigned int *)t10) = 1;

LAB11:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB15;

LAB13:    if (*((unsigned int *)t23) == 0)
        goto LAB12;

LAB14:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB15:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB16;

LAB17:
LAB18:    xsi_set_current_line(58, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t4);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t7);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t7);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB23;

LAB20:    if (t20 != 0)
        goto LAB22;

LAB21:    *((unsigned int *)t10) = 1;

LAB23:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB27;

LAB25:    if (*((unsigned int *)t23) == 0)
        goto LAB24;

LAB26:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB27:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB28;

LAB29:
LAB30:    goto LAB4;

LAB10:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB11;

LAB12:    *((unsigned int *)t9) = 1;
    goto LAB15;

LAB16:    xsi_set_current_line(57, ng0);

LAB19:    xsi_set_current_line(57, ng0);
    t36 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(57, ng0);
    xsi_vlog_finish(1);
    goto LAB18;

LAB22:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB23;

LAB24:    *((unsigned int *)t9) = 1;
    goto LAB27;

LAB28:    xsi_set_current_line(58, ng0);

LAB31:    xsi_set_current_line(58, ng0);
    t36 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(58, ng0);
    xsi_vlog_finish(1);
    goto LAB30;

}

static int sp_testLongButtonPress(char *t1, char *t2)
{
    char t7[8];
    char t10[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    double t39;
    char *t41;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 740);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(63, ng0);

LAB5:    xsi_set_current_line(65, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(65, ng0);
    t8 = (t1 + 2228U);
    t9 = *((char **)t8);
    t8 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t11 = (t9 + 4);
    t12 = (t8 + 4);
    t13 = *((unsigned int *)t9);
    t14 = *((unsigned int *)t8);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t11);
    t21 = *((unsigned int *)t12);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB10;

LAB7:    if (t22 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t10) = 1;

LAB10:    memset(t7, 0, 8);
    t26 = (t10 + 4);
    t27 = *((unsigned int *)t26);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t26) == 0)
        goto LAB11;

LAB13:    t32 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t32) = 1;

LAB14:    t33 = (t7 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(66, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB22;

LAB19:    if (t22 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t10) = 1;

LAB22:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t11) == 0)
        goto LAB23;

LAB25:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB26:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(68, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB31;
    t0 = 1;
    goto LAB1;

LAB9:    t25 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(65, ng0);

LAB18:    xsi_set_current_line(65, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t41 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t41, (char)114, t40, 64);
    xsi_set_current_line(65, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(66, ng0);

LAB30:    xsi_set_current_line(66, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(66, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(68, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(70, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB35;

LAB32:    if (t22 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t10) = 1;

LAB35:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB39;

LAB37:    if (*((unsigned int *)t11) == 0)
        goto LAB36;

LAB38:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB39:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(71, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB47;

LAB44:    if (t22 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t10) = 1;

LAB47:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB51;

LAB49:    if (*((unsigned int *)t11) == 0)
        goto LAB48;

LAB50:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB51:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(73, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB56;
    t0 = 1;
    goto LAB1;

LAB34:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB35;

LAB36:    *((unsigned int *)t7) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(70, ng0);

LAB43:    xsi_set_current_line(70, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(70, ng0);
    xsi_vlog_finish(1);
    goto LAB42;

LAB46:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t7) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(71, ng0);

LAB55:    xsi_set_current_line(71, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(71, ng0);
    xsi_vlog_finish(1);
    goto LAB54;

LAB56:    xsi_set_current_line(73, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng4)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB60;

LAB57:    if (t22 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t10) = 1;

LAB60:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB64;

LAB62:    if (*((unsigned int *)t25) == 0)
        goto LAB61;

LAB63:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB64:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(74, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB72;

LAB69:    if (t22 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t10) = 1;

LAB72:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB76;

LAB74:    if (*((unsigned int *)t11) == 0)
        goto LAB73;

LAB75:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB76:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(76, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB81;
    t0 = 1;
    goto LAB1;

LAB59:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB60;

LAB61:    *((unsigned int *)t7) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(73, ng0);

LAB68:    xsi_set_current_line(73, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(73, ng0);
    xsi_vlog_finish(1);
    goto LAB67;

LAB71:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t7) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(74, ng0);

LAB80:    xsi_set_current_line(74, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(74, ng0);
    xsi_vlog_finish(1);
    goto LAB79;

LAB81:    xsi_set_current_line(76, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng5)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB85;

LAB82:    if (t22 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t10) = 1;

LAB85:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB89;

LAB87:    if (*((unsigned int *)t25) == 0)
        goto LAB86;

LAB88:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB89:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB90;

LAB91:
LAB92:    xsi_set_current_line(77, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB97;

LAB94:    if (t22 != 0)
        goto LAB96;

LAB95:    *((unsigned int *)t10) = 1;

LAB97:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB101;

LAB99:    if (*((unsigned int *)t11) == 0)
        goto LAB98;

LAB100:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB101:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB102;

LAB103:
LAB104:    xsi_set_current_line(79, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB106;
    t0 = 1;
    goto LAB1;

LAB84:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t7) = 1;
    goto LAB89;

LAB90:    xsi_set_current_line(76, ng0);

LAB93:    xsi_set_current_line(76, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(76, ng0);
    xsi_vlog_finish(1);
    goto LAB92;

LAB96:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB97;

LAB98:    *((unsigned int *)t7) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(77, ng0);

LAB105:    xsi_set_current_line(77, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(77, ng0);
    xsi_vlog_finish(1);
    goto LAB104;

LAB106:    xsi_set_current_line(79, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng6)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB110;

LAB107:    if (t22 != 0)
        goto LAB109;

LAB108:    *((unsigned int *)t10) = 1;

LAB110:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB114;

LAB112:    if (*((unsigned int *)t25) == 0)
        goto LAB111;

LAB113:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB114:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB115;

LAB116:
LAB117:    xsi_set_current_line(80, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB122;

LAB119:    if (t22 != 0)
        goto LAB121;

LAB120:    *((unsigned int *)t10) = 1;

LAB122:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB126;

LAB124:    if (*((unsigned int *)t11) == 0)
        goto LAB123;

LAB125:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB126:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB127;

LAB128:
LAB129:    xsi_set_current_line(82, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB131;
    t0 = 1;
    goto LAB1;

LAB109:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB110;

LAB111:    *((unsigned int *)t7) = 1;
    goto LAB114;

LAB115:    xsi_set_current_line(79, ng0);

LAB118:    xsi_set_current_line(79, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(79, ng0);
    xsi_vlog_finish(1);
    goto LAB117;

LAB121:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB122;

LAB123:    *((unsigned int *)t7) = 1;
    goto LAB126;

LAB127:    xsi_set_current_line(80, ng0);

LAB130:    xsi_set_current_line(80, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(80, ng0);
    xsi_vlog_finish(1);
    goto LAB129;

LAB131:    xsi_set_current_line(82, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB135;

LAB132:    if (t22 != 0)
        goto LAB134;

LAB133:    *((unsigned int *)t10) = 1;

LAB135:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB139;

LAB137:    if (*((unsigned int *)t25) == 0)
        goto LAB136;

LAB138:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB139:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB140;

LAB141:
LAB142:    xsi_set_current_line(83, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB147;

LAB144:    if (t22 != 0)
        goto LAB146;

LAB145:    *((unsigned int *)t10) = 1;

LAB147:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB151;

LAB149:    if (*((unsigned int *)t11) == 0)
        goto LAB148;

LAB150:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB151:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB152;

LAB153:
LAB154:    xsi_set_current_line(85, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB156;
    t0 = 1;
    goto LAB1;

LAB134:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB135;

LAB136:    *((unsigned int *)t7) = 1;
    goto LAB139;

LAB140:    xsi_set_current_line(82, ng0);

LAB143:    xsi_set_current_line(82, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(82, ng0);
    xsi_vlog_finish(1);
    goto LAB142;

LAB146:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB147;

LAB148:    *((unsigned int *)t7) = 1;
    goto LAB151;

LAB152:    xsi_set_current_line(83, ng0);

LAB155:    xsi_set_current_line(83, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(83, ng0);
    xsi_vlog_finish(1);
    goto LAB154;

LAB156:    xsi_set_current_line(85, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB160;

LAB157:    if (t22 != 0)
        goto LAB159;

LAB158:    *((unsigned int *)t10) = 1;

LAB160:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB164;

LAB162:    if (*((unsigned int *)t25) == 0)
        goto LAB161;

LAB163:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB164:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB165;

LAB166:
LAB167:    xsi_set_current_line(86, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB172;

LAB169:    if (t22 != 0)
        goto LAB171;

LAB170:    *((unsigned int *)t10) = 1;

LAB172:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB176;

LAB174:    if (*((unsigned int *)t11) == 0)
        goto LAB173;

LAB175:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB176:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB177;

LAB178:
LAB179:    xsi_set_current_line(88, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB181;
    t0 = 1;
    goto LAB1;

LAB159:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB160;

LAB161:    *((unsigned int *)t7) = 1;
    goto LAB164;

LAB165:    xsi_set_current_line(85, ng0);

LAB168:    xsi_set_current_line(85, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(85, ng0);
    xsi_vlog_finish(1);
    goto LAB167;

LAB171:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB172;

LAB173:    *((unsigned int *)t7) = 1;
    goto LAB176;

LAB177:    xsi_set_current_line(86, ng0);

LAB180:    xsi_set_current_line(86, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(86, ng0);
    xsi_vlog_finish(1);
    goto LAB179;

LAB181:    xsi_set_current_line(88, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB185;

LAB182:    if (t22 != 0)
        goto LAB184;

LAB183:    *((unsigned int *)t10) = 1;

LAB185:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB189;

LAB187:    if (*((unsigned int *)t25) == 0)
        goto LAB186;

LAB188:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB189:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB190;

LAB191:
LAB192:    xsi_set_current_line(89, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB197;

LAB194:    if (t22 != 0)
        goto LAB196;

LAB195:    *((unsigned int *)t10) = 1;

LAB197:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB201;

LAB199:    if (*((unsigned int *)t11) == 0)
        goto LAB198;

LAB200:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB201:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB202;

LAB203:
LAB204:    xsi_set_current_line(91, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB206;
    t0 = 1;
    goto LAB1;

LAB184:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB185;

LAB186:    *((unsigned int *)t7) = 1;
    goto LAB189;

LAB190:    xsi_set_current_line(88, ng0);

LAB193:    xsi_set_current_line(88, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(88, ng0);
    xsi_vlog_finish(1);
    goto LAB192;

LAB196:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB197;

LAB198:    *((unsigned int *)t7) = 1;
    goto LAB201;

LAB202:    xsi_set_current_line(89, ng0);

LAB205:    xsi_set_current_line(89, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(89, ng0);
    xsi_vlog_finish(1);
    goto LAB204;

LAB206:    xsi_set_current_line(91, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB210;

LAB207:    if (t22 != 0)
        goto LAB209;

LAB208:    *((unsigned int *)t10) = 1;

LAB210:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB214;

LAB212:    if (*((unsigned int *)t25) == 0)
        goto LAB211;

LAB213:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB214:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB215;

LAB216:
LAB217:    xsi_set_current_line(92, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB222;

LAB219:    if (t22 != 0)
        goto LAB221;

LAB220:    *((unsigned int *)t10) = 1;

LAB222:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB226;

LAB224:    if (*((unsigned int *)t11) == 0)
        goto LAB223;

LAB225:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB226:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB227;

LAB228:
LAB229:    xsi_set_current_line(94, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB231;
    t0 = 1;
    goto LAB1;

LAB209:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB210;

LAB211:    *((unsigned int *)t7) = 1;
    goto LAB214;

LAB215:    xsi_set_current_line(91, ng0);

LAB218:    xsi_set_current_line(91, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(91, ng0);
    xsi_vlog_finish(1);
    goto LAB217;

LAB221:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB222;

LAB223:    *((unsigned int *)t7) = 1;
    goto LAB226;

LAB227:    xsi_set_current_line(92, ng0);

LAB230:    xsi_set_current_line(92, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(92, ng0);
    xsi_vlog_finish(1);
    goto LAB229;

LAB231:    xsi_set_current_line(94, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2548);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(96, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB235;

LAB232:    if (t22 != 0)
        goto LAB234;

LAB233:    *((unsigned int *)t10) = 1;

LAB235:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB239;

LAB237:    if (*((unsigned int *)t11) == 0)
        goto LAB236;

LAB238:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB239:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB240;

LAB241:
LAB242:    xsi_set_current_line(97, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB247;

LAB244:    if (t22 != 0)
        goto LAB246;

LAB245:    *((unsigned int *)t10) = 1;

LAB247:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB251;

LAB249:    if (*((unsigned int *)t11) == 0)
        goto LAB248;

LAB250:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB251:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB252;

LAB253:
LAB254:    xsi_set_current_line(99, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB256;
    t0 = 1;
    goto LAB1;

LAB234:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB235;

LAB236:    *((unsigned int *)t7) = 1;
    goto LAB239;

LAB240:    xsi_set_current_line(96, ng0);

LAB243:    xsi_set_current_line(96, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(96, ng0);
    xsi_vlog_finish(1);
    goto LAB242;

LAB246:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB247;

LAB248:    *((unsigned int *)t7) = 1;
    goto LAB251;

LAB252:    xsi_set_current_line(97, ng0);

LAB255:    xsi_set_current_line(97, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(97, ng0);
    xsi_vlog_finish(1);
    goto LAB254;

LAB256:    xsi_set_current_line(99, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB260;

LAB257:    if (t22 != 0)
        goto LAB259;

LAB258:    *((unsigned int *)t10) = 1;

LAB260:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB264;

LAB262:    if (*((unsigned int *)t25) == 0)
        goto LAB261;

LAB263:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB264:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB265;

LAB266:
LAB267:    xsi_set_current_line(100, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB272;

LAB269:    if (t22 != 0)
        goto LAB271;

LAB270:    *((unsigned int *)t10) = 1;

LAB272:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB276;

LAB274:    if (*((unsigned int *)t11) == 0)
        goto LAB273;

LAB275:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB276:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB277;

LAB278:
LAB279:    xsi_set_current_line(102, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB281;
    t0 = 1;
    goto LAB1;

LAB259:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB260;

LAB261:    *((unsigned int *)t7) = 1;
    goto LAB264;

LAB265:    xsi_set_current_line(99, ng0);

LAB268:    xsi_set_current_line(99, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(99, ng0);
    xsi_vlog_finish(1);
    goto LAB267;

LAB271:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB272;

LAB273:    *((unsigned int *)t7) = 1;
    goto LAB276;

LAB277:    xsi_set_current_line(100, ng0);

LAB280:    xsi_set_current_line(100, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(100, ng0);
    xsi_vlog_finish(1);
    goto LAB279;

LAB281:    xsi_set_current_line(102, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2548);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(104, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB285;

LAB282:    if (t22 != 0)
        goto LAB284;

LAB283:    *((unsigned int *)t10) = 1;

LAB285:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB289;

LAB287:    if (*((unsigned int *)t11) == 0)
        goto LAB286;

LAB288:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB289:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB290;

LAB291:
LAB292:    xsi_set_current_line(105, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB297;

LAB294:    if (t22 != 0)
        goto LAB296;

LAB295:    *((unsigned int *)t10) = 1;

LAB297:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB301;

LAB299:    if (*((unsigned int *)t11) == 0)
        goto LAB298;

LAB300:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB301:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB302;

LAB303:
LAB304:    xsi_set_current_line(107, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB306;
    t0 = 1;
    goto LAB1;

LAB284:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB285;

LAB286:    *((unsigned int *)t7) = 1;
    goto LAB289;

LAB290:    xsi_set_current_line(104, ng0);

LAB293:    xsi_set_current_line(104, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(104, ng0);
    xsi_vlog_finish(1);
    goto LAB292;

LAB296:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB297;

LAB298:    *((unsigned int *)t7) = 1;
    goto LAB301;

LAB302:    xsi_set_current_line(105, ng0);

LAB305:    xsi_set_current_line(105, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(105, ng0);
    xsi_vlog_finish(1);
    goto LAB304;

LAB306:    xsi_set_current_line(107, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB310;

LAB307:    if (t22 != 0)
        goto LAB309;

LAB308:    *((unsigned int *)t10) = 1;

LAB310:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB314;

LAB312:    if (*((unsigned int *)t25) == 0)
        goto LAB311;

LAB313:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB314:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB315;

LAB316:
LAB317:    xsi_set_current_line(108, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB322;

LAB319:    if (t22 != 0)
        goto LAB321;

LAB320:    *((unsigned int *)t10) = 1;

LAB322:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB326;

LAB324:    if (*((unsigned int *)t11) == 0)
        goto LAB323;

LAB325:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB326:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB327;

LAB328:
LAB329:    xsi_set_current_line(110, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB331;
    t0 = 1;
    goto LAB1;

LAB309:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB310;

LAB311:    *((unsigned int *)t7) = 1;
    goto LAB314;

LAB315:    xsi_set_current_line(107, ng0);

LAB318:    xsi_set_current_line(107, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(107, ng0);
    xsi_vlog_finish(1);
    goto LAB317;

LAB321:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB322;

LAB323:    *((unsigned int *)t7) = 1;
    goto LAB326;

LAB327:    xsi_set_current_line(108, ng0);

LAB330:    xsi_set_current_line(108, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(108, ng0);
    xsi_vlog_finish(1);
    goto LAB329;

LAB331:    xsi_set_current_line(110, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(112, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB335;

LAB332:    if (t22 != 0)
        goto LAB334;

LAB333:    *((unsigned int *)t10) = 1;

LAB335:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB339;

LAB337:    if (*((unsigned int *)t11) == 0)
        goto LAB336;

LAB338:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB339:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB340;

LAB341:
LAB342:    xsi_set_current_line(113, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB347;

LAB344:    if (t22 != 0)
        goto LAB346;

LAB345:    *((unsigned int *)t10) = 1;

LAB347:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB351;

LAB349:    if (*((unsigned int *)t11) == 0)
        goto LAB348;

LAB350:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB351:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB352;

LAB353:
LAB354:    xsi_set_current_line(115, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB356;
    t0 = 1;
    goto LAB1;

LAB334:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB335;

LAB336:    *((unsigned int *)t7) = 1;
    goto LAB339;

LAB340:    xsi_set_current_line(112, ng0);

LAB343:    xsi_set_current_line(112, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(112, ng0);
    xsi_vlog_finish(1);
    goto LAB342;

LAB346:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB347;

LAB348:    *((unsigned int *)t7) = 1;
    goto LAB351;

LAB352:    xsi_set_current_line(113, ng0);

LAB355:    xsi_set_current_line(113, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(113, ng0);
    xsi_vlog_finish(1);
    goto LAB354;

LAB356:    xsi_set_current_line(115, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB360;

LAB357:    if (t22 != 0)
        goto LAB359;

LAB358:    *((unsigned int *)t10) = 1;

LAB360:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB364;

LAB362:    if (*((unsigned int *)t25) == 0)
        goto LAB361;

LAB363:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB364:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB365;

LAB366:
LAB367:    xsi_set_current_line(116, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB372;

LAB369:    if (t22 != 0)
        goto LAB371;

LAB370:    *((unsigned int *)t10) = 1;

LAB372:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB376;

LAB374:    if (*((unsigned int *)t11) == 0)
        goto LAB373;

LAB375:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB376:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB377;

LAB378:
LAB379:    goto LAB4;

LAB359:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB360;

LAB361:    *((unsigned int *)t7) = 1;
    goto LAB364;

LAB365:    xsi_set_current_line(115, ng0);

LAB368:    xsi_set_current_line(115, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(115, ng0);
    xsi_vlog_finish(1);
    goto LAB367;

LAB371:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB372;

LAB373:    *((unsigned int *)t7) = 1;
    goto LAB376;

LAB377:    xsi_set_current_line(116, ng0);

LAB380:    xsi_set_current_line(116, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(116, ng0);
    xsi_vlog_finish(1);
    goto LAB379;

}

static int sp_testShortButtonPress(char *t1, char *t2)
{
    char t7[8];
    char t10[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    double t39;
    char *t41;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 996);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(122, ng0);

LAB5:    xsi_set_current_line(124, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(124, ng0);
    t8 = (t1 + 2228U);
    t9 = *((char **)t8);
    t8 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t11 = (t9 + 4);
    t12 = (t8 + 4);
    t13 = *((unsigned int *)t9);
    t14 = *((unsigned int *)t8);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t11);
    t21 = *((unsigned int *)t12);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB10;

LAB7:    if (t22 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t10) = 1;

LAB10:    memset(t7, 0, 8);
    t26 = (t10 + 4);
    t27 = *((unsigned int *)t26);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t26) == 0)
        goto LAB11;

LAB13:    t32 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t32) = 1;

LAB14:    t33 = (t7 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(125, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB22;

LAB19:    if (t22 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t10) = 1;

LAB22:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t11) == 0)
        goto LAB23;

LAB25:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB26:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(127, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB31;
    t0 = 1;
    goto LAB1;

LAB9:    t25 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(124, ng0);

LAB18:    xsi_set_current_line(124, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t41 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t41, (char)114, t40, 64);
    xsi_set_current_line(124, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(125, ng0);

LAB30:    xsi_set_current_line(125, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(125, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(127, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(129, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB35;

LAB32:    if (t22 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t10) = 1;

LAB35:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB39;

LAB37:    if (*((unsigned int *)t11) == 0)
        goto LAB36;

LAB38:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB39:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(130, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB47;

LAB44:    if (t22 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t10) = 1;

LAB47:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB51;

LAB49:    if (*((unsigned int *)t11) == 0)
        goto LAB48;

LAB50:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB51:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(132, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB56;
    t0 = 1;
    goto LAB1;

LAB34:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB35;

LAB36:    *((unsigned int *)t7) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(129, ng0);

LAB43:    xsi_set_current_line(129, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(129, ng0);
    xsi_vlog_finish(1);
    goto LAB42;

LAB46:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t7) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(130, ng0);

LAB55:    xsi_set_current_line(130, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(130, ng0);
    xsi_vlog_finish(1);
    goto LAB54;

LAB56:    xsi_set_current_line(132, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng4)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB60;

LAB57:    if (t22 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t10) = 1;

LAB60:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB64;

LAB62:    if (*((unsigned int *)t25) == 0)
        goto LAB61;

LAB63:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB64:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(133, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB72;

LAB69:    if (t22 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t10) = 1;

LAB72:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB76;

LAB74:    if (*((unsigned int *)t11) == 0)
        goto LAB73;

LAB75:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB76:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(135, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB81;
    t0 = 1;
    goto LAB1;

LAB59:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB60;

LAB61:    *((unsigned int *)t7) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(132, ng0);

LAB68:    xsi_set_current_line(132, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(132, ng0);
    xsi_vlog_finish(1);
    goto LAB67;

LAB71:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t7) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(133, ng0);

LAB80:    xsi_set_current_line(133, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(133, ng0);
    xsi_vlog_finish(1);
    goto LAB79;

LAB81:    xsi_set_current_line(135, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng5)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB85;

LAB82:    if (t22 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t10) = 1;

LAB85:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB89;

LAB87:    if (*((unsigned int *)t25) == 0)
        goto LAB86;

LAB88:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB89:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB90;

LAB91:
LAB92:    xsi_set_current_line(136, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB97;

LAB94:    if (t22 != 0)
        goto LAB96;

LAB95:    *((unsigned int *)t10) = 1;

LAB97:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB101;

LAB99:    if (*((unsigned int *)t11) == 0)
        goto LAB98;

LAB100:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB101:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB102;

LAB103:
LAB104:    xsi_set_current_line(138, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB106;
    t0 = 1;
    goto LAB1;

LAB84:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t7) = 1;
    goto LAB89;

LAB90:    xsi_set_current_line(135, ng0);

LAB93:    xsi_set_current_line(135, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(135, ng0);
    xsi_vlog_finish(1);
    goto LAB92;

LAB96:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB97;

LAB98:    *((unsigned int *)t7) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(136, ng0);

LAB105:    xsi_set_current_line(136, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(136, ng0);
    xsi_vlog_finish(1);
    goto LAB104;

LAB106:    xsi_set_current_line(138, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng6)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB110;

LAB107:    if (t22 != 0)
        goto LAB109;

LAB108:    *((unsigned int *)t10) = 1;

LAB110:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB114;

LAB112:    if (*((unsigned int *)t25) == 0)
        goto LAB111;

LAB113:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB114:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB115;

LAB116:
LAB117:    xsi_set_current_line(139, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB122;

LAB119:    if (t22 != 0)
        goto LAB121;

LAB120:    *((unsigned int *)t10) = 1;

LAB122:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB126;

LAB124:    if (*((unsigned int *)t11) == 0)
        goto LAB123;

LAB125:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB126:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB127;

LAB128:
LAB129:    xsi_set_current_line(141, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB131;
    t0 = 1;
    goto LAB1;

LAB109:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB110;

LAB111:    *((unsigned int *)t7) = 1;
    goto LAB114;

LAB115:    xsi_set_current_line(138, ng0);

LAB118:    xsi_set_current_line(138, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(138, ng0);
    xsi_vlog_finish(1);
    goto LAB117;

LAB121:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB122;

LAB123:    *((unsigned int *)t7) = 1;
    goto LAB126;

LAB127:    xsi_set_current_line(139, ng0);

LAB130:    xsi_set_current_line(139, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(139, ng0);
    xsi_vlog_finish(1);
    goto LAB129;

LAB131:    xsi_set_current_line(141, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB135;

LAB132:    if (t22 != 0)
        goto LAB134;

LAB133:    *((unsigned int *)t10) = 1;

LAB135:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB139;

LAB137:    if (*((unsigned int *)t25) == 0)
        goto LAB136;

LAB138:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB139:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB140;

LAB141:
LAB142:    xsi_set_current_line(142, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB147;

LAB144:    if (t22 != 0)
        goto LAB146;

LAB145:    *((unsigned int *)t10) = 1;

LAB147:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB151;

LAB149:    if (*((unsigned int *)t11) == 0)
        goto LAB148;

LAB150:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB151:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB152;

LAB153:
LAB154:    xsi_set_current_line(144, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB156;
    t0 = 1;
    goto LAB1;

LAB134:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB135;

LAB136:    *((unsigned int *)t7) = 1;
    goto LAB139;

LAB140:    xsi_set_current_line(141, ng0);

LAB143:    xsi_set_current_line(141, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(141, ng0);
    xsi_vlog_finish(1);
    goto LAB142;

LAB146:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB147;

LAB148:    *((unsigned int *)t7) = 1;
    goto LAB151;

LAB152:    xsi_set_current_line(142, ng0);

LAB155:    xsi_set_current_line(142, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(142, ng0);
    xsi_vlog_finish(1);
    goto LAB154;

LAB156:    xsi_set_current_line(144, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(146, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB160;

LAB157:    if (t22 != 0)
        goto LAB159;

LAB158:    *((unsigned int *)t10) = 1;

LAB160:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB164;

LAB162:    if (*((unsigned int *)t11) == 0)
        goto LAB161;

LAB163:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB164:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB165;

LAB166:
LAB167:    xsi_set_current_line(147, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB172;

LAB169:    if (t22 != 0)
        goto LAB171;

LAB170:    *((unsigned int *)t10) = 1;

LAB172:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB176;

LAB174:    if (*((unsigned int *)t11) == 0)
        goto LAB173;

LAB175:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB176:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB177;

LAB178:
LAB179:    xsi_set_current_line(149, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB181;
    t0 = 1;
    goto LAB1;

LAB159:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB160;

LAB161:    *((unsigned int *)t7) = 1;
    goto LAB164;

LAB165:    xsi_set_current_line(146, ng0);

LAB168:    xsi_set_current_line(146, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(146, ng0);
    xsi_vlog_finish(1);
    goto LAB167;

LAB171:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB172;

LAB173:    *((unsigned int *)t7) = 1;
    goto LAB176;

LAB177:    xsi_set_current_line(147, ng0);

LAB180:    xsi_set_current_line(147, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(147, ng0);
    xsi_vlog_finish(1);
    goto LAB179;

LAB181:    xsi_set_current_line(149, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB185;

LAB182:    if (t22 != 0)
        goto LAB184;

LAB183:    *((unsigned int *)t10) = 1;

LAB185:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB189;

LAB187:    if (*((unsigned int *)t25) == 0)
        goto LAB186;

LAB188:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB189:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB190;

LAB191:
LAB192:    xsi_set_current_line(150, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB197;

LAB194:    if (t22 != 0)
        goto LAB196;

LAB195:    *((unsigned int *)t10) = 1;

LAB197:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB201;

LAB199:    if (*((unsigned int *)t11) == 0)
        goto LAB198;

LAB200:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB201:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB202;

LAB203:
LAB204:    xsi_set_current_line(152, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB206;
    t0 = 1;
    goto LAB1;

LAB184:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB185;

LAB186:    *((unsigned int *)t7) = 1;
    goto LAB189;

LAB190:    xsi_set_current_line(149, ng0);

LAB193:    xsi_set_current_line(149, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(149, ng0);
    xsi_vlog_finish(1);
    goto LAB192;

LAB196:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB197;

LAB198:    *((unsigned int *)t7) = 1;
    goto LAB201;

LAB202:    xsi_set_current_line(150, ng0);

LAB205:    xsi_set_current_line(150, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(150, ng0);
    xsi_vlog_finish(1);
    goto LAB204;

LAB206:    xsi_set_current_line(152, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2548);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(154, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng7)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB210;

LAB207:    if (t22 != 0)
        goto LAB209;

LAB208:    *((unsigned int *)t10) = 1;

LAB210:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB214;

LAB212:    if (*((unsigned int *)t11) == 0)
        goto LAB211;

LAB213:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB214:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB215;

LAB216:
LAB217:    xsi_set_current_line(155, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB222;

LAB219:    if (t22 != 0)
        goto LAB221;

LAB220:    *((unsigned int *)t10) = 1;

LAB222:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB226;

LAB224:    if (*((unsigned int *)t11) == 0)
        goto LAB223;

LAB225:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB226:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB227;

LAB228:
LAB229:    xsi_set_current_line(157, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB231;
    t0 = 1;
    goto LAB1;

LAB209:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB210;

LAB211:    *((unsigned int *)t7) = 1;
    goto LAB214;

LAB215:    xsi_set_current_line(154, ng0);

LAB218:    xsi_set_current_line(154, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(154, ng0);
    xsi_vlog_finish(1);
    goto LAB217;

LAB221:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB222;

LAB223:    *((unsigned int *)t7) = 1;
    goto LAB226;

LAB227:    xsi_set_current_line(155, ng0);

LAB230:    xsi_set_current_line(155, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(155, ng0);
    xsi_vlog_finish(1);
    goto LAB229;

LAB231:    xsi_set_current_line(157, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB235;

LAB232:    if (t22 != 0)
        goto LAB234;

LAB233:    *((unsigned int *)t10) = 1;

LAB235:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB239;

LAB237:    if (*((unsigned int *)t25) == 0)
        goto LAB236;

LAB238:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB239:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB240;

LAB241:
LAB242:    xsi_set_current_line(158, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB247;

LAB244:    if (t22 != 0)
        goto LAB246;

LAB245:    *((unsigned int *)t10) = 1;

LAB247:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB251;

LAB249:    if (*((unsigned int *)t11) == 0)
        goto LAB248;

LAB250:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB251:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB252;

LAB253:
LAB254:    xsi_set_current_line(160, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB256;
    t0 = 1;
    goto LAB1;

LAB234:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB235;

LAB236:    *((unsigned int *)t7) = 1;
    goto LAB239;

LAB240:    xsi_set_current_line(157, ng0);

LAB243:    xsi_set_current_line(157, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(157, ng0);
    xsi_vlog_finish(1);
    goto LAB242;

LAB246:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB247;

LAB248:    *((unsigned int *)t7) = 1;
    goto LAB251;

LAB252:    xsi_set_current_line(158, ng0);

LAB255:    xsi_set_current_line(158, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(158, ng0);
    xsi_vlog_finish(1);
    goto LAB254;

LAB256:    xsi_set_current_line(160, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2548);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(162, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB260;

LAB257:    if (t22 != 0)
        goto LAB259;

LAB258:    *((unsigned int *)t10) = 1;

LAB260:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB264;

LAB262:    if (*((unsigned int *)t11) == 0)
        goto LAB261;

LAB263:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB264:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB265;

LAB266:
LAB267:    xsi_set_current_line(163, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB272;

LAB269:    if (t22 != 0)
        goto LAB271;

LAB270:    *((unsigned int *)t10) = 1;

LAB272:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB276;

LAB274:    if (*((unsigned int *)t11) == 0)
        goto LAB273;

LAB275:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB276:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB277;

LAB278:
LAB279:    xsi_set_current_line(165, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB281;
    t0 = 1;
    goto LAB1;

LAB259:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB260;

LAB261:    *((unsigned int *)t7) = 1;
    goto LAB264;

LAB265:    xsi_set_current_line(162, ng0);

LAB268:    xsi_set_current_line(162, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(162, ng0);
    xsi_vlog_finish(1);
    goto LAB267;

LAB271:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB272;

LAB273:    *((unsigned int *)t7) = 1;
    goto LAB276;

LAB277:    xsi_set_current_line(163, ng0);

LAB280:    xsi_set_current_line(163, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(163, ng0);
    xsi_vlog_finish(1);
    goto LAB279;

LAB281:    xsi_set_current_line(165, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB285;

LAB282:    if (t22 != 0)
        goto LAB284;

LAB283:    *((unsigned int *)t10) = 1;

LAB285:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB289;

LAB287:    if (*((unsigned int *)t25) == 0)
        goto LAB286;

LAB288:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB289:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB290;

LAB291:
LAB292:    xsi_set_current_line(166, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB297;

LAB294:    if (t22 != 0)
        goto LAB296;

LAB295:    *((unsigned int *)t10) = 1;

LAB297:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB301;

LAB299:    if (*((unsigned int *)t11) == 0)
        goto LAB298;

LAB300:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB301:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB302;

LAB303:
LAB304:    goto LAB4;

LAB284:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB285;

LAB286:    *((unsigned int *)t7) = 1;
    goto LAB289;

LAB290:    xsi_set_current_line(165, ng0);

LAB293:    xsi_set_current_line(165, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(165, ng0);
    xsi_vlog_finish(1);
    goto LAB292;

LAB296:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB297;

LAB298:    *((unsigned int *)t7) = 1;
    goto LAB301;

LAB302:    xsi_set_current_line(166, ng0);

LAB305:    xsi_set_current_line(166, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 996);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(166, ng0);
    xsi_vlog_finish(1);
    goto LAB304;

}

static int sp_testShortButtonBounce(char *t1, char *t2)
{
    char t7[8];
    char t10[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    double t39;
    char *t41;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1252);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(172, ng0);

LAB5:    xsi_set_current_line(174, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(174, ng0);
    t8 = (t1 + 2228U);
    t9 = *((char **)t8);
    t8 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t11 = (t9 + 4);
    t12 = (t8 + 4);
    t13 = *((unsigned int *)t9);
    t14 = *((unsigned int *)t8);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t11);
    t21 = *((unsigned int *)t12);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB10;

LAB7:    if (t22 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t10) = 1;

LAB10:    memset(t7, 0, 8);
    t26 = (t10 + 4);
    t27 = *((unsigned int *)t26);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t26) == 0)
        goto LAB11;

LAB13:    t32 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t32) = 1;

LAB14:    t33 = (t7 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(175, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB22;

LAB19:    if (t22 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t10) = 1;

LAB22:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t11) == 0)
        goto LAB23;

LAB25:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB26:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(177, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB31;
    t0 = 1;
    goto LAB1;

LAB9:    t25 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(174, ng0);

LAB18:    xsi_set_current_line(174, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t41 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t41, (char)114, t40, 64);
    xsi_set_current_line(174, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(175, ng0);

LAB30:    xsi_set_current_line(175, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(175, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(177, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(179, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB35;

LAB32:    if (t22 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t10) = 1;

LAB35:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB39;

LAB37:    if (*((unsigned int *)t11) == 0)
        goto LAB36;

LAB38:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB39:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(180, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB47;

LAB44:    if (t22 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t10) = 1;

LAB47:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB51;

LAB49:    if (*((unsigned int *)t11) == 0)
        goto LAB48;

LAB50:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB51:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(182, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB56;
    t0 = 1;
    goto LAB1;

LAB34:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB35;

LAB36:    *((unsigned int *)t7) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(179, ng0);

LAB43:    xsi_set_current_line(179, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(179, ng0);
    xsi_vlog_finish(1);
    goto LAB42;

LAB46:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t7) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(180, ng0);

LAB55:    xsi_set_current_line(180, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(180, ng0);
    xsi_vlog_finish(1);
    goto LAB54;

LAB56:    xsi_set_current_line(182, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng4)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB60;

LAB57:    if (t22 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t10) = 1;

LAB60:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB64;

LAB62:    if (*((unsigned int *)t25) == 0)
        goto LAB61;

LAB63:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB64:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(183, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB72;

LAB69:    if (t22 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t10) = 1;

LAB72:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB76;

LAB74:    if (*((unsigned int *)t11) == 0)
        goto LAB73;

LAB75:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB76:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(185, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB81;
    t0 = 1;
    goto LAB1;

LAB59:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB60;

LAB61:    *((unsigned int *)t7) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(182, ng0);

LAB68:    xsi_set_current_line(182, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(182, ng0);
    xsi_vlog_finish(1);
    goto LAB67;

LAB71:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t7) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(183, ng0);

LAB80:    xsi_set_current_line(183, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(183, ng0);
    xsi_vlog_finish(1);
    goto LAB79;

LAB81:    xsi_set_current_line(185, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng5)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB85;

LAB82:    if (t22 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t10) = 1;

LAB85:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB89;

LAB87:    if (*((unsigned int *)t25) == 0)
        goto LAB86;

LAB88:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB89:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB90;

LAB91:
LAB92:    xsi_set_current_line(186, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB97;

LAB94:    if (t22 != 0)
        goto LAB96;

LAB95:    *((unsigned int *)t10) = 1;

LAB97:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB101;

LAB99:    if (*((unsigned int *)t11) == 0)
        goto LAB98;

LAB100:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB101:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB102;

LAB103:
LAB104:    xsi_set_current_line(188, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB106;
    t0 = 1;
    goto LAB1;

LAB84:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t7) = 1;
    goto LAB89;

LAB90:    xsi_set_current_line(185, ng0);

LAB93:    xsi_set_current_line(185, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(185, ng0);
    xsi_vlog_finish(1);
    goto LAB92;

LAB96:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB97;

LAB98:    *((unsigned int *)t7) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(186, ng0);

LAB105:    xsi_set_current_line(186, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(186, ng0);
    xsi_vlog_finish(1);
    goto LAB104;

LAB106:    xsi_set_current_line(188, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(190, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng6)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB110;

LAB107:    if (t22 != 0)
        goto LAB109;

LAB108:    *((unsigned int *)t10) = 1;

LAB110:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB114;

LAB112:    if (*((unsigned int *)t11) == 0)
        goto LAB111;

LAB113:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB114:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB115;

LAB116:
LAB117:    xsi_set_current_line(191, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB122;

LAB119:    if (t22 != 0)
        goto LAB121;

LAB120:    *((unsigned int *)t10) = 1;

LAB122:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB126;

LAB124:    if (*((unsigned int *)t11) == 0)
        goto LAB123;

LAB125:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB126:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB127;

LAB128:
LAB129:    xsi_set_current_line(193, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB131;
    t0 = 1;
    goto LAB1;

LAB109:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB110;

LAB111:    *((unsigned int *)t7) = 1;
    goto LAB114;

LAB115:    xsi_set_current_line(190, ng0);

LAB118:    xsi_set_current_line(190, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(190, ng0);
    xsi_vlog_finish(1);
    goto LAB117;

LAB121:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB122;

LAB123:    *((unsigned int *)t7) = 1;
    goto LAB126;

LAB127:    xsi_set_current_line(191, ng0);

LAB130:    xsi_set_current_line(191, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(191, ng0);
    xsi_vlog_finish(1);
    goto LAB129;

LAB131:    xsi_set_current_line(193, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB135;

LAB132:    if (t22 != 0)
        goto LAB134;

LAB133:    *((unsigned int *)t10) = 1;

LAB135:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB139;

LAB137:    if (*((unsigned int *)t25) == 0)
        goto LAB136;

LAB138:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB139:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB140;

LAB141:
LAB142:    xsi_set_current_line(194, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB147;

LAB144:    if (t22 != 0)
        goto LAB146;

LAB145:    *((unsigned int *)t10) = 1;

LAB147:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB151;

LAB149:    if (*((unsigned int *)t11) == 0)
        goto LAB148;

LAB150:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB151:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB152;

LAB153:
LAB154:    goto LAB4;

LAB134:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB135;

LAB136:    *((unsigned int *)t7) = 1;
    goto LAB139;

LAB140:    xsi_set_current_line(193, ng0);

LAB143:    xsi_set_current_line(193, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(193, ng0);
    xsi_vlog_finish(1);
    goto LAB142;

LAB146:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB147;

LAB148:    *((unsigned int *)t7) = 1;
    goto LAB151;

LAB152:    xsi_set_current_line(194, ng0);

LAB155:    xsi_set_current_line(194, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1252);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(194, ng0);
    xsi_vlog_finish(1);
    goto LAB154;

}

static int sp_testShorterButtonBounce(char *t1, char *t2)
{
    char t7[8];
    char t10[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    double t39;
    char *t41;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1508);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(200, ng0);

LAB5:    xsi_set_current_line(202, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(202, ng0);
    t8 = (t1 + 2228U);
    t9 = *((char **)t8);
    t8 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t11 = (t9 + 4);
    t12 = (t8 + 4);
    t13 = *((unsigned int *)t9);
    t14 = *((unsigned int *)t8);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t11);
    t21 = *((unsigned int *)t12);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB10;

LAB7:    if (t22 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t10) = 1;

LAB10:    memset(t7, 0, 8);
    t26 = (t10 + 4);
    t27 = *((unsigned int *)t26);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t26) == 0)
        goto LAB11;

LAB13:    t32 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t32) = 1;

LAB14:    t33 = (t7 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(203, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB22;

LAB19:    if (t22 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t10) = 1;

LAB22:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t11) == 0)
        goto LAB23;

LAB25:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB26:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(205, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB31;
    t0 = 1;
    goto LAB1;

LAB9:    t25 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(202, ng0);

LAB18:    xsi_set_current_line(202, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t41 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t41, (char)114, t40, 64);
    xsi_set_current_line(202, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(203, ng0);

LAB30:    xsi_set_current_line(203, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(203, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(205, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(207, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB35;

LAB32:    if (t22 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t10) = 1;

LAB35:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB39;

LAB37:    if (*((unsigned int *)t11) == 0)
        goto LAB36;

LAB38:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB39:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(208, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB47;

LAB44:    if (t22 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t10) = 1;

LAB47:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB51;

LAB49:    if (*((unsigned int *)t11) == 0)
        goto LAB48;

LAB50:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB51:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(210, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB56;
    t0 = 1;
    goto LAB1;

LAB34:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB35;

LAB36:    *((unsigned int *)t7) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(207, ng0);

LAB43:    xsi_set_current_line(207, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(207, ng0);
    xsi_vlog_finish(1);
    goto LAB42;

LAB46:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t7) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(208, ng0);

LAB55:    xsi_set_current_line(208, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(208, ng0);
    xsi_vlog_finish(1);
    goto LAB54;

LAB56:    xsi_set_current_line(210, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng4)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB60;

LAB57:    if (t22 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t10) = 1;

LAB60:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB64;

LAB62:    if (*((unsigned int *)t25) == 0)
        goto LAB61;

LAB63:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB64:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(211, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB72;

LAB69:    if (t22 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t10) = 1;

LAB72:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB76;

LAB74:    if (*((unsigned int *)t11) == 0)
        goto LAB73;

LAB75:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB76:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(213, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB81;
    t0 = 1;
    goto LAB1;

LAB59:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB60;

LAB61:    *((unsigned int *)t7) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(210, ng0);

LAB68:    xsi_set_current_line(210, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(210, ng0);
    xsi_vlog_finish(1);
    goto LAB67;

LAB71:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t7) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(211, ng0);

LAB80:    xsi_set_current_line(211, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(211, ng0);
    xsi_vlog_finish(1);
    goto LAB79;

LAB81:    xsi_set_current_line(213, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(215, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng5)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB85;

LAB82:    if (t22 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t10) = 1;

LAB85:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB89;

LAB87:    if (*((unsigned int *)t11) == 0)
        goto LAB86;

LAB88:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB89:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB90;

LAB91:
LAB92:    xsi_set_current_line(216, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB97;

LAB94:    if (t22 != 0)
        goto LAB96;

LAB95:    *((unsigned int *)t10) = 1;

LAB97:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB101;

LAB99:    if (*((unsigned int *)t11) == 0)
        goto LAB98;

LAB100:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB101:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB102;

LAB103:
LAB104:    xsi_set_current_line(218, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB106;
    t0 = 1;
    goto LAB1;

LAB84:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t7) = 1;
    goto LAB89;

LAB90:    xsi_set_current_line(215, ng0);

LAB93:    xsi_set_current_line(215, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(215, ng0);
    xsi_vlog_finish(1);
    goto LAB92;

LAB96:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB97;

LAB98:    *((unsigned int *)t7) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(216, ng0);

LAB105:    xsi_set_current_line(216, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(216, ng0);
    xsi_vlog_finish(1);
    goto LAB104;

LAB106:    xsi_set_current_line(218, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB110;

LAB107:    if (t22 != 0)
        goto LAB109;

LAB108:    *((unsigned int *)t10) = 1;

LAB110:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB114;

LAB112:    if (*((unsigned int *)t25) == 0)
        goto LAB111;

LAB113:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB114:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB115;

LAB116:
LAB117:    xsi_set_current_line(219, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB122;

LAB119:    if (t22 != 0)
        goto LAB121;

LAB120:    *((unsigned int *)t10) = 1;

LAB122:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB126;

LAB124:    if (*((unsigned int *)t11) == 0)
        goto LAB123;

LAB125:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB126:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB127;

LAB128:
LAB129:    goto LAB4;

LAB109:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB110;

LAB111:    *((unsigned int *)t7) = 1;
    goto LAB114;

LAB115:    xsi_set_current_line(218, ng0);

LAB118:    xsi_set_current_line(218, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(218, ng0);
    xsi_vlog_finish(1);
    goto LAB117;

LAB121:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB122;

LAB123:    *((unsigned int *)t7) = 1;
    goto LAB126;

LAB127:    xsi_set_current_line(219, ng0);

LAB130:    xsi_set_current_line(219, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1508);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(219, ng0);
    xsi_vlog_finish(1);
    goto LAB129;

}

static int sp_testShortestButtonBounce(char *t1, char *t2)
{
    char t7[8];
    char t10[8];
    char t40[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    double t39;
    char *t41;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1764);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(226, ng0);

LAB5:    xsi_set_current_line(228, ng0);
    t5 = (t2 + 32U);
    t6 = *((char **)t5);
    xsi_process_wait(t6, 2000000LL);
    *((char **)t3) = &&LAB6;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(228, ng0);
    t8 = (t1 + 2228U);
    t9 = *((char **)t8);
    t8 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t11 = (t9 + 4);
    t12 = (t8 + 4);
    t13 = *((unsigned int *)t9);
    t14 = *((unsigned int *)t8);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t11);
    t17 = *((unsigned int *)t12);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t11);
    t21 = *((unsigned int *)t12);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB10;

LAB7:    if (t22 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t10) = 1;

LAB10:    memset(t7, 0, 8);
    t26 = (t10 + 4);
    t27 = *((unsigned int *)t26);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t26) == 0)
        goto LAB11;

LAB13:    t32 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t32) = 1;

LAB14:    t33 = (t7 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(229, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB22;

LAB19:    if (t22 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t10) = 1;

LAB22:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t11) == 0)
        goto LAB23;

LAB25:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB26:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(231, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB31;
    t0 = 1;
    goto LAB1;

LAB9:    t25 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t25) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(228, ng0);

LAB18:    xsi_set_current_line(228, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t41 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t41, (char)114, t40, 64);
    xsi_set_current_line(228, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(229, ng0);

LAB30:    xsi_set_current_line(229, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(229, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(231, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(233, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB35;

LAB32:    if (t22 != 0)
        goto LAB34;

LAB33:    *((unsigned int *)t10) = 1;

LAB35:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB39;

LAB37:    if (*((unsigned int *)t11) == 0)
        goto LAB36;

LAB38:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB39:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(234, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB47;

LAB44:    if (t22 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t10) = 1;

LAB47:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB51;

LAB49:    if (*((unsigned int *)t11) == 0)
        goto LAB48;

LAB50:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB51:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB52;

LAB53:
LAB54:    xsi_set_current_line(236, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB56;
    t0 = 1;
    goto LAB1;

LAB34:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB35;

LAB36:    *((unsigned int *)t7) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(233, ng0);

LAB43:    xsi_set_current_line(233, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(233, ng0);
    xsi_vlog_finish(1);
    goto LAB42;

LAB46:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t7) = 1;
    goto LAB51;

LAB52:    xsi_set_current_line(234, ng0);

LAB55:    xsi_set_current_line(234, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(234, ng0);
    xsi_vlog_finish(1);
    goto LAB54;

LAB56:    xsi_set_current_line(236, ng0);
    t6 = ((char*)((ng2)));
    t8 = (t1 + 2456);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 1);
    xsi_set_current_line(237, ng0);
    t4 = (t1 + 2228U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng4)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB60;

LAB57:    if (t22 != 0)
        goto LAB59;

LAB58:    *((unsigned int *)t10) = 1;

LAB60:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB64;

LAB62:    if (*((unsigned int *)t11) == 0)
        goto LAB61;

LAB63:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB64:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(238, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB72;

LAB69:    if (t22 != 0)
        goto LAB71;

LAB70:    *((unsigned int *)t10) = 1;

LAB72:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB76;

LAB74:    if (*((unsigned int *)t11) == 0)
        goto LAB73;

LAB75:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB76:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB77;

LAB78:
LAB79:    xsi_set_current_line(240, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000000LL);
    *((char **)t3) = &&LAB81;
    t0 = 1;
    goto LAB1;

LAB59:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB60;

LAB61:    *((unsigned int *)t7) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(237, ng0);

LAB68:    xsi_set_current_line(237, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(237, ng0);
    xsi_vlog_finish(1);
    goto LAB67;

LAB71:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB72;

LAB73:    *((unsigned int *)t7) = 1;
    goto LAB76;

LAB77:    xsi_set_current_line(238, ng0);

LAB80:    xsi_set_current_line(238, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(238, ng0);
    xsi_vlog_finish(1);
    goto LAB79;

LAB81:    xsi_set_current_line(240, ng0);
    t6 = (t1 + 2228U);
    t8 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t10, 0, 8);
    t9 = (t8 + 4);
    t11 = (t6 + 4);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t6);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t9);
    t17 = *((unsigned int *)t11);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t9);
    t21 = *((unsigned int *)t11);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB85;

LAB82:    if (t22 != 0)
        goto LAB84;

LAB83:    *((unsigned int *)t10) = 1;

LAB85:    memset(t7, 0, 8);
    t25 = (t10 + 4);
    t27 = *((unsigned int *)t25);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB89;

LAB87:    if (*((unsigned int *)t25) == 0)
        goto LAB86;

LAB88:    t26 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t26) = 1;

LAB89:    t32 = (t7 + 4);
    t34 = *((unsigned int *)t32);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB90;

LAB91:
LAB92:    xsi_set_current_line(241, ng0);
    t4 = (t1 + 2136U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t10, 0, 8);
    t6 = (t5 + 4);
    t8 = (t4 + 4);
    t13 = *((unsigned int *)t5);
    t14 = *((unsigned int *)t4);
    t15 = (t13 ^ t14);
    t16 = *((unsigned int *)t6);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    t19 = (t15 | t18);
    t20 = *((unsigned int *)t6);
    t21 = *((unsigned int *)t8);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB97;

LAB94:    if (t22 != 0)
        goto LAB96;

LAB95:    *((unsigned int *)t10) = 1;

LAB97:    memset(t7, 0, 8);
    t11 = (t10 + 4);
    t27 = *((unsigned int *)t11);
    t28 = (~(t27));
    t29 = *((unsigned int *)t10);
    t30 = (t29 & t28);
    t31 = (t30 & 1U);
    if (t31 != 0)
        goto LAB101;

LAB99:    if (*((unsigned int *)t11) == 0)
        goto LAB98;

LAB100:    t12 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t12) = 1;

LAB101:    t25 = (t7 + 4);
    t34 = *((unsigned int *)t25);
    t35 = (~(t34));
    t36 = *((unsigned int *)t7);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB102;

LAB103:
LAB104:    goto LAB4;

LAB84:    t12 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB85;

LAB86:    *((unsigned int *)t7) = 1;
    goto LAB89;

LAB90:    xsi_set_current_line(240, ng0);

LAB93:    xsi_set_current_line(240, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t33 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t33, (char)114, t40, 64);
    xsi_set_current_line(240, ng0);
    xsi_vlog_finish(1);
    goto LAB92;

LAB96:    t9 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB97;

LAB98:    *((unsigned int *)t7) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(241, ng0);

LAB105:    xsi_set_current_line(241, ng0);
    t39 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t40) = t39;
    t26 = (t1 + 1764);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t26, (char)114, t40, 64);
    xsi_set_current_line(241, ng0);
    xsi_vlog_finish(1);
    goto LAB104;

}

static void NetDecl_13_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;

LAB0:    t1 = (t0 + 3256U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(13, ng0);
    t2 = (t0 + 6060);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 36U);
    t5 = *((char **)t4);
    t6 = (t0 + 3784);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memset(t10, 0, 8);
    t11 = 7U;
    t12 = t11;
    t13 = (t5 + 4);
    t14 = *((unsigned int *)t5);
    t11 = (t11 & t14);
    t15 = *((unsigned int *)t13);
    t12 = (t12 & t15);
    t16 = (t10 + 4);
    t17 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t17 | t11);
    t18 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t18 | t12);
    xsi_driver_vfirst_trans(t6, 0, 2U);
    t19 = (t0 + 3740);
    *((int *)t19) = 1;

LAB1:    return;
}

static void Always_26_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 3400U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 3300);
    xsi_process_wait(t2, 1000000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(26, ng0);
    t4 = (t0 + 2640);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 2640);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

}

static void Initial_28_2(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    double t19;

LAB0:    t1 = (t0 + 3544U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);

LAB4:    xsi_set_current_line(31, ng0);
    xsi_vlog_printtimescale(ng8, t0, ng9);
    xsi_set_current_line(32, ng0);
    t2 = ((char*)((ng10)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng11)));
    t5 = ((char*)((ng11)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng12, 0, *((unsigned int *)t5));
    xsi_set_current_line(35, ng0);
    t2 = ((char*)((ng2)));
    t4 = (t0 + 2456);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng2)));
    t4 = (t0 + 2548);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(37, ng0);
    t2 = ((char*)((ng2)));
    t4 = (t0 + 2640);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng2)));
    t4 = (t0 + 2732);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(40, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 484);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB7:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB9:    if (t14 != 0)
        goto LAB10;

LAB5:    t7 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t7);

LAB6:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 484);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(41, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 740);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB13:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB15:    if (t14 != 0)
        goto LAB16;

LAB11:    t7 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t7);

LAB12:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 740);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(42, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 996);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB19:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB21:    if (t14 != 0)
        goto LAB22;

LAB17:    t7 = (t0 + 996);
    xsi_vlog_subprogram_popinvocation(t7);

LAB18:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 996);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(43, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 1252);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB25:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB27:    if (t14 != 0)
        goto LAB28;

LAB23:    t7 = (t0 + 1252);
    xsi_vlog_subprogram_popinvocation(t7);

LAB24:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 1252);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(44, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 1508);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB31:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB33:    if (t14 != 0)
        goto LAB34;

LAB29:    t7 = (t0 + 1508);
    xsi_vlog_subprogram_popinvocation(t7);

LAB30:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 1508);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 3444);
    t4 = (t0 + 1764);
    t5 = xsi_create_subprogram_invocation(t2, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);

LAB37:    t6 = (t0 + 3496);
    t7 = *((char **)t6);
    t8 = (t7 + 44U);
    t9 = *((char **)t8);
    t10 = (t9 + 148U);
    t11 = *((char **)t10);
    t12 = (t11 + 0U);
    t13 = *((char **)t12);
    t14 = ((int  (*)(char *, char *))t13)(t0, t7);

LAB39:    if (t14 != 0)
        goto LAB40;

LAB35:    t7 = (t0 + 1764);
    xsi_vlog_subprogram_popinvocation(t7);

LAB36:    t15 = (t0 + 3496);
    t16 = *((char **)t15);
    t15 = (t0 + 1764);
    t17 = (t0 + 3444);
    t18 = 0;
    xsi_delete_subprogram_invocation(t15, t16, t0, t17, t18);
    xsi_set_current_line(47, ng0);
    t19 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t3) = t19;
    xsi_vlogfile_write(0, 0, 1, ng13, 2, t0, (char)114, t3, 64);
    xsi_set_current_line(48, ng0);
    xsi_vlog_finish(1);

LAB1:    return;
LAB8:;
LAB10:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB7;
    goto LAB1;

LAB14:;
LAB16:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB13;
    goto LAB1;

LAB20:;
LAB22:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB19;
    goto LAB1;

LAB26:;
LAB28:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB25;
    goto LAB1;

LAB32:;
LAB34:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB31;
    goto LAB1;

LAB38:;
LAB40:    t6 = (t0 + 3544U);
    *((char **)t6) = &&LAB37;
    goto LAB1;

}


extern void work_m_00000000000854321959_2293236816_init()
{
	static char *pe[] = {(void *)NetDecl_13_0,(void *)Always_26_1,(void *)Initial_28_2};
	static char *se[] = {(void *)sp_resetSystem,(void *)sp_testLongButtonPress,(void *)sp_testShortButtonPress,(void *)sp_testShortButtonBounce,(void *)sp_testShorterButtonBounce,(void *)sp_testShortestButtonBounce};
	xsi_register_didat("work_m_00000000000854321959_2293236816", "isim/ButtonPressDetector_tb_isim_beh.exe.sim/work/m_00000000000854321959_2293236816.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
