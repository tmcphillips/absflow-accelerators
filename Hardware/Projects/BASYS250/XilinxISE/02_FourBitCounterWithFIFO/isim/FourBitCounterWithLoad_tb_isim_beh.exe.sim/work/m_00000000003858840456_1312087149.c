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
static const char *ng0 = "C:/Users/tmcphillips/Designs/Projects/BASYS250/VerilogHDL/02_FourBitCounterWithFIFO/buttonpressdetector.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {2U, 0U};
static unsigned int ng4[] = {3U, 0U};
static unsigned int ng5[] = {4U, 0U};
static unsigned int ng6[] = {5U, 0U};



static void Always_21_0(char *t0)
{
    char t16[8];
    char t17[8];
    char t23[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    int t47;
    int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    char *t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    char *t61;
    char *t62;

LAB0:    t1 = (t0 + 2200U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 2540);
    *((int *)t2) = 1;
    t3 = (t0 + 2228);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(23, ng0);
    t4 = (t0 + 1356U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB5;

LAB6:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1676);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);

LAB8:    t5 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 3);
    if (t13 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng3)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng4)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng5)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng6)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t13 == 1)
        goto LAB19;

LAB20:
LAB22:
LAB21:    xsi_set_current_line(53, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB23:
LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(24, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    goto LAB7;

LAB9:    xsi_set_current_line(29, ng0);
    t11 = (t0 + 1080U);
    t12 = *((char **)t11);
    t11 = (t12 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t12);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB24;

LAB25:
LAB26:    goto LAB23;

LAB11:    xsi_set_current_line(32, ng0);
    t3 = (t0 + 1080U);
    t5 = *((char **)t3);
    t3 = (t5 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB27;

LAB28:    xsi_set_current_line(35, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB29:    goto LAB23;

LAB13:    xsi_set_current_line(37, ng0);
    t3 = (t0 + 1080U);
    t5 = *((char **)t3);
    t3 = (t5 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB30;

LAB31:    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB32:    goto LAB23;

LAB15:    xsi_set_current_line(42, ng0);
    t3 = (t0 + 1080U);
    t5 = *((char **)t3);
    t3 = (t5 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB33;

LAB34:    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB35:    goto LAB23;

LAB17:    xsi_set_current_line(47, ng0);
    t3 = (t0 + 1172U);
    t5 = *((char **)t3);
    t3 = (t5 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB36;

LAB37:
LAB38:    goto LAB23;

LAB19:    xsi_set_current_line(50, ng0);
    t3 = (t0 + 1080U);
    t5 = *((char **)t3);
    memset(t16, 0, 8);
    t3 = (t5 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB42;

LAB40:    if (*((unsigned int *)t3) == 0)
        goto LAB39;

LAB41:    t11 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t11) = 1;

LAB42:    t12 = (t0 + 1172U);
    t14 = *((char **)t12);
    memset(t17, 0, 8);
    t12 = (t14 + 4);
    t18 = *((unsigned int *)t12);
    t19 = (~(t18));
    t20 = *((unsigned int *)t14);
    t21 = (t20 & t19);
    t22 = (t21 & 1U);
    if (t22 != 0)
        goto LAB46;

LAB44:    if (*((unsigned int *)t12) == 0)
        goto LAB43;

LAB45:    t15 = (t17 + 4);
    *((unsigned int *)t17) = 1;
    *((unsigned int *)t15) = 1;

LAB46:    t24 = *((unsigned int *)t16);
    t25 = *((unsigned int *)t17);
    t26 = (t24 & t25);
    *((unsigned int *)t23) = t26;
    t27 = (t16 + 4);
    t28 = (t17 + 4);
    t29 = (t23 + 4);
    t30 = *((unsigned int *)t27);
    t31 = *((unsigned int *)t28);
    t32 = (t30 | t31);
    *((unsigned int *)t29) = t32;
    t33 = *((unsigned int *)t29);
    t34 = (t33 != 0);
    if (t34 == 1)
        goto LAB47;

LAB48:
LAB49:    t55 = (t23 + 4);
    t56 = *((unsigned int *)t55);
    t57 = (~(t56));
    t58 = *((unsigned int *)t23);
    t59 = (t58 & t57);
    t60 = (t59 != 0);
    if (t60 > 0)
        goto LAB50;

LAB51:
LAB52:    goto LAB23;

LAB24:    xsi_set_current_line(30, ng0);
    t14 = ((char*)((ng3)));
    t15 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t15, t14, 0, 0, 3, 0LL);
    goto LAB26;

LAB27:    xsi_set_current_line(33, ng0);
    t11 = ((char*)((ng4)));
    t12 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    goto LAB29;

LAB30:    xsi_set_current_line(38, ng0);
    t11 = ((char*)((ng5)));
    t12 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    goto LAB32;

LAB33:    xsi_set_current_line(43, ng0);
    t11 = ((char*)((ng6)));
    t12 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    goto LAB35;

LAB36:    xsi_set_current_line(48, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 3, 0LL);
    goto LAB38;

LAB39:    *((unsigned int *)t16) = 1;
    goto LAB42;

LAB43:    *((unsigned int *)t17) = 1;
    goto LAB46;

LAB47:    t35 = *((unsigned int *)t23);
    t36 = *((unsigned int *)t29);
    *((unsigned int *)t23) = (t35 | t36);
    t37 = (t16 + 4);
    t38 = (t17 + 4);
    t39 = *((unsigned int *)t16);
    t40 = (~(t39));
    t41 = *((unsigned int *)t37);
    t42 = (~(t41));
    t43 = *((unsigned int *)t17);
    t44 = (~(t43));
    t45 = *((unsigned int *)t38);
    t46 = (~(t45));
    t47 = (t40 & t42);
    t48 = (t44 & t46);
    t49 = (~(t47));
    t50 = (~(t48));
    t51 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t51 & t49);
    t52 = *((unsigned int *)t29);
    *((unsigned int *)t29) = (t52 & t50);
    t53 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t53 & t49);
    t54 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t54 & t50);
    goto LAB49;

LAB50:    xsi_set_current_line(51, ng0);
    t61 = ((char*)((ng2)));
    t62 = (t0 + 1676);
    xsi_vlogvar_wait_assign_value(t62, t61, 0, 0, 3, 0LL);
    goto LAB52;

}

static void Cont_57_1(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
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
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;

LAB0:    t1 = (t0 + 2344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1676);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t5);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB7;

LAB4:    if (t18 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t6) = 1;

LAB7:    t22 = (t0 + 2592);
    t23 = (t22 + 32U);
    t24 = *((char **)t23);
    t25 = (t24 + 40U);
    t26 = *((char **)t25);
    memset(t26, 0, 8);
    t27 = 1U;
    t28 = t27;
    t29 = (t6 + 4);
    t30 = *((unsigned int *)t6);
    t27 = (t27 & t30);
    t31 = *((unsigned int *)t29);
    t28 = (t28 & t31);
    t32 = (t26 + 4);
    t33 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t33 | t27);
    t34 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t34 | t28);
    xsi_driver_vfirst_trans(t22, 0, 0);
    t35 = (t0 + 2548);
    *((int *)t35) = 1;

LAB1:    return;
LAB6:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB7;

}


extern void work_m_00000000003858840456_1312087149_init()
{
	static char *pe[] = {(void *)Always_21_0,(void *)Cont_57_1};
	xsi_register_didat("work_m_00000000003858840456_1312087149", "isim/FourBitCounterWithLoad_tb_isim_beh.exe.sim/work/m_00000000003858840456_1312087149.didat");
	xsi_register_executes(pe);
}
