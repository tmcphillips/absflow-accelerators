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
static const char *ng0 = "C:/Users/tmcphillips/Designs/Projects/BASYS250/VerilogHDL/02_FourBitCounterWithFIFO/pushpullfifo_tb.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {0U, 0U};
static const char *ng3 = "*** FAILURE ****  simulation assertion failure at t = %t \n";
static const char *ng4 = "1ns/1ps";
static const char *ng5 = "PushPullFIFO_tb";
static int ng6[] = {9, 0};
static int ng7[] = {10, 0};
static const char *ng8 = "";
static int ng9[] = {0, 0};
static int ng10[] = {1, 0};
static const char *ng11 = "*** SUCCESS ***  Simulation ended succesfully at t = %t \n";



static int sp_putValue_ImmediateAck(char *t1, char *t2)
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
    xsi_set_current_line(97, ng0);

LAB5:    xsi_set_current_line(98, ng0);
    t5 = (t1 + 1984);
    t6 = (t5 + 36U);
    t7 = *((char **)t6);
    t8 = (t1 + 1708);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 1);
    xsi_set_current_line(99, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 1800);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(100, ng0);
    t4 = (t1 + 1112U);
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
        goto LAB9;

LAB6:    if (t20 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t10) = 1;

LAB9:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB13;

LAB11:    if (*((unsigned int *)t23) == 0)
        goto LAB10;

LAB12:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB13:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB14;

LAB15:
LAB16:    xsi_set_current_line(101, ng0);
    t4 = (t1 + 1296U);
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
        goto LAB21;

LAB18:    if (t20 != 0)
        goto LAB20;

LAB19:    *((unsigned int *)t10) = 1;

LAB21:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB25;

LAB23:    if (*((unsigned int *)t23) == 0)
        goto LAB22;

LAB24:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB25:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB26;

LAB27:
LAB28:    xsi_set_current_line(103, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000LL);
    *((char **)t3) = &&LAB30;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB8:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB9;

LAB10:    *((unsigned int *)t9) = 1;
    goto LAB13;

LAB14:    xsi_set_current_line(100, ng0);

LAB17:    xsi_set_current_line(100, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(100, ng0);
    xsi_vlog_finish(1);
    goto LAB16;

LAB20:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB21;

LAB22:    *((unsigned int *)t9) = 1;
    goto LAB25;

LAB26:    xsi_set_current_line(101, ng0);

LAB29:    xsi_set_current_line(101, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(101, ng0);
    xsi_vlog_finish(1);
    goto LAB28;

LAB30:    xsi_set_current_line(103, ng0);
    t6 = ((char*)((ng2)));
    t7 = (t1 + 1800);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 1);
    xsi_set_current_line(104, ng0);
    t4 = (t1 + 1112U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
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
        goto LAB34;

LAB31:    if (t20 != 0)
        goto LAB33;

LAB32:    *((unsigned int *)t10) = 1;

LAB34:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB38;

LAB36:    if (*((unsigned int *)t23) == 0)
        goto LAB35;

LAB37:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB38:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB39;

LAB40:
LAB41:    xsi_set_current_line(105, ng0);
    t4 = (t1 + 1296U);
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
        goto LAB46;

LAB43:    if (t20 != 0)
        goto LAB45;

LAB44:    *((unsigned int *)t10) = 1;

LAB46:    memset(t9, 0, 8);
    t23 = (t10 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t10);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB50;

LAB48:    if (*((unsigned int *)t23) == 0)
        goto LAB47;

LAB49:    t29 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t29) = 1;

LAB50:    t30 = (t9 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t9);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB51;

LAB52:
LAB53:    goto LAB4;

LAB33:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB34;

LAB35:    *((unsigned int *)t9) = 1;
    goto LAB38;

LAB39:    xsi_set_current_line(104, ng0);

LAB42:    xsi_set_current_line(104, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(104, ng0);
    xsi_vlog_finish(1);
    goto LAB41;

LAB45:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB46;

LAB47:    *((unsigned int *)t9) = 1;
    goto LAB50;

LAB51:    xsi_set_current_line(105, ng0);

LAB54:    xsi_set_current_line(105, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 484);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(105, ng0);
    xsi_vlog_finish(1);
    goto LAB53;

}

static int sp_takeValue_ImmediateAck(char *t1, char *t2)
{
    char t7[8];
    char t8[8];
    char t37[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t9;
    unsigned int t10;
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
    char *t22;
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
    char *t39;
    char *t40;

LAB0:    t0 = 1;
    t3 = (t2 + 28U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 740);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(111, ng0);

LAB5:    xsi_set_current_line(112, ng0);
    t5 = ((char*)((ng1)));
    t6 = (t1 + 1892);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 1);
    xsi_set_current_line(113, ng0);
    t4 = (t1 + 1112U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t6 = (t5 + 4);
    t9 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t4);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t6);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB9;

LAB6:    if (t19 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t8) = 1;

LAB9:    memset(t7, 0, 8);
    t23 = (t8 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t8);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB13;

LAB11:    if (*((unsigned int *)t23) == 0)
        goto LAB10;

LAB12:    t29 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t29) = 1;

