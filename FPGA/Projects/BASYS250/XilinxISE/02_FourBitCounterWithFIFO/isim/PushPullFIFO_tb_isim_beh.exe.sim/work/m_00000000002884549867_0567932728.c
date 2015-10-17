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
static const char *ng0 = "C:/Users/tmcphillips/Designs/Projects/BASYS250/VerilogHDL/02_FourBitCounterWithFIFO/pushpullfifo.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {1, 0};
static unsigned int ng3[] = {1U, 0U};
static int ng4[] = {0, 0};



static void Always_32_0(char *t0)
{
    char t18[8];
    char t27[8];
    char t37[8];
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
    char *t16;
    char *t17;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;
    char *t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    char *t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    char *t70;
    char *t71;
    int t72;
    int t73;
    int t74;

LAB0:    t1 = (t0 + 2948U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 3288);
    *((int *)t2) = 1;
    t3 = (t0 + 2976);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);
    t4 = (t0 + 1092U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB5;

LAB6:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 1872);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);

LAB9:    t5 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 1, t5, 1);
    if (t13 == 1)
        goto LAB10;

LAB11:    t2 = ((char*)((ng3)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 1, t2, 1);
    if (t13 == 1)
        goto LAB12;

LAB13:
LAB14:
LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(35, ng0);

LAB8:    xsi_set_current_line(36, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 1596);
    xsi_vlogvar_assign_value(t12, t11, 0, 0, 1);
    xsi_set_current_line(37, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2148);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 2);
    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2424);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(39, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1872);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB7;

LAB10:    xsi_set_current_line(45, ng0);
    t11 = (t0 + 1276U);
    t12 = *((char **)t11);
    t11 = (t12 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t12);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB15;

LAB16:
LAB17:    goto LAB14;

LAB12:    xsi_set_current_line(58, ng0);

LAB43:    xsi_set_current_line(59, ng0);
    t3 = ((char*)((ng1)));
    t5 = (t0 + 1596);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 1);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 1276U);
    t3 = *((char **)t2);
    memset(t18, 0, 8);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB47;

LAB45:    if (*((unsigned int *)t2) == 0)
        goto LAB44;

LAB46:    t5 = (t18 + 4);
    *((unsigned int *)t18) = 1;
    *((unsigned int *)t5) = 1;

LAB47:    t11 = (t18 + 4);
    t20 = *((unsigned int *)t11);
    t21 = (~(t20));
    t22 = *((unsigned int *)t18);
    t23 = (t22 & t21);
    t24 = (t23 != 0);
    if (t24 > 0)
        goto LAB48;

LAB49:
LAB50:    goto LAB14;

LAB15:    xsi_set_current_line(46, ng0);

LAB18:    xsi_set_current_line(47, ng0);
    t14 = (t0 + 2148);
    t15 = (t14 + 36U);
    t16 = *((char **)t15);
    t17 = ((char*)((ng2)));
    memset(t18, 0, 8);
    xsi_vlog_unsigned_add(t18, 32, t16, 2, t17, 32);
    t19 = (t0 + 2332);
    xsi_vlogvar_assign_value(t19, t18, 0, 0, 2);
    xsi_set_current_line(48, ng0);
    t2 = (t0 + 2332);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = (t0 + 2240);
    t12 = (t11 + 36U);
    t14 = *((char **)t12);
    memset(t18, 0, 8);
    t15 = (t5 + 4);
    t16 = (t14 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t14);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t15);
    t10 = *((unsigned int *)t16);
    t20 = (t9 ^ t10);
    t21 = (t8 | t20);
    t22 = *((unsigned int *)t15);
    t23 = *((unsigned int *)t16);
    t24 = (t22 | t23);
    t25 = (~(t24));
    t26 = (t21 & t25);
    if (t26 != 0)
        goto LAB20;

LAB19:    if (t24 != 0)
        goto LAB21;

LAB22:    t19 = (t0 + 2424);
    t28 = (t19 + 36U);
    t29 = *((char **)t28);
    memset(t27, 0, 8);
    t30 = (t29 + 4);
    t31 = *((unsigned int *)t30);
    t32 = (~(t31));
    t33 = *((unsigned int *)t29);
    t34 = (t33 & t32);
    t35 = (t34 & 1U);
    if (t35 != 0)
        goto LAB26;

LAB24:    if (*((unsigned int *)t30) == 0)
        goto LAB23;

LAB25:    t36 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t36) = 1;

LAB26:    t38 = *((unsigned int *)t18);
    t39 = *((unsigned int *)t27);
    t40 = (t38 | t39);
    *((unsigned int *)t37) = t40;
    t41 = (t18 + 4);
    t42 = (t27 + 4);
    t43 = (t37 + 4);
    t44 = *((unsigned int *)t41);
    t45 = *((unsigned int *)t42);
    t46 = (t44 | t45);
    *((unsigned int *)t43) = t46;
    t47 = *((unsigned int *)t43);
    t48 = (t47 != 0);
    if (t48 == 1)
        goto LAB27;

