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
static const char *ng0 = "C:/Users/tmcphillips/Designs/Projects/BASYS250/VerilogHDL/01_FourBitCounterWithLoad/fourbitcounterwithload_tb.v";
static const char *ng1 = "1us/1ns";
static const char *ng2 = "FourBitCounterWithLoad_tb";
static int ng3[] = {6, 0};
static int ng4[] = {10, 0};
static const char *ng5 = "";
static unsigned int ng6[] = {0U, 0U};
static unsigned int ng7[] = {1U, 0U};
static int ng8[] = {0, 0};
static const char *ng9 = "*** FAILURE ****  simulation assertion failure at t = %t \n";
static int ng10[] = {1, 0};
static int ng11[] = {2, 0};
static int ng12[] = {11, 0};
static const char *ng13 = "*** SUCCESS ***  Simulation ended succesfully at t = %t \n";



static void NetDecl_24_0(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 2272U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(24, ng0);
    t2 = (t0 + 5216);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 24U);
    t5 = *((char **)t4);
    t4 = (t0 + 3408);
    t6 = (t4 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t4, 0, 0U);
    t18 = (t0 + 3332);
    *((int *)t18) = 1;

LAB1:    return;
}

static void NetDecl_25_1(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 2416U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 5232);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 24U);
    t5 = *((char **)t4);
    t4 = (t0 + 3444);
    t6 = (t4 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t4, 0, 0U);
    t18 = (t0 + 3340);
    *((int *)t18) = 1;

LAB1:    return;
}

static void NetDecl_26_2(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 2560U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 5252);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 24U);
    t5 = *((char **)t4);
    t4 = (t0 + 3480);
    t6 = (t4 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t4, 0, 0U);
    t18 = (t0 + 3348);
    *((int *)t18) = 1;

LAB1:    return;
}

static void NetDecl_27_3(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 2704U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 5272);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 24U);
    t5 = *((char **)t4);
    t4 = (t0 + 3516);
    t6 = (t4 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t4, 0, 0U);
    t18 = (t0 + 3356);
    *((int *)t18) = 1;

LAB1:    return;
}

static void NetDecl_28_4(char *t0)
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
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 5300);
    t3 = *((char **)t2);
    t4 = ((((char*)(t3))) + 24U);
    t5 = *((char **)t4);
    t4 = (t0 + 3552);
    t6 = (t4 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t5 + 4);
    t13 = *((unsigned int *)t5);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t4, 0, 0U);
    t18 = (t0 + 3364);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_31_5(char *t0)
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

LAB0:    t1 = (t0 + 2992U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 2892);
    xsi_process_wait(t2, 1000000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);
    t4 = (t0 + 1748);
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
    t24 = (t0 + 1748);
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

static void Initial_33_6(char *t0)
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

LAB0:    t1 = (t0 + 3136U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(33, ng0);

LAB4:    xsi_set_current_line(36, ng0);
    xsi_vlog_printtimescale(ng1, t0, ng2);
    xsi_set_current_line(37, ng0);
    t2 = ((char*)((ng3)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng4)));
    t5 = ((char*)((ng4)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng5, 0, *((unsigned int *)t5));
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1748);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1288);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1380);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1472);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1564);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng6)));
    t4 = (t0 + 1656);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 4);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(47, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1564);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(48, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 10000000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(48, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1564);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(49, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng8)));
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
LAB17:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB9:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB10;

LAB11:    *((unsigned int *)t3) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(49, ng0);

LAB18:    xsi_set_current_line(49, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(49, ng0);
    xsi_vlog_finish(1);
    goto LAB17;

LAB19:    xsi_set_current_line(51, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(52, ng0);
    t2 = ((char*)((ng7)));
    t4 = (t0 + 1380);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 100000000LL);
    *((char **)t1) = &&LAB20;
    goto LAB1;

LAB20:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 5000000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(56, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng8)));
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
        goto LAB25;

LAB22:    if (t17 != 0)
        goto LAB24;

LAB23:    *((unsigned int *)t6) = 1;

LAB25:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB29;

LAB27:    if (*((unsigned int *)t21) == 0)
        goto LAB26;

LAB28:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB29:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB30;

LAB31:
LAB32:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB34;
    goto LAB1;

LAB24:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB25;

LAB26:    *((unsigned int *)t3) = 1;
    goto LAB29;

LAB30:    xsi_set_current_line(57, ng0);

LAB33:    xsi_set_current_line(57, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(57, ng0);
    xsi_vlog_finish(1);
    goto LAB32;

LAB34:    xsi_set_current_line(59, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 40000000LL);
    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB35:    xsi_set_current_line(60, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(61, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng10)));
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
        goto LAB39;

LAB36:    if (t17 != 0)
        goto LAB38;

LAB37:    *((unsigned int *)t6) = 1;

LAB39:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB43;

LAB41:    if (*((unsigned int *)t21) == 0)
        goto LAB40;

LAB42:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB43:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB44;

LAB45:
LAB46:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB48;
    goto LAB1;

LAB38:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB39;

LAB40:    *((unsigned int *)t3) = 1;
    goto LAB43;

LAB44:    xsi_set_current_line(61, ng0);