LAB13:    t30 = (t7 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t7);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB14;

LAB15:
LAB16:    xsi_set_current_line(114, ng0);
    t4 = (t1 + 1296U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t6 = (t5 + 4);
    t9 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t4);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t6);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB21;

LAB18:    if (t19 != 0)
        goto LAB20;

LAB19:    *((unsigned int *)t8) = 1;

LAB21:    memset(t7, 0, 8);
    t23 = (t8 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t8);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB25;

LAB23:    if (*((unsigned int *)t23) == 0)
        goto LAB22;

LAB24:    t29 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t29) = 1;

LAB25:    t30 = (t7 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t7);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB26;

LAB27:
LAB28:    xsi_set_current_line(116, ng0);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 2000LL);
    *((char **)t3) = &&LAB30;
    t0 = 1;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 28U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB8:    t22 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB9;

LAB10:    *((unsigned int *)t7) = 1;
    goto LAB13;

LAB14:    xsi_set_current_line(113, ng0);

LAB17:    xsi_set_current_line(113, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(113, ng0);
    xsi_vlog_finish(1);
    goto LAB16;

LAB20:    t22 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB21;

LAB22:    *((unsigned int *)t7) = 1;
    goto LAB25;

LAB26:    xsi_set_current_line(114, ng0);

LAB29:    xsi_set_current_line(114, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(114, ng0);
    xsi_vlog_finish(1);
    goto LAB28;

LAB30:    xsi_set_current_line(116, ng0);
    t6 = ((char*)((ng2)));
    t9 = (t1 + 1892);
    xsi_vlogvar_assign_value(t9, t6, 0, 0, 1);
    xsi_set_current_line(117, ng0);
    t4 = (t1 + 1204U);
    t5 = *((char **)t4);
    t4 = (t1 + 2076);
    t6 = (t4 + 36U);
    t9 = *((char **)t6);
    memset(t8, 0, 8);
    t22 = (t5 + 4);
    t23 = (t9 + 4);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t9);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t22);
    t14 = *((unsigned int *)t23);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t22);
    t18 = *((unsigned int *)t23);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB34;

LAB31:    if (t19 != 0)
        goto LAB33;

LAB32:    *((unsigned int *)t8) = 1;

LAB34:    memset(t7, 0, 8);
    t30 = (t8 + 4);
    t24 = *((unsigned int *)t30);
    t25 = (~(t24));
    t26 = *((unsigned int *)t8);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB38;

LAB36:    if (*((unsigned int *)t30) == 0)
        goto LAB35;

LAB37:    t38 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t38) = 1;

LAB38:    t39 = (t7 + 4);
    t31 = *((unsigned int *)t39);
    t32 = (~(t31));
    t33 = *((unsigned int *)t7);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB39;

LAB40:
LAB41:    xsi_set_current_line(118, ng0);
    t4 = (t1 + 1112U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t6 = (t5 + 4);
    t9 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t4);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t6);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB46;

LAB43:    if (t19 != 0)
        goto LAB45;

LAB44:    *((unsigned int *)t8) = 1;

LAB46:    memset(t7, 0, 8);
    t23 = (t8 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t8);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB50;

LAB48:    if (*((unsigned int *)t23) == 0)
        goto LAB47;

LAB49:    t29 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t29) = 1;

LAB50:    t30 = (t7 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t7);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB51;