LAB28:
LAB29:    t64 = (t37 + 4);
    t65 = *((unsigned int *)t64);
    t66 = (~(t65));
    t67 = *((unsigned int *)t37);
    t68 = (t67 & t66);
    t69 = (t68 != 0);
    if (t69 > 0)
        goto LAB30;

LAB31:
LAB32:    goto LAB17;

LAB20:    *((unsigned int *)t18) = 1;
    goto LAB22;

LAB21:    t17 = (t18 + 4);
    *((unsigned int *)t18) = 1;
    *((unsigned int *)t17) = 1;
    goto LAB22;

LAB23:    *((unsigned int *)t27) = 1;
    goto LAB26;

LAB27:    t49 = *((unsigned int *)t37);
    t50 = *((unsigned int *)t43);
    *((unsigned int *)t37) = (t49 | t50);
    t51 = (t18 + 4);
    t52 = (t27 + 4);
    t53 = *((unsigned int *)t51);
    t54 = (~(t53));
    t55 = *((unsigned int *)t18);
    t13 = (t55 & t54);
    t56 = *((unsigned int *)t52);
    t57 = (~(t56));
    t58 = *((unsigned int *)t27);
    t59 = (t58 & t57);
    t60 = (~(t13));
    t61 = (~(t59));
    t62 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t62 & t60);
    t63 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t63 & t61);
    goto LAB29;

LAB30:    xsi_set_current_line(49, ng0);

LAB33:    xsi_set_current_line(50, ng0);
    t70 = ((char*)((ng3)));
    t71 = (t0 + 1596);
    xsi_vlogvar_assign_value(t71, t70, 0, 0, 1);
    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1184U);
    t3 = *((char **)t2);
    memcpy(t18, t3, 8);
    t2 = (t0 + 2056);
    t5 = (t0 + 2056);
    t11 = (t5 + 44U);
    t12 = *((char **)t11);
    t14 = (t0 + 2056);
    t15 = (t14 + 40U);
    t16 = *((char **)t15);
    t17 = (t0 + 2148);
    t19 = (t17 + 36U);
    t28 = *((char **)t19);
    xsi_vlog_generic_convert_array_indices(t27, t37, t12, t16, 2, 1, t28, 2, 2);
    t29 = (t27 + 4);
    t6 = *((unsigned int *)t29);
    t13 = (!(t6));
    t30 = (t37 + 4);
    t7 = *((unsigned int *)t30);
    t59 = (!(t7));
    t72 = (t13 && t59);
    if (t72 == 1)
        goto LAB34;

LAB35:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 2332);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = (t0 + 2148);
    xsi_vlogvar_assign_value(t11, t5, 0, 0, 2);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 2148);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng4)));
    memset(t18, 0, 8);
    t12 = (t5 + 4);
    t14 = (t11 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t12);
    t10 = *((unsigned int *)t14);
    t20 = (t9 ^ t10);
    t21 = (t8 | t20);
    t22 = *((unsigned int *)t12);
    t23 = *((unsigned int *)t14);
    t24 = (t22 | t23);
    t25 = (~(t24));
    t26 = (t21 & t25);
    if (t26 != 0)
        goto LAB39;

LAB36:    if (t24 != 0)
        goto LAB38;

LAB37:    *((unsigned int *)t18) = 1;

LAB39:    t16 = (t18 + 4);
    t31 = *((unsigned int *)t16);
    t32 = (~(t31));
    t33 = *((unsigned int *)t18);
    t34 = (t33 & t32);
    t35 = (t34 != 0);
    if (t35 > 0)
        goto LAB40;

LAB41:
LAB42:    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1872);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB32;

LAB34:    t8 = *((unsigned int *)t27);
    t9 = *((unsigned int *)t37);
    t73 = (t8 - t9);
    t74 = (t73 + 1);
    xsi_vlogvar_wait_assign_value(t2, t18, 0, *((unsigned int *)t37), t74, 0LL);
    goto LAB35;

LAB38:    t15 = (t18 + 4);
    *((unsigned int *)t18) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB39;

LAB40:    xsi_set_current_line(53, ng0);
    t17 = ((char*)((ng3)));
    t19 = (t0 + 2424);
    xsi_vlogvar_wait_assign_value(t19, t17, 0, 0, 1, 0LL);
    goto LAB42;

LAB44:    *((unsigned int *)t18) = 1;
    goto LAB47;