LAB47:    xsi_set_current_line(61, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(61, ng0);
    xsi_vlog_finish(1);
    goto LAB46;

LAB48:    xsi_set_current_line(63, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 40000000LL);
    *((char **)t1) = &&LAB49;
    goto LAB1;

LAB49:    xsi_set_current_line(64, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1288);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng11)));
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
        goto LAB53;

LAB50:    if (t17 != 0)
        goto LAB52;

LAB51:    *((unsigned int *)t6) = 1;

LAB53:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB57;

LAB55:    if (*((unsigned int *)t21) == 0)
        goto LAB54;

LAB56:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB57:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB58;

LAB59:
LAB60:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB62;
    goto LAB1;

LAB52:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB53;

LAB54:    *((unsigned int *)t3) = 1;
    goto LAB57;

LAB58:    xsi_set_current_line(65, ng0);

LAB61:    xsi_set_current_line(65, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(65, ng0);
    xsi_vlog_finish(1);
    goto LAB60;

LAB62:    xsi_set_current_line(67, ng0);
    t4 = ((char*)((ng12)));
    t5 = (t0 + 1656);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 10000000LL);
    *((char **)t1) = &&LAB63;
    goto LAB1;

LAB63:    xsi_set_current_line(68, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1472);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(69, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB64;
    goto LAB1;

LAB64:    xsi_set_current_line(69, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1472);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng12)));
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
        goto LAB68;

LAB65:    if (t17 != 0)
        goto LAB67;

LAB66:    *((unsigned int *)t6) = 1;

LAB68:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB72;

LAB70:    if (*((unsigned int *)t21) == 0)
        goto LAB69;

LAB71:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB72:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB73;

LAB74:
LAB75:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB77;
    goto LAB1;

LAB67:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB68;

LAB69:    *((unsigned int *)t3) = 1;
    goto LAB72;

LAB73:    xsi_set_current_line(70, ng0);

LAB76:    xsi_set_current_line(70, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(70, ng0);
    xsi_vlog_finish(1);
    goto LAB75;

LAB77:    xsi_set_current_line(72, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1380);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 5000000LL);
    *((char **)t1) = &&LAB78;
    goto LAB1;

LAB78:    xsi_set_current_line(73, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1380);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng12)));
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
        goto LAB82;

LAB79:    if (t17 != 0)
        goto LAB81;

LAB80:    *((unsigned int *)t6) = 1;

LAB82:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB86;

LAB84:    if (*((unsigned int *)t21) == 0)
        goto LAB83;

LAB85:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB86:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB87;

LAB88:
LAB89:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB91;
    goto LAB1;

LAB81:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB82;

LAB83:    *((unsigned int *)t3) = 1;
    goto LAB86;

LAB87:    xsi_set_current_line(74, ng0);

LAB90:    xsi_set_current_line(74, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(74, ng0);
    xsi_vlog_finish(1);
    goto LAB89;

LAB91:    xsi_set_current_line(76, ng0);
    t4 = ((char*)((ng7)));
    t5 = (t0 + 1380);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(77, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 40000000LL);
    *((char **)t1) = &&LAB92;
    goto LAB1;

LAB92:    xsi_set_current_line(77, ng0);
    t4 = ((char*)((ng6)));
    t5 = (t0 + 1380);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 600U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng4)));
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
        goto LAB96;

LAB93:    if (t17 != 0)
        goto LAB95;

LAB94:    *((unsigned int *)t6) = 1;

LAB96:    memset(t3, 0, 8);
    t21 = (t6 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t6);
    t25 = (t24 & t23);
    t26 = (t25 & 1U);
    if (t26 != 0)
        goto LAB100;

LAB98:    if (*((unsigned int *)t21) == 0)
        goto LAB97;

LAB99:    t27 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t27) = 1;

LAB100:    t28 = (t3 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t3);
    t32 = (t31 & t30);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB101;

LAB102:
LAB103:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3036);
    xsi_process_wait(t2, 20000000LL);
    *((char **)t1) = &&LAB105;
    goto LAB1;

LAB95:    t20 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB96;

LAB97:    *((unsigned int *)t3) = 1;
    goto LAB100;

LAB101:    xsi_set_current_line(78, ng0);

LAB104:    xsi_set_current_line(78, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t35) = t34;
    xsi_vlogfile_write(0, 0, 1, ng9, 2, t0, (char)114, t35, 64);
    xsi_set_current_line(78, ng0);
    xsi_vlog_finish(1);
    goto LAB103;

LAB105:    xsi_set_current_line(82, ng0);
    t34 = xsi_vlog_realtime(1000000.0000000000, 1000.0000000000000);
    *((double *)t3) = t34;
    xsi_vlogfile_write(0, 0, 1, ng13, 2, t0, (char)114, t3, 64);
    xsi_set_current_line(83, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_00000000002110360920_3289906315_init()
{
	static char *pe[] = {(void *)NetDecl_24_0,(void *)NetDecl_25_1,(void *)NetDecl_26_2,(void *)NetDecl_27_3,(void *)NetDecl_28_4,(void *)Always_31_5,(void *)Initial_33_6};
	xsi_register_didat("work_m_00000000002110360920_3289906315", "isim/FourBitCounterWithLoad_tb_isim_beh.exe.sim/work/m_00000000002110360920_3289906315.didat");
	xsi_register_executes(pe);
}
