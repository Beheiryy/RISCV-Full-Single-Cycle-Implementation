/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_2206(char*, char *);
IKI_DLLESPEC extern void execute_2207(char*, char *);
IKI_DLLESPEC extern void execute_3765(char*, char *);
IKI_DLLESPEC extern void execute_3766(char*, char *);
IKI_DLLESPEC extern void execute_2213(char*, char *);
IKI_DLLESPEC extern void execute_2406(char*, char *);
IKI_DLLESPEC extern void execute_2912(char*, char *);
IKI_DLLESPEC extern void execute_2913(char*, char *);
IKI_DLLESPEC extern void execute_2930(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_3342(char*, char *);
IKI_DLLESPEC extern void execute_3679(char*, char *);
IKI_DLLESPEC extern void execute_3680(char*, char *);
IKI_DLLESPEC extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
IKI_DLLESPEC extern void execute_3682(char*, char *);
IKI_DLLESPEC extern void execute_3684(char*, char *);
IKI_DLLESPEC extern void execute_3686(char*, char *);
IKI_DLLESPEC extern void execute_3689(char*, char *);
IKI_DLLESPEC extern void execute_3691(char*, char *);
IKI_DLLESPEC extern void execute_3693(char*, char *);
IKI_DLLESPEC extern void execute_3695(char*, char *);
IKI_DLLESPEC extern void execute_3697(char*, char *);
IKI_DLLESPEC extern void execute_3699(char*, char *);
IKI_DLLESPEC extern void execute_3701(char*, char *);
IKI_DLLESPEC extern void execute_3703(char*, char *);
IKI_DLLESPEC extern void execute_3705(char*, char *);
IKI_DLLESPEC extern void execute_3707(char*, char *);
IKI_DLLESPEC extern void execute_3709(char*, char *);
IKI_DLLESPEC extern void execute_3711(char*, char *);
IKI_DLLESPEC extern void execute_3713(char*, char *);
IKI_DLLESPEC extern void execute_3715(char*, char *);
IKI_DLLESPEC extern void execute_3718(char*, char *);
IKI_DLLESPEC extern void execute_3720(char*, char *);
IKI_DLLESPEC extern void execute_3722(char*, char *);
IKI_DLLESPEC extern void execute_3724(char*, char *);
IKI_DLLESPEC extern void execute_3725(char*, char *);
IKI_DLLESPEC extern void execute_3727(char*, char *);
IKI_DLLESPEC extern void execute_3729(char*, char *);
IKI_DLLESPEC extern void execute_3731(char*, char *);
IKI_DLLESPEC extern void execute_3733(char*, char *);
IKI_DLLESPEC extern void execute_3735(char*, char *);
IKI_DLLESPEC extern void execute_3737(char*, char *);
IKI_DLLESPEC extern void execute_3739(char*, char *);
IKI_DLLESPEC extern void execute_3741(char*, char *);
IKI_DLLESPEC extern void execute_3743(char*, char *);
IKI_DLLESPEC extern void execute_3745(char*, char *);
IKI_DLLESPEC extern void execute_3747(char*, char *);
IKI_DLLESPEC extern void execute_3748(char*, char *);
IKI_DLLESPEC extern void execute_3749(char*, char *);
IKI_DLLESPEC extern void execute_3758(char*, char *);
IKI_DLLESPEC extern void execute_3759(char*, char *);
IKI_DLLESPEC extern void execute_3760(char*, char *);
IKI_DLLESPEC extern void execute_3761(char*, char *);
IKI_DLLESPEC extern void execute_3762(char*, char *);
IKI_DLLESPEC extern void execute_3763(char*, char *);
IKI_DLLESPEC extern void execute_3764(char*, char *);
IKI_DLLESPEC extern void execute_2246(char*, char *);
IKI_DLLESPEC extern void execute_2247(char*, char *);
IKI_DLLESPEC extern void execute_2248(char*, char *);
IKI_DLLESPEC extern void execute_2249(char*, char *);
IKI_DLLESPEC extern void execute_2250(char*, char *);
IKI_DLLESPEC extern void execute_2251(char*, char *);
IKI_DLLESPEC extern void execute_2252(char*, char *);
IKI_DLLESPEC extern void execute_2253(char*, char *);
IKI_DLLESPEC extern void execute_2254(char*, char *);
IKI_DLLESPEC extern void execute_2255(char*, char *);
IKI_DLLESPEC extern void execute_2256(char*, char *);
IKI_DLLESPEC extern void execute_2257(char*, char *);
IKI_DLLESPEC extern void execute_2258(char*, char *);
IKI_DLLESPEC extern void execute_2259(char*, char *);
IKI_DLLESPEC extern void execute_2260(char*, char *);
IKI_DLLESPEC extern void execute_2261(char*, char *);
IKI_DLLESPEC extern void execute_2262(char*, char *);
IKI_DLLESPEC extern void execute_2263(char*, char *);
IKI_DLLESPEC extern void execute_2264(char*, char *);
IKI_DLLESPEC extern void execute_2265(char*, char *);
IKI_DLLESPEC extern void execute_2266(char*, char *);
IKI_DLLESPEC extern void execute_2267(char*, char *);
IKI_DLLESPEC extern void execute_2268(char*, char *);
IKI_DLLESPEC extern void execute_2269(char*, char *);
IKI_DLLESPEC extern void execute_2270(char*, char *);
IKI_DLLESPEC extern void execute_2271(char*, char *);
IKI_DLLESPEC extern void execute_2272(char*, char *);
IKI_DLLESPEC extern void execute_2273(char*, char *);
IKI_DLLESPEC extern void execute_2274(char*, char *);
IKI_DLLESPEC extern void execute_2275(char*, char *);
IKI_DLLESPEC extern void execute_2276(char*, char *);
IKI_DLLESPEC extern void execute_2277(char*, char *);
IKI_DLLESPEC extern void execute_2214(char*, char *);
IKI_DLLESPEC extern void execute_6(char*, char *);
IKI_DLLESPEC extern void execute_2342(char*, char *);
IKI_DLLESPEC extern void execute_2343(char*, char *);
IKI_DLLESPEC extern void execute_2344(char*, char *);
IKI_DLLESPEC extern void execute_2345(char*, char *);
IKI_DLLESPEC extern void execute_2346(char*, char *);
IKI_DLLESPEC extern void execute_2347(char*, char *);
IKI_DLLESPEC extern void execute_2348(char*, char *);
IKI_DLLESPEC extern void execute_2349(char*, char *);
IKI_DLLESPEC extern void execute_2350(char*, char *);
IKI_DLLESPEC extern void execute_2351(char*, char *);
IKI_DLLESPEC extern void execute_2352(char*, char *);
IKI_DLLESPEC extern void execute_2353(char*, char *);
IKI_DLLESPEC extern void execute_2354(char*, char *);
IKI_DLLESPEC extern void execute_2355(char*, char *);
IKI_DLLESPEC extern void execute_2356(char*, char *);
IKI_DLLESPEC extern void execute_2357(char*, char *);
IKI_DLLESPEC extern void execute_2358(char*, char *);
IKI_DLLESPEC extern void execute_2359(char*, char *);
IKI_DLLESPEC extern void execute_2360(char*, char *);
IKI_DLLESPEC extern void execute_2361(char*, char *);
IKI_DLLESPEC extern void execute_2362(char*, char *);
IKI_DLLESPEC extern void execute_2363(char*, char *);
IKI_DLLESPEC extern void execute_2364(char*, char *);
IKI_DLLESPEC extern void execute_2365(char*, char *);
IKI_DLLESPEC extern void execute_2366(char*, char *);
IKI_DLLESPEC extern void execute_2367(char*, char *);
IKI_DLLESPEC extern void execute_2368(char*, char *);
IKI_DLLESPEC extern void execute_2369(char*, char *);
IKI_DLLESPEC extern void execute_2370(char*, char *);
IKI_DLLESPEC extern void execute_2371(char*, char *);
IKI_DLLESPEC extern void execute_2372(char*, char *);
IKI_DLLESPEC extern void execute_2373(char*, char *);
IKI_DLLESPEC extern void execute_2374(char*, char *);
IKI_DLLESPEC extern void execute_2375(char*, char *);
IKI_DLLESPEC extern void execute_2376(char*, char *);
IKI_DLLESPEC extern void execute_2377(char*, char *);
IKI_DLLESPEC extern void execute_2378(char*, char *);
IKI_DLLESPEC extern void execute_2379(char*, char *);
IKI_DLLESPEC extern void execute_2380(char*, char *);
IKI_DLLESPEC extern void execute_2381(char*, char *);
IKI_DLLESPEC extern void execute_2382(char*, char *);
IKI_DLLESPEC extern void execute_2383(char*, char *);
IKI_DLLESPEC extern void execute_2384(char*, char *);
IKI_DLLESPEC extern void execute_2385(char*, char *);
IKI_DLLESPEC extern void execute_2386(char*, char *);
IKI_DLLESPEC extern void execute_2387(char*, char *);
IKI_DLLESPEC extern void execute_2388(char*, char *);
IKI_DLLESPEC extern void execute_2389(char*, char *);
IKI_DLLESPEC extern void execute_2390(char*, char *);
IKI_DLLESPEC extern void execute_2391(char*, char *);
IKI_DLLESPEC extern void execute_2392(char*, char *);
IKI_DLLESPEC extern void execute_2393(char*, char *);
IKI_DLLESPEC extern void execute_2394(char*, char *);
IKI_DLLESPEC extern void execute_2395(char*, char *);
IKI_DLLESPEC extern void execute_2396(char*, char *);
IKI_DLLESPEC extern void execute_2397(char*, char *);
IKI_DLLESPEC extern void execute_2398(char*, char *);
IKI_DLLESPEC extern void execute_2399(char*, char *);
IKI_DLLESPEC extern void execute_2400(char*, char *);
IKI_DLLESPEC extern void execute_2401(char*, char *);
IKI_DLLESPEC extern void execute_2402(char*, char *);
IKI_DLLESPEC extern void execute_2403(char*, char *);
IKI_DLLESPEC extern void execute_2404(char*, char *);
IKI_DLLESPEC extern void execute_2405(char*, char *);
IKI_DLLESPEC extern void execute_2407(char*, char *);
IKI_DLLESPEC extern void execute_2408(char*, char *);
IKI_DLLESPEC extern void execute_2409(char*, char *);
IKI_DLLESPEC extern void execute_2410(char*, char *);
IKI_DLLESPEC extern void execute_2411(char*, char *);
IKI_DLLESPEC extern void execute_2412(char*, char *);
IKI_DLLESPEC extern void execute_2413(char*, char *);
IKI_DLLESPEC extern void execute_2414(char*, char *);
IKI_DLLESPEC extern void execute_2415(char*, char *);
IKI_DLLESPEC extern void execute_2416(char*, char *);
IKI_DLLESPEC extern void execute_2417(char*, char *);
IKI_DLLESPEC extern void execute_2418(char*, char *);
IKI_DLLESPEC extern void execute_295(char*, char *);
IKI_DLLESPEC extern void execute_2419(char*, char *);
IKI_DLLESPEC extern void execute_298(char*, char *);
IKI_DLLESPEC extern void execute_2420(char*, char *);
IKI_DLLESPEC extern void execute_2421(char*, char *);
IKI_DLLESPEC extern void execute_2871(char*, char *);
IKI_DLLESPEC extern void execute_2886(char*, char *);
IKI_DLLESPEC extern void execute_2887(char*, char *);
IKI_DLLESPEC extern void execute_2897(char*, char *);
IKI_DLLESPEC extern void execute_2898(char*, char *);
IKI_DLLESPEC extern void execute_2899(char*, char *);
IKI_DLLESPEC extern void execute_2900(char*, char *);
IKI_DLLESPEC extern void execute_2901(char*, char *);
IKI_DLLESPEC extern void execute_1053(char*, char *);
IKI_DLLESPEC extern void execute_1055(char*, char *);
IKI_DLLESPEC extern void execute_1057(char*, char *);
IKI_DLLESPEC extern void execute_2914(char*, char *);
IKI_DLLESPEC extern void execute_2915(char*, char *);
IKI_DLLESPEC extern void execute_2918(char*, char *);
IKI_DLLESPEC extern void execute_2919(char*, char *);
IKI_DLLESPEC extern void execute_2920(char*, char *);
IKI_DLLESPEC extern void execute_2921(char*, char *);
IKI_DLLESPEC extern void execute_2922(char*, char *);
IKI_DLLESPEC extern void execute_2923(char*, char *);
IKI_DLLESPEC extern void execute_2924(char*, char *);
IKI_DLLESPEC extern void execute_2925(char*, char *);
IKI_DLLESPEC extern void execute_2926(char*, char *);
IKI_DLLESPEC extern void execute_2927(char*, char *);
IKI_DLLESPEC extern void execute_2928(char*, char *);
IKI_DLLESPEC extern void execute_2929(char*, char *);
IKI_DLLESPEC extern void execute_1059(char*, char *);
IKI_DLLESPEC extern void execute_1690(char*, char *);
IKI_DLLESPEC extern void execute_1691(char*, char *);
IKI_DLLESPEC extern void execute_1692(char*, char *);
IKI_DLLESPEC extern void execute_1693(char*, char *);
IKI_DLLESPEC extern void execute_2209(char*, char *);
IKI_DLLESPEC extern void execute_2210(char*, char *);
IKI_DLLESPEC extern void execute_2211(char*, char *);
IKI_DLLESPEC extern void execute_2212(char*, char *);
IKI_DLLESPEC extern void execute_3767(char*, char *);
IKI_DLLESPEC extern void execute_3768(char*, char *);
IKI_DLLESPEC extern void execute_3769(char*, char *);
IKI_DLLESPEC extern void execute_3770(char*, char *);
IKI_DLLESPEC extern void execute_3771(char*, char *);
IKI_DLLESPEC extern void execute_3772(char*, char *);
IKI_DLLESPEC extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_7(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_8(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_10(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[216] = {(funcp)execute_2206, (funcp)execute_2207, (funcp)execute_3765, (funcp)execute_3766, (funcp)execute_2213, (funcp)execute_2406, (funcp)execute_2912, (funcp)execute_2913, (funcp)execute_2930, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_3342, (funcp)execute_3679, (funcp)execute_3680, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_3682, (funcp)execute_3684, (funcp)execute_3686, (funcp)execute_3689, (funcp)execute_3691, (funcp)execute_3693, (funcp)execute_3695, (funcp)execute_3697, (funcp)execute_3699, (funcp)execute_3701, (funcp)execute_3703, (funcp)execute_3705, (funcp)execute_3707, (funcp)execute_3709, (funcp)execute_3711, (funcp)execute_3713, (funcp)execute_3715, (funcp)execute_3718, (funcp)execute_3720, (funcp)execute_3722, (funcp)execute_3724, (funcp)execute_3725, (funcp)execute_3727, (funcp)execute_3729, (funcp)execute_3731, (funcp)execute_3733, (funcp)execute_3735, (funcp)execute_3737, (funcp)execute_3739, (funcp)execute_3741, (funcp)execute_3743, (funcp)execute_3745, (funcp)execute_3747, (funcp)execute_3748, (funcp)execute_3749, (funcp)execute_3758, (funcp)execute_3759, (funcp)execute_3760, (funcp)execute_3761, (funcp)execute_3762, (funcp)execute_3763, (funcp)execute_3764, (funcp)execute_2246, (funcp)execute_2247, (funcp)execute_2248, (funcp)execute_2249, (funcp)execute_2250, (funcp)execute_2251, (funcp)execute_2252, (funcp)execute_2253, (funcp)execute_2254, (funcp)execute_2255, (funcp)execute_2256, (funcp)execute_2257, (funcp)execute_2258, (funcp)execute_2259, (funcp)execute_2260, (funcp)execute_2261, (funcp)execute_2262, (funcp)execute_2263, (funcp)execute_2264, (funcp)execute_2265, (funcp)execute_2266, (funcp)execute_2267, (funcp)execute_2268, (funcp)execute_2269, (funcp)execute_2270, (funcp)execute_2271, (funcp)execute_2272, (funcp)execute_2273, (funcp)execute_2274, (funcp)execute_2275, (funcp)execute_2276, (funcp)execute_2277, (funcp)execute_2214, (funcp)execute_6, (funcp)execute_2342, (funcp)execute_2343, (funcp)execute_2344, (funcp)execute_2345, (funcp)execute_2346, (funcp)execute_2347, (funcp)execute_2348, (funcp)execute_2349, (funcp)execute_2350, (funcp)execute_2351, (funcp)execute_2352, (funcp)execute_2353, (funcp)execute_2354, (funcp)execute_2355, (funcp)execute_2356, (funcp)execute_2357, (funcp)execute_2358, (funcp)execute_2359, (funcp)execute_2360, (funcp)execute_2361, (funcp)execute_2362, (funcp)execute_2363, (funcp)execute_2364, (funcp)execute_2365, (funcp)execute_2366, (funcp)execute_2367, (funcp)execute_2368, (funcp)execute_2369, (funcp)execute_2370, (funcp)execute_2371, (funcp)execute_2372, (funcp)execute_2373, (funcp)execute_2374, (funcp)execute_2375, (funcp)execute_2376, (funcp)execute_2377, (funcp)execute_2378, (funcp)execute_2379, (funcp)execute_2380, (funcp)execute_2381, (funcp)execute_2382, (funcp)execute_2383, (funcp)execute_2384, (funcp)execute_2385, (funcp)execute_2386, (funcp)execute_2387, (funcp)execute_2388, (funcp)execute_2389, (funcp)execute_2390, (funcp)execute_2391, (funcp)execute_2392, (funcp)execute_2393, (funcp)execute_2394, (funcp)execute_2395, (funcp)execute_2396, (funcp)execute_2397, (funcp)execute_2398, (funcp)execute_2399, (funcp)execute_2400, (funcp)execute_2401, (funcp)execute_2402, (funcp)execute_2403, (funcp)execute_2404, (funcp)execute_2405, (funcp)execute_2407, (funcp)execute_2408, (funcp)execute_2409, (funcp)execute_2410, (funcp)execute_2411, (funcp)execute_2412, (funcp)execute_2413, (funcp)execute_2414, (funcp)execute_2415, (funcp)execute_2416, (funcp)execute_2417, (funcp)execute_2418, (funcp)execute_295, (funcp)execute_2419, (funcp)execute_298, (funcp)execute_2420, (funcp)execute_2421, (funcp)execute_2871, (funcp)execute_2886, (funcp)execute_2887, (funcp)execute_2897, (funcp)execute_2898, (funcp)execute_2899, (funcp)execute_2900, (funcp)execute_2901, (funcp)execute_1053, (funcp)execute_1055, (funcp)execute_1057, (funcp)execute_2914, (funcp)execute_2915, (funcp)execute_2918, (funcp)execute_2919, (funcp)execute_2920, (funcp)execute_2921, (funcp)execute_2922, (funcp)execute_2923, (funcp)execute_2924, (funcp)execute_2925, (funcp)execute_2926, (funcp)execute_2927, (funcp)execute_2928, (funcp)execute_2929, (funcp)execute_1059, (funcp)execute_1690, (funcp)execute_1691, (funcp)execute_1692, (funcp)execute_1693, (funcp)execute_2209, (funcp)execute_2210, (funcp)execute_2211, (funcp)execute_2212, (funcp)execute_3767, (funcp)execute_3768, (funcp)execute_3769, (funcp)execute_3770, (funcp)execute_3771, (funcp)execute_3772, (funcp)transaction_4, (funcp)transaction_7, (funcp)transaction_8, (funcp)transaction_10, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 216;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cpu_tb_behav/xsim.reloc",  (void **)funcTab, 216);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/cpu_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/cpu_tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/cpu_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/cpu_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/cpu_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