LAB48:    xsi_set_current_line(60, ng0);
    t12 = ((char*)((ng1)));
    t14 = (t0 + 1872);
    xsi_vlogvar_wait_assign_value(t14, t12, 0, 0, 1, 0LL);
    goto LAB50;

}

static void Always_65_1(char *t0)
{
    char t19[8];
    char t33[8];
    char t61[8];
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
    char *t16;
    char *t17;
    char *t18;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;
    char *t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    int t85;
    int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    char *t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    char *t99;
    char *t100;

LAB0:    t1 = (t0 + 3092U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 3296);
    *((int *)t2) = 1;
    t3 = (t0 + 3120);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(67, ng0);
    t4 = (t0 + 1092U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB5;

LAB6:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 1964);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);

LAB9:    t5 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 1, t5, 1);
    if (t13 == 1)
        goto LAB10;

LAB11:    t2 = ((char*)((ng3)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 1, t2, 1);
    if (t13 == 1)
        goto LAB12;

LAB13:
LAB14:
LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(68, ng0);

LAB8:    xsi_set_current_line(69, ng0);
    t11 = ((char*)((ng4)));
    t12 = (t0 + 1780);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    xsi_set_current_line(70, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1688);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2240);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 2);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1964);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB7;

LAB10:    xsi_set_current_line(78, ng0);
    t11 = (t0 + 1368U);
    t12 = *((char **)t11);
    t11 = (t0 + 2240);
    t14 = (t11 + 36U);
    t15 = *((char **)t14);
    t16 = (t0 + 2148);
    t17 = (t16 + 36U);
    t18 = *((char **)t17);
    memset(t19, 0, 8);
    t20 = (t15 + 4);
    t21 = (t18 + 4);
    t6 = *((unsigned int *)t15);
    t7 = *((unsigned int *)t18);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t20);
    t10 = *((unsigned int *)t21);
    t22 = (t9 ^ t10);
    t23 = (t8 | t22);
    t24 = *((unsigned int *)t20);
    t25 = *((unsigned int *)t21);
    t26 = (t24 | t25);
    t27 = (~(t26));
    t28 = (t23 & t27);
    if (t28 != 0)
        goto LAB16;

LAB15:    if (t26 != 0)
        goto LAB17;

LAB18:    t30 = (t0 + 2424);
    t31 = (t30 + 36U);
    t32 = *((char **)t31);
    t34 = *((unsigned int *)t19);
    t35 = *((unsigned int *)t32);
    t36 = (t34 | t35);
    *((unsigned int *)t33) = t36;
    t37 = (t19 + 4);
    t38 = (t32 + 4);
    t39 = (t33 + 4);
    t40 = *((unsigned int *)t37);
    t41 = *((unsigned int *)t38);
    t42 = (t40 | t41);
    *((unsigned int *)t39) = t42;
    t43 = *((unsigned int *)t39);
    t44 = (t43 != 0);
    if (t44 == 1)
        goto LAB19;

LAB20:
LAB21:    t62 = *((unsigned int *)t12);
    t63 = *((unsigned int *)t33);
    t64 = (t62 & t63);
    *((unsigned int *)t61) = t64;
    t65 = (t12 + 4);
    t66 = (t33 + 4);
    t67 = (t61 + 4);
    t68 = *((unsigned int *)t65);
    t69 = *((unsigned int *)t66);
    t70 = (t68 | t69);
    *((unsigned int *)t67) = t70;
    t71 = *((unsigned int *)t67);
    t72 = (t71 != 0);
    if (t72 == 1)
        goto LAB22;

LAB23:
LAB24:    t93 = (t61 + 4);
    t94 = *((unsigned int *)t93);
    t95 = (~(t94));
    t96 = *((unsigned int *)t61);
    t97 = (t96 & t95);
    t98 = (t97 != 0);
    if (t98 > 0)
        goto LAB25;

LAB26:
LAB27:    goto LAB14;

LAB12:    xsi_set_current_line(87, ng0);

LAB36:    xsi_set_current_line(88, ng0);
    t3 = ((char*)((ng1)));
    t5 = (t0 + 1688);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 1);
    xsi_set_current_line(89, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    memset(t19, 0, 8);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB40;

LAB38:    if (*((unsigned int *)t2) == 0)
        goto LAB37;

LAB39:    t5 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t5) = 1;

LAB40:    t11 = (t19 + 4);
    t22 = *((unsigned int *)t11);
    t23 = (~(t22));
    t24 = *((unsigned int *)t19);
    t25 = (t24 & t23);
    t26 = (t25 != 0);
    if (t26 > 0)
        goto LAB41;

LAB42:
LAB43:    goto LAB14;

LAB16:    *((unsigned int *)t19) = 1;
    goto LAB18;

LAB17:    t29 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB18;