LAB52:
LAB53:    xsi_set_current_line(119, ng0);
    t4 = (t1 + 1296U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t8, 0, 8);
    t6 = (t5 + 4);
    t9 = (t4 + 4);
    t10 = *((unsigned int *)t5);
    t11 = *((unsigned int *)t4);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t6);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB58;

LAB55:    if (t19 != 0)
        goto LAB57;

LAB56:    *((unsigned int *)t8) = 1;

LAB58:    memset(t7, 0, 8);
    t23 = (t8 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t8);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB62;

LAB60:    if (*((unsigned int *)t23) == 0)
        goto LAB59;

LAB61:    t29 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t29) = 1;

LAB62:    t30 = (t7 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t7);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB63;

LAB64:
LAB65:    goto LAB4;

LAB33:    t29 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB34;

LAB35:    *((unsigned int *)t7) = 1;
    goto LAB38;

LAB39:    xsi_set_current_line(117, ng0);

LAB42:    xsi_set_current_line(117, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t40 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t40, (char)114, t37, 64);
    xsi_set_current_line(117, ng0);
    xsi_vlog_finish(1);
    goto LAB41;

LAB45:    t22 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB46;

LAB47:    *((unsigned int *)t7) = 1;
    goto LAB50;

LAB51:    xsi_set_current_line(118, ng0);

LAB54:    xsi_set_current_line(118, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(118, ng0);
    xsi_vlog_finish(1);
    goto LAB53;

LAB57:    t22 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB58;

LAB59:    *((unsigned int *)t7) = 1;
    goto LAB62;

LAB63:    xsi_set_current_line(119, ng0);

LAB66:    xsi_set_current_line(119, ng0);
    t36 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t37) = t36;
    t38 = (t1 + 740);
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t38, (char)114, t37, 64);
    xsi_set_current_line(119, ng0);
    xsi_vlog_finish(1);
    goto LAB65;

}

static void Initial_30_0(char *t0)
{
    char t3[8];
    char t6[8];
    char t35[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    double t34;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    int t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;

LAB0:    t1 = (t0 + 2600U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);

LAB4:    xsi_set_current_line(32, ng0);
    xsi_vlog_printtimescale(ng4, t0, ng5);
    xsi_set_current_line(33, ng0);
    t2 = ((char*)((ng6)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng7)));
    t5 = ((char*)((ng7)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng8, 0, *((unsigned int *)t5));
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng9)));
    t4 = (t0 + 1524);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(37, ng0);
    t2 = ((char*)((ng9)));
    t4 = (t0 + 1616);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng9)));
    t4 = (t0 + 1708);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(39, ng0);
    t2 = ((char*)((ng9)));
    t4 = (t0 + 1800);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng9)));
    t4 = (t0 + 1892);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(42, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(42, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 1616);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(44, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(44, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t0 + 1616);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 1112U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t5 = (t4 + 4);
    t7 = (t2 + 4);
    t8 = *((unsigned int *)t4);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = (t10 | t13);
    t15 = *((unsigned int *)t5);
    t16 = *((unsigned int *)t7);
    t17 = (t15 | t16);
    t18 = (~(t17));
    t19 = (t14 & t18);
    if (t19 != 0)
        goto LAB10;

LAB7:    if (t17 != 0)
        goto LAB9;

LAB8:    *((unsigned int *)t6) = 1;

LAB10:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t21) == 0)
        goto LAB11;

LAB13:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB14:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB15;

LAB16:
LAB17:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1296U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t5 = (t4 + 4);
    t7 = (t2 + 4);
    t8 = *((unsigned int *)t4);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t5);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = (t10 | t13);
    t15 = *((unsigned int *)t5);
    t16 = *((unsigned int *)t7);
    t17 = (t15 | t16);
    t18 = (~(t17));
    t19 = (t14 & t18);
    if (t19 != 0)
        goto LAB22;

LAB19:    if (t17 != 0)
        goto LAB21;

LAB20:    *((unsigned int *)t6) = 1;

LAB22:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t21) == 0)
        goto LAB23;

LAB25:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB26:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB27;

LAB28:
LAB29:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB9:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t3) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(45, ng0);

LAB18:    xsi_set_current_line(45, ng0);
    t34 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(45, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB21:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t3) = 1;
    goto LAB26;

LAB27:    xsi_set_current_line(46, ng0);

