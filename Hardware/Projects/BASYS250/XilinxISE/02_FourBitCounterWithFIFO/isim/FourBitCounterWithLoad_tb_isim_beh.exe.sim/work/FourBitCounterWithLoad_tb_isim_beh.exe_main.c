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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001159314618_3137521270_init();
    work_m_00000000000664306850_3540764522_init();
    work_m_00000000002271102260_3907627161_init();
    work_m_00000000003858840456_1312087149_init();
    work_m_00000000002491283195_0588436685_init();
    work_m_00000000001498428617_0146718259_init();
    work_m_00000000002392357982_1243156275_init();
    work_m_00000000002110360920_3289906315_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002110360920_3289906315");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