LAB19:    t45 = *((unsigned int *)t33);
    t46 = *((unsigned int *)t39);
    *((unsigned int *)t33) = (t45 | t46);
    t47 = (t19 + 4);
    t48 = (t32 + 4);
    t49 = *((unsigned int *)t47);
    t50 = (~(t49));
    t51 = *((unsigned int *)t19);
    t52 = (t51 & t50);
    t53 = *((unsigned int *)t48);
    t54 = (~(t53));
    t55 = *((unsigned int *)t32);
    t56 = (t55 & t54);
    t57 = (~(t52));
    t58 = (~(t56));
    t59 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t59 & t57);
    t60 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t60 & t58);
    goto LAB21;

LAB22:    t73 = *((unsigned int *)t61);
    t74 = *((unsigned int *)t67);
    *((unsigned int *)t61) = (t73 | t74);
    t75 = (t12 + 4);
    t76 = (t33 + 4);
    t77 = *((unsigned int *)t12);
    t78 = (~(t77));
    t79 = *((unsigned int *)t75);
    t80 = (~(t79));
    t81 = *((unsigned int *)t33);
    t82 = (~(t81));
    t83 = *((unsigned int *)t76);
    t84 = (~(t83));
    t85 = (t78 & t80);
    t86 = (t82 & t84);
    t87 = (~(t85));
    t88 = (~(t86));
    t89 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t89 & t87);
    t90 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t90 & t88);
    t91 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t91 & t87);
    t92 = *((unsigned int *)t61);
    *((unsigned int *)t61) = (t92 & t88);
    goto LAB24;

LAB25:    xsi_set_current_line(79, ng0);

LAB28:    xsi_set_current_line(80, ng0);
    t99 = ((char*)((ng3)));
    t100 = (t0 + 1688);
    xsi_vlogvar_assign_value(t100, t99, 0, 0, 1);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 2056);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = (t0 + 2056);
    t12 = (t11 + 44U);
    t14 = *((char **)t12);
    t15 = (t0 + 2056);
    t16 = (t15 + 40U);
    t17 = *((char **)t16);
    t18 = (t0 + 2240);
    t20 = (t18 + 36U);
    t21 = *((char **)t20);
    xsi_vlog_generic_get_array_select_value(t19, 2, t5, t14, t17, 2, 1, t21, 2, 2);
    t29 = (t0 + 1780);
    xsi_vlogvar_wait_assign_value(t29, t19, 0, 0, 1, 0LL);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2240);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng2)));
    memset(t19, 0, 8);
    xsi_vlog_unsigned_add(t19, 32, t5, 2, t11, 32);
    t12 = (t0 + 2240);
    xsi_vlogvar_assign_value(t12, t19, 0, 0, 2);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 2240);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng4)));
    memset(t19, 0, 8);
    t12 = (t5 + 4);
    t14 = (t11 + 4);
    t6 = *((unsigned int *)t5);
    t7 = *((unsigned int *)t11);
    t8 = (t6 ^ t7);
    t9 = *((unsigned int *)t12);
    t10 = *((unsigned int *)t14);
    t22 = (t9 ^ t10);
    t23 = (t8 | t22);
    t24 = *((unsigned int *)t12);
    t25 = *((unsigned int *)t14);
    t26 = (t24 | t25);
    t27 = (~(t26));
    t28 = (t23 & t27);
    if (t28 != 0)
        goto LAB32;

LAB29:    if (t26 != 0)
        goto LAB31;

LAB30:    *((unsigned int *)t19) = 1;

LAB32:    t16 = (t19 + 4);
    t34 = *((unsigned int *)t16);
    t35 = (~(t34));
    t36 = *((unsigned int *)t19);
    t40 = (t36 & t35);
    t41 = (t40 != 0);
    if (t41 > 0)
        goto LAB33;

LAB34:
LAB35:    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1964);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB27;

LAB31:    t15 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB32;

LAB33:    xsi_set_current_line(83, ng0);
    t17 = ((char*)((ng1)));
    t18 = (t0 + 2424);
    xsi_vlogvar_wait_assign_value(t18, t17, 0, 0, 1, 0LL);
    goto LAB35;

LAB37:    *((unsigned int *)t19) = 1;
    goto LAB40;

LAB41:    xsi_set_current_line(89, ng0);
    t12 = ((char*)((ng1)));
    t14 = (t0 + 1964);
    xsi_vlogvar_wait_assign_value(t14, t12, 0, 0, 1, 0LL);
    goto LAB43;

}


extern void work_m_00000000002884549867_0567932728_init()
{
	static char *pe[] = {(void *)Always_32_0,(void *)Always_65_1};
	xsi_register_didat("work_m_00000000002884549867_0567932728", "isim/PushPullFIFO_tb_isim_beh.exe.sim/work/m_00000000002884549867_0567932728.didat");
	xsi_register_executes(pe);
}