LAB30:    xsi_set_current_line(46, ng0);
    t34 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng3, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(46, ng0);
    xsi_vlog_finish(1);
    goto LAB29;

LAB31:    xsi_set_current_line(49, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB34:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB36:    if (t42 != 0)
        goto LAB37;

LAB32:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB33:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB38;
    goto LAB1;

LAB35:;
LAB37:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB34;
    goto LAB1;

LAB38:    xsi_set_current_line(50, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB41:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB43:    if (t42 != 0)
        goto LAB44;

LAB39:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB40:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(51, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB45;
    goto LAB1;

LAB42:;
LAB44:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB41;
    goto LAB1;

LAB45:    xsi_set_current_line(51, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB48:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB50:    if (t42 != 0)
        goto LAB51;

LAB46:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB47:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(52, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB52;
    goto LAB1;

LAB49:;
LAB51:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB48;
    goto LAB1;

LAB52:    xsi_set_current_line(52, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB55:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB57:    if (t42 != 0)
        goto LAB58;

LAB53:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB54:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(55, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB59;
    goto LAB1;

LAB56:;
LAB58:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB55;
    goto LAB1;

LAB59:    xsi_set_current_line(55, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB62:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB64:    if (t42 != 0)
        goto LAB65;

LAB60:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB61:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(56, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB66;
    goto LAB1;

LAB63:;
LAB65:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB62;
    goto LAB1;

LAB66:    xsi_set_current_line(56, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB69:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB71:    if (t42 != 0)
        goto LAB72;

LAB67:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB68:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB73;
    goto LAB1;

LAB70:;
LAB72:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB69;
    goto LAB1;

LAB73:    xsi_set_current_line(57, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB76:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB78:    if (t42 != 0)
        goto LAB79;

LAB74:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB75:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(58, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB80;
    goto LAB1;

LAB77:;
LAB79:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB76;
    goto LAB1;

LAB80:    xsi_set_current_line(58, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB83:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB85:    if (t42 != 0)
        goto LAB86;

LAB81:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB82:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(61, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB87;
    goto LAB1;

LAB84:;
LAB86:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB83;
    goto LAB1;

LAB87:    xsi_set_current_line(61, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB90:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB92:    if (t42 != 0)
        goto LAB93;

LAB88:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB89:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB94;
    goto LAB1;

LAB91:;
LAB93:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB90;
    goto LAB1;

LAB94:    xsi_set_current_line(62, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB97:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB99:    if (t42 != 0)
        goto LAB100;

LAB95:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB96:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB101;
    goto LAB1;

LAB98:;
LAB100:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB97;
    goto LAB1;

LAB101:    xsi_set_current_line(63, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB104:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB106:    if (t42 != 0)
        goto LAB107;

LAB102:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB103:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB108;
    goto LAB1;

LAB105:;
LAB107:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB104;
    goto LAB1;

LAB108:    xsi_set_current_line(64, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB111:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB113:    if (t42 != 0)
        goto LAB114;

LAB109:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB110:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB115;
    goto LAB1;

LAB112:;
LAB114:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB111;
    goto LAB1;

LAB115:    xsi_set_current_line(67, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB118:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB120:    if (t42 != 0)
        goto LAB121;

LAB116:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB117:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB122;
    goto LAB1;

LAB119:;
LAB121:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB118;
    goto LAB1;

LAB122:    xsi_set_current_line(68, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB125:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB127:    if (t42 != 0)
        goto LAB128;

LAB123:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB124:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(69, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB129;
    goto LAB1;

LAB126:;
LAB128:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB125;
    goto LAB1;

LAB129:    xsi_set_current_line(69, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB132:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB134:    if (t42 != 0)
        goto LAB135;

LAB130:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB131:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB136;
    goto LAB1;

LAB133:;
LAB135:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB132;
    goto LAB1;

LAB136:    xsi_set_current_line(70, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB139:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB141:    if (t42 != 0)
        goto LAB142;

LAB137:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB138:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB143;
    goto LAB1;

LAB140:;
LAB142:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB139;
    goto LAB1;

LAB143:    xsi_set_current_line(73, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB146:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB148:    if (t42 != 0)
        goto LAB149;

LAB144:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB145:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB150;
    goto LAB1;

LAB147:;
LAB149:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB146;
    goto LAB1;

LAB150:    xsi_set_current_line(74, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB153:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB155:    if (t42 != 0)
        goto LAB156;

LAB151:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB152:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(77, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB157;
    goto LAB1;

LAB154:;
LAB156:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB153;
    goto LAB1;

LAB157:    xsi_set_current_line(77, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB160:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB162:    if (t42 != 0)
        goto LAB163;

LAB158:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB159:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB164;
    goto LAB1;

LAB161:;
LAB163:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB160;
    goto LAB1;

LAB164:    xsi_set_current_line(78, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB167:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB169:    if (t42 != 0)
        goto LAB170;

LAB165:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB166:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB171;
    goto LAB1;

LAB168:;
LAB170:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB167;
    goto LAB1;

LAB171:    xsi_set_current_line(81, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB174:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB176:    if (t42 != 0)
        goto LAB177;

LAB172:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB173:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB178;
    goto LAB1;

LAB175:;
LAB177:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB174;
    goto LAB1;

LAB178:    xsi_set_current_line(82, ng0);
    t4 = ((char*)((ng10)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB181:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB183:    if (t42 != 0)
        goto LAB184;

LAB179:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB180:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(85, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB185;
    goto LAB1;

LAB182:;
LAB184:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB181;
    goto LAB1;

LAB185:    xsi_set_current_line(85, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 484);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 1984);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB188:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB190:    if (t42 != 0)
        goto LAB191;

LAB186:    t28 = (t0 + 484);
    xsi_vlog_subprogram_popinvocation(t28);

LAB187:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 484);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB192;
    goto LAB1;

LAB189:;
LAB191:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB188;
    goto LAB1;

LAB192:    xsi_set_current_line(86, ng0);
    t4 = ((char*)((ng9)));
    t5 = (t0 + 2500);
    t7 = (t0 + 740);
    t20 = xsi_create_subprogram_invocation(t5, 0, t0, t7, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t7, t20);
    t21 = (t0 + 2076);
    xsi_vlogvar_assign_value(t21, t4, 0, 0, 1);

LAB195:    t27 = (t0 + 2552);
    t28 = *((char **)t27);
    t36 = (t28 + 44U);
    t37 = *((char **)t36);
    t38 = (t37 + 148U);
    t39 = *((char **)t38);
    t40 = (t39 + 0U);
    t41 = *((char **)t40);
    t42 = ((int  (*)(char *, char *))t41)(t0, t28);

LAB197:    if (t42 != 0)
        goto LAB198;

LAB193:    t28 = (t0 + 740);
    xsi_vlog_subprogram_popinvocation(t28);

LAB194:    t43 = (t0 + 2552);
    t44 = *((char **)t43);
    t43 = (t0 + 740);
    t45 = (t0 + 2500);
    t46 = 0;
    xsi_delete_subprogram_invocation(t43, t44, t0, t45, t46);
    xsi_set_current_line(88, ng0);
    t2 = (t0 + 2500);
    xsi_process_wait(t2, 6000LL);
    *((char **)t1) = &&LAB199;
    goto LAB1;

LAB196:;
LAB198:    t27 = (t0 + 2600U);
    *((char **)t27) = &&LAB195;
    goto LAB1;

LAB199:    xsi_set_current_line(88, ng0);
    t34 = xsi_vlog_realtime(1000.0000000000000, 1000.0000000000000);
    *((double *)t3) = t34;
    xsi_vlogfile_write(0, 0, 1, ng11, 2, t0, (char)114, t3, 64);
    xsi_set_current_line(89, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}

static void Always_93_1(char *t0)
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

LAB0:    t1 = (t0 + 2744U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(93, ng0);
    t2 = (t0 + 2644);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(93, ng0);
    t4 = (t0 + 1524);
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
    t24 = (t0 + 1524);
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


extern void work_m_00000000004177369619_1547145193_init()
{
	static char *pe[] = {(void *)Initial_30_0,(void *)Always_93_1};
	static char *se[] = {(void *)sp_putValue_ImmediateAck,(void *)sp_takeValue_ImmediateAck};
	xsi_register_didat("work_m_00000000004177369619_1547145193", "isim/PushPullFIFO_tb_isim_beh.exe.sim/work/m_00000000004177369619_1547145193.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
