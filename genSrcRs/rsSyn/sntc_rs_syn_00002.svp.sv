/* verilator lint_off DECLFILENAME */
(* keep_hierarchy = "yes" *) (* keep = "true" *) module  sntc_rs_syn_00002#(
 parameter  PARAM_m = 6,
 parameter  PARAM_nn1 = 63,
 parameter  PARAM_reduced_n = 63,
 parameter  PARAM_k = 53,
 parameter  PARAM_t = 5,
 parameter  PARAM_t2 = 10,
 parameter  PARAM_d = 11,
 parameter  PARAM_w = 6
) (

input wire [PARAM_w-1:0] bb0,  // has to be 1 or greater
                               // can not be 0x0 and less than 0
                               // or greater than or equal to (1<<'m')
input wire [PARAM_w-1:0] rsData_00000,
input wire [PARAM_w-1:0] rsData_00001,
input wire [PARAM_w-1:0] rsData_00002,
input wire [PARAM_w-1:0] rsData_00003,
input wire [PARAM_w-1:0] rsData_00004,
input wire [PARAM_w-1:0] rsData_00005,
input wire [PARAM_w-1:0] rsData_00006,
input wire [PARAM_w-1:0] rsData_00007,
input wire [PARAM_w-1:0] rsData_00008,
input wire [PARAM_w-1:0] rsData_00009,
input wire [PARAM_w-1:0] rsData_00010,
input wire [PARAM_w-1:0] rsData_00011,
input wire [PARAM_w-1:0] rsData_00012,
input wire [PARAM_w-1:0] rsData_00013,
input wire [PARAM_w-1:0] rsData_00014,
input wire [PARAM_w-1:0] rsData_00015,
input wire [PARAM_w-1:0] rsData_00016,
input wire [PARAM_w-1:0] rsData_00017,
input wire [PARAM_w-1:0] rsData_00018,
input wire [PARAM_w-1:0] rsData_00019,
input wire [PARAM_w-1:0] rsData_00020,
input wire [PARAM_w-1:0] rsData_00021,
input wire [PARAM_w-1:0] rsData_00022,
input wire [PARAM_w-1:0] rsData_00023,
input wire [PARAM_w-1:0] rsData_00024,
input wire [PARAM_w-1:0] rsData_00025,
input wire [PARAM_w-1:0] rsData_00026,
input wire [PARAM_w-1:0] rsData_00027,
input wire [PARAM_w-1:0] rsData_00028,
input wire [PARAM_w-1:0] rsData_00029,
input wire [PARAM_w-1:0] rsData_00030,
input wire [PARAM_w-1:0] rsData_00031,
input wire [PARAM_w-1:0] rsData_00032,
input wire [PARAM_w-1:0] rsData_00033,
input wire [PARAM_w-1:0] rsData_00034,
input wire [PARAM_w-1:0] rsData_00035,
input wire [PARAM_w-1:0] rsData_00036,
input wire [PARAM_w-1:0] rsData_00037,
input wire [PARAM_w-1:0] rsData_00038,
input wire [PARAM_w-1:0] rsData_00039,
input wire [PARAM_w-1:0] rsData_00040,
input wire [PARAM_w-1:0] rsData_00041,
input wire [PARAM_w-1:0] rsData_00042,
input wire [PARAM_w-1:0] rsData_00043,
input wire [PARAM_w-1:0] rsData_00044,
input wire [PARAM_w-1:0] rsData_00045,
input wire [PARAM_w-1:0] rsData_00046,
input wire [PARAM_w-1:0] rsData_00047,
input wire [PARAM_w-1:0] rsData_00048,
input wire [PARAM_w-1:0] rsData_00049,
input wire [PARAM_w-1:0] rsData_00050,
input wire [PARAM_w-1:0] rsData_00051,
input wire [PARAM_w-1:0] rsData_00052,
input wire [PARAM_w-1:0] rsData_00053,
input wire [PARAM_w-1:0] rsData_00054,
input wire [PARAM_w-1:0] rsData_00055,
input wire [PARAM_w-1:0] rsData_00056,
input wire [PARAM_w-1:0] rsData_00057,

input wire [31:0] token_i,
output wire [31:0] token_o,


output wire  [PARAM_w-1:0] rsSyn_00002,

input wire rstn,
input wire clr,

input wire clk
);

// BEGIN: local params
localparam u_w = $clog2(PARAM_t2+1);

assign token_o = token_i;

wire [PARAM_w-1:0] data_ggSyn_00000;
wire [PARAM_w-1:0] data_ggSyn_00001;
wire [PARAM_w-1:0] data_ggSyn_00002;
wire [PARAM_w-1:0] data_ggSyn_00003;
wire [PARAM_w-1:0] data_ggSyn_00004;
wire [PARAM_w-1:0] data_ggSyn_00005;
wire [PARAM_w-1:0] data_ggSyn_00006;
wire [PARAM_w-1:0] data_ggSyn_00007;
wire [PARAM_w-1:0] data_ggSyn_00008;
wire [PARAM_w-1:0] data_ggSyn_00009;
wire [PARAM_w-1:0] data_ggSyn_00010;
wire [PARAM_w-1:0] data_ggSyn_00011;
wire [PARAM_w-1:0] data_ggSyn_00012;
wire [PARAM_w-1:0] data_ggSyn_00013;
wire [PARAM_w-1:0] data_ggSyn_00014;
wire [PARAM_w-1:0] data_ggSyn_00015;
wire [PARAM_w-1:0] data_ggSyn_00016;
wire [PARAM_w-1:0] data_ggSyn_00017;
wire [PARAM_w-1:0] data_ggSyn_00018;
wire [PARAM_w-1:0] data_ggSyn_00019;
wire [PARAM_w-1:0] data_ggSyn_00020;
wire [PARAM_w-1:0] data_ggSyn_00021;
wire [PARAM_w-1:0] data_ggSyn_00022;
wire [PARAM_w-1:0] data_ggSyn_00023;
wire [PARAM_w-1:0] data_ggSyn_00024;
wire [PARAM_w-1:0] data_ggSyn_00025;
wire [PARAM_w-1:0] data_ggSyn_00026;
wire [PARAM_w-1:0] data_ggSyn_00027;
wire [PARAM_w-1:0] data_ggSyn_00028;
wire [PARAM_w-1:0] data_ggSyn_00029;
wire [PARAM_w-1:0] data_ggSyn_00030;
wire [PARAM_w-1:0] data_ggSyn_00031;
wire [PARAM_w-1:0] data_ggSyn_00032;
wire [PARAM_w-1:0] data_ggSyn_00033;
wire [PARAM_w-1:0] data_ggSyn_00034;
wire [PARAM_w-1:0] data_ggSyn_00035;
wire [PARAM_w-1:0] data_ggSyn_00036;
wire [PARAM_w-1:0] data_ggSyn_00037;
wire [PARAM_w-1:0] data_ggSyn_00038;
wire [PARAM_w-1:0] data_ggSyn_00039;
wire [PARAM_w-1:0] data_ggSyn_00040;
wire [PARAM_w-1:0] data_ggSyn_00041;
wire [PARAM_w-1:0] data_ggSyn_00042;
wire [PARAM_w-1:0] data_ggSyn_00043;
wire [PARAM_w-1:0] data_ggSyn_00044;
wire [PARAM_w-1:0] data_ggSyn_00045;
wire [PARAM_w-1:0] data_ggSyn_00046;
wire [PARAM_w-1:0] data_ggSyn_00047;
wire [PARAM_w-1:0] data_ggSyn_00048;
wire [PARAM_w-1:0] data_ggSyn_00049;
wire [PARAM_w-1:0] data_ggSyn_00050;
wire [PARAM_w-1:0] data_ggSyn_00051;
wire [PARAM_w-1:0] data_ggSyn_00052;
wire [PARAM_w-1:0] data_ggSyn_00053;
wire [PARAM_w-1:0] data_ggSyn_00054;
wire [PARAM_w-1:0] data_ggSyn_00055;
wire [PARAM_w-1:0] data_ggSyn_00056;
wire [PARAM_w-1:0] data_ggSyn_00057;

wire [3*PARAM_w-1:0] bb0WithI_00002;  //has to be 1 or greater

                  wire [PARAM_w-1:0] ggSyn_00000_00002;
                  wire [PARAM_w-1:0] ggSyn_00001_00002;
                  wire [PARAM_w-1:0] ggSyn_00002_00002;
                  wire [PARAM_w-1:0] ggSyn_00003_00002;
                  wire [PARAM_w-1:0] ggSyn_00004_00002;
                  wire [PARAM_w-1:0] ggSyn_00005_00002;
                  wire [PARAM_w-1:0] ggSyn_00006_00002;
                  wire [PARAM_w-1:0] ggSyn_00007_00002;
                  wire [PARAM_w-1:0] ggSyn_00008_00002;
                  wire [PARAM_w-1:0] ggSyn_00009_00002;
                  wire [PARAM_w-1:0] ggSyn_00010_00002;
                  wire [PARAM_w-1:0] ggSyn_00011_00002;
                  wire [PARAM_w-1:0] ggSyn_00012_00002;
                  wire [PARAM_w-1:0] ggSyn_00013_00002;
                  wire [PARAM_w-1:0] ggSyn_00014_00002;
                  wire [PARAM_w-1:0] ggSyn_00015_00002;
                  wire [PARAM_w-1:0] ggSyn_00016_00002;
                  wire [PARAM_w-1:0] ggSyn_00017_00002;
                  wire [PARAM_w-1:0] ggSyn_00018_00002;
                  wire [PARAM_w-1:0] ggSyn_00019_00002;
                  wire [PARAM_w-1:0] ggSyn_00020_00002;
                  wire [PARAM_w-1:0] ggSyn_00021_00002;
                  wire [PARAM_w-1:0] ggSyn_00022_00002;
                  wire [PARAM_w-1:0] ggSyn_00023_00002;
                  wire [PARAM_w-1:0] ggSyn_00024_00002;
                  wire [PARAM_w-1:0] ggSyn_00025_00002;
                  wire [PARAM_w-1:0] ggSyn_00026_00002;
                  wire [PARAM_w-1:0] ggSyn_00027_00002;
                  wire [PARAM_w-1:0] ggSyn_00028_00002;
                  wire [PARAM_w-1:0] ggSyn_00029_00002;
                  wire [PARAM_w-1:0] ggSyn_00030_00002;
                  wire [PARAM_w-1:0] ggSyn_00031_00002;
                  wire [PARAM_w-1:0] ggSyn_00032_00002;
                  wire [PARAM_w-1:0] ggSyn_00033_00002;
                  wire [PARAM_w-1:0] ggSyn_00034_00002;
                  wire [PARAM_w-1:0] ggSyn_00035_00002;
                  wire [PARAM_w-1:0] ggSyn_00036_00002;
                  wire [PARAM_w-1:0] ggSyn_00037_00002;
                  wire [PARAM_w-1:0] ggSyn_00038_00002;
                  wire [PARAM_w-1:0] ggSyn_00039_00002;
                  wire [PARAM_w-1:0] ggSyn_00040_00002;
                  wire [PARAM_w-1:0] ggSyn_00041_00002;
                  wire [PARAM_w-1:0] ggSyn_00042_00002;
                  wire [PARAM_w-1:0] ggSyn_00043_00002;
                  wire [PARAM_w-1:0] ggSyn_00044_00002;
                  wire [PARAM_w-1:0] ggSyn_00045_00002;
                  wire [PARAM_w-1:0] ggSyn_00046_00002;
                  wire [PARAM_w-1:0] ggSyn_00047_00002;
                  wire [PARAM_w-1:0] ggSyn_00048_00002;
                  wire [PARAM_w-1:0] ggSyn_00049_00002;
                  wire [PARAM_w-1:0] ggSyn_00050_00002;
                  wire [PARAM_w-1:0] ggSyn_00051_00002;
                  wire [PARAM_w-1:0] ggSyn_00052_00002;
                  wire [PARAM_w-1:0] ggSyn_00053_00002;
                  wire [PARAM_w-1:0] ggSyn_00054_00002;
                  wire [PARAM_w-1:0] ggSyn_00055_00002;
                  wire [PARAM_w-1:0] ggSyn_00056_00002;
                  wire [PARAM_w-1:0] ggSyn_00057_00002;

assign rsSyn_00002 =
    data_ggSyn_00000 ^
    data_ggSyn_00001 ^
    data_ggSyn_00002 ^
    data_ggSyn_00003 ^
    data_ggSyn_00004 ^
    data_ggSyn_00005 ^
    data_ggSyn_00006 ^
    data_ggSyn_00007 ^
    data_ggSyn_00008 ^
    data_ggSyn_00009 ^
    data_ggSyn_00010 ^
    data_ggSyn_00011 ^
    data_ggSyn_00012 ^
    data_ggSyn_00013 ^
    data_ggSyn_00014 ^
    data_ggSyn_00015 ^
    data_ggSyn_00016 ^
    data_ggSyn_00017 ^
    data_ggSyn_00018 ^
    data_ggSyn_00019 ^
    data_ggSyn_00020 ^
    data_ggSyn_00021 ^
    data_ggSyn_00022 ^
    data_ggSyn_00023 ^
    data_ggSyn_00024 ^
    data_ggSyn_00025 ^
    data_ggSyn_00026 ^
    data_ggSyn_00027 ^
    data_ggSyn_00028 ^
    data_ggSyn_00029 ^
    data_ggSyn_00030 ^
    data_ggSyn_00031 ^
    data_ggSyn_00032 ^
    data_ggSyn_00033 ^
    data_ggSyn_00034 ^
    data_ggSyn_00035 ^
    data_ggSyn_00036 ^
    data_ggSyn_00037 ^
    data_ggSyn_00038 ^
    data_ggSyn_00039 ^
    data_ggSyn_00040 ^
    data_ggSyn_00041 ^
    data_ggSyn_00042 ^
    data_ggSyn_00043 ^
    data_ggSyn_00044 ^
    data_ggSyn_00045 ^
    data_ggSyn_00046 ^
    data_ggSyn_00047 ^
    data_ggSyn_00048 ^
    data_ggSyn_00049 ^
    data_ggSyn_00050 ^
    data_ggSyn_00051 ^
    data_ggSyn_00052 ^
    data_ggSyn_00053 ^
    data_ggSyn_00054 ^
    data_ggSyn_00055 ^
    data_ggSyn_00056 ^
    data_ggSyn_00057 ^
    0;

assign token_o = token_i;



 PowcrcMult gfMult_t_00002_00000 (
                   .prdct_z(data_ggSyn_00000 ),
                   .fact_a(rsData_00000),
                   .fact_b(ggSyn_00000_00002)
                  );



 PowcrcMult gfMult_t_00002_00001 (
                   .prdct_z(data_ggSyn_00001 ),
                   .fact_a(rsData_00001),
                   .fact_b(ggSyn_00001_00002)
                  );



 PowcrcMult gfMult_t_00002_00002 (
                   .prdct_z(data_ggSyn_00002 ),
                   .fact_a(rsData_00002),
                   .fact_b(ggSyn_00002_00002)
                  );



 PowcrcMult gfMult_t_00002_00003 (
                   .prdct_z(data_ggSyn_00003 ),
                   .fact_a(rsData_00003),
                   .fact_b(ggSyn_00003_00002)
                  );



 PowcrcMult gfMult_t_00002_00004 (
                   .prdct_z(data_ggSyn_00004 ),
                   .fact_a(rsData_00004),
                   .fact_b(ggSyn_00004_00002)
                  );



 PowcrcMult gfMult_t_00002_00005 (
                   .prdct_z(data_ggSyn_00005 ),
                   .fact_a(rsData_00005),
                   .fact_b(ggSyn_00005_00002)
                  );



 PowcrcMult gfMult_t_00002_00006 (
                   .prdct_z(data_ggSyn_00006 ),
                   .fact_a(rsData_00006),
                   .fact_b(ggSyn_00006_00002)
                  );



 PowcrcMult gfMult_t_00002_00007 (
                   .prdct_z(data_ggSyn_00007 ),
                   .fact_a(rsData_00007),
                   .fact_b(ggSyn_00007_00002)
                  );



 PowcrcMult gfMult_t_00002_00008 (
                   .prdct_z(data_ggSyn_00008 ),
                   .fact_a(rsData_00008),
                   .fact_b(ggSyn_00008_00002)
                  );



 PowcrcMult gfMult_t_00002_00009 (
                   .prdct_z(data_ggSyn_00009 ),
                   .fact_a(rsData_00009),
                   .fact_b(ggSyn_00009_00002)
                  );



 PowcrcMult gfMult_t_00002_00010 (
                   .prdct_z(data_ggSyn_00010 ),
                   .fact_a(rsData_00010),
                   .fact_b(ggSyn_00010_00002)
                  );



 PowcrcMult gfMult_t_00002_00011 (
                   .prdct_z(data_ggSyn_00011 ),
                   .fact_a(rsData_00011),
                   .fact_b(ggSyn_00011_00002)
                  );



 PowcrcMult gfMult_t_00002_00012 (
                   .prdct_z(data_ggSyn_00012 ),
                   .fact_a(rsData_00012),
                   .fact_b(ggSyn_00012_00002)
                  );



 PowcrcMult gfMult_t_00002_00013 (
                   .prdct_z(data_ggSyn_00013 ),
                   .fact_a(rsData_00013),
                   .fact_b(ggSyn_00013_00002)
                  );



 PowcrcMult gfMult_t_00002_00014 (
                   .prdct_z(data_ggSyn_00014 ),
                   .fact_a(rsData_00014),
                   .fact_b(ggSyn_00014_00002)
                  );



 PowcrcMult gfMult_t_00002_00015 (
                   .prdct_z(data_ggSyn_00015 ),
                   .fact_a(rsData_00015),
                   .fact_b(ggSyn_00015_00002)
                  );



 PowcrcMult gfMult_t_00002_00016 (
                   .prdct_z(data_ggSyn_00016 ),
                   .fact_a(rsData_00016),
                   .fact_b(ggSyn_00016_00002)
                  );



 PowcrcMult gfMult_t_00002_00017 (
                   .prdct_z(data_ggSyn_00017 ),
                   .fact_a(rsData_00017),
                   .fact_b(ggSyn_00017_00002)
                  );



 PowcrcMult gfMult_t_00002_00018 (
                   .prdct_z(data_ggSyn_00018 ),
                   .fact_a(rsData_00018),
                   .fact_b(ggSyn_00018_00002)
                  );



 PowcrcMult gfMult_t_00002_00019 (
                   .prdct_z(data_ggSyn_00019 ),
                   .fact_a(rsData_00019),
                   .fact_b(ggSyn_00019_00002)
                  );



 PowcrcMult gfMult_t_00002_00020 (
                   .prdct_z(data_ggSyn_00020 ),
                   .fact_a(rsData_00020),
                   .fact_b(ggSyn_00020_00002)
                  );



 PowcrcMult gfMult_t_00002_00021 (
                   .prdct_z(data_ggSyn_00021 ),
                   .fact_a(rsData_00021),
                   .fact_b(ggSyn_00021_00002)
                  );



 PowcrcMult gfMult_t_00002_00022 (
                   .prdct_z(data_ggSyn_00022 ),
                   .fact_a(rsData_00022),
                   .fact_b(ggSyn_00022_00002)
                  );



 PowcrcMult gfMult_t_00002_00023 (
                   .prdct_z(data_ggSyn_00023 ),
                   .fact_a(rsData_00023),
                   .fact_b(ggSyn_00023_00002)
                  );



 PowcrcMult gfMult_t_00002_00024 (
                   .prdct_z(data_ggSyn_00024 ),
                   .fact_a(rsData_00024),
                   .fact_b(ggSyn_00024_00002)
                  );



 PowcrcMult gfMult_t_00002_00025 (
                   .prdct_z(data_ggSyn_00025 ),
                   .fact_a(rsData_00025),
                   .fact_b(ggSyn_00025_00002)
                  );



 PowcrcMult gfMult_t_00002_00026 (
                   .prdct_z(data_ggSyn_00026 ),
                   .fact_a(rsData_00026),
                   .fact_b(ggSyn_00026_00002)
                  );



 PowcrcMult gfMult_t_00002_00027 (
                   .prdct_z(data_ggSyn_00027 ),
                   .fact_a(rsData_00027),
                   .fact_b(ggSyn_00027_00002)
                  );



 PowcrcMult gfMult_t_00002_00028 (
                   .prdct_z(data_ggSyn_00028 ),
                   .fact_a(rsData_00028),
                   .fact_b(ggSyn_00028_00002)
                  );



 PowcrcMult gfMult_t_00002_00029 (
                   .prdct_z(data_ggSyn_00029 ),
                   .fact_a(rsData_00029),
                   .fact_b(ggSyn_00029_00002)
                  );



 PowcrcMult gfMult_t_00002_00030 (
                   .prdct_z(data_ggSyn_00030 ),
                   .fact_a(rsData_00030),
                   .fact_b(ggSyn_00030_00002)
                  );



 PowcrcMult gfMult_t_00002_00031 (
                   .prdct_z(data_ggSyn_00031 ),
                   .fact_a(rsData_00031),
                   .fact_b(ggSyn_00031_00002)
                  );



 PowcrcMult gfMult_t_00002_00032 (
                   .prdct_z(data_ggSyn_00032 ),
                   .fact_a(rsData_00032),
                   .fact_b(ggSyn_00032_00002)
                  );



 PowcrcMult gfMult_t_00002_00033 (
                   .prdct_z(data_ggSyn_00033 ),
                   .fact_a(rsData_00033),
                   .fact_b(ggSyn_00033_00002)
                  );



 PowcrcMult gfMult_t_00002_00034 (
                   .prdct_z(data_ggSyn_00034 ),
                   .fact_a(rsData_00034),
                   .fact_b(ggSyn_00034_00002)
                  );



 PowcrcMult gfMult_t_00002_00035 (
                   .prdct_z(data_ggSyn_00035 ),
                   .fact_a(rsData_00035),
                   .fact_b(ggSyn_00035_00002)
                  );



 PowcrcMult gfMult_t_00002_00036 (
                   .prdct_z(data_ggSyn_00036 ),
                   .fact_a(rsData_00036),
                   .fact_b(ggSyn_00036_00002)
                  );



 PowcrcMult gfMult_t_00002_00037 (
                   .prdct_z(data_ggSyn_00037 ),
                   .fact_a(rsData_00037),
                   .fact_b(ggSyn_00037_00002)
                  );



 PowcrcMult gfMult_t_00002_00038 (
                   .prdct_z(data_ggSyn_00038 ),
                   .fact_a(rsData_00038),
                   .fact_b(ggSyn_00038_00002)
                  );



 PowcrcMult gfMult_t_00002_00039 (
                   .prdct_z(data_ggSyn_00039 ),
                   .fact_a(rsData_00039),
                   .fact_b(ggSyn_00039_00002)
                  );



 PowcrcMult gfMult_t_00002_00040 (
                   .prdct_z(data_ggSyn_00040 ),
                   .fact_a(rsData_00040),
                   .fact_b(ggSyn_00040_00002)
                  );



 PowcrcMult gfMult_t_00002_00041 (
                   .prdct_z(data_ggSyn_00041 ),
                   .fact_a(rsData_00041),
                   .fact_b(ggSyn_00041_00002)
                  );



 PowcrcMult gfMult_t_00002_00042 (
                   .prdct_z(data_ggSyn_00042 ),
                   .fact_a(rsData_00042),
                   .fact_b(ggSyn_00042_00002)
                  );



 PowcrcMult gfMult_t_00002_00043 (
                   .prdct_z(data_ggSyn_00043 ),
                   .fact_a(rsData_00043),
                   .fact_b(ggSyn_00043_00002)
                  );



 PowcrcMult gfMult_t_00002_00044 (
                   .prdct_z(data_ggSyn_00044 ),
                   .fact_a(rsData_00044),
                   .fact_b(ggSyn_00044_00002)
                  );



 PowcrcMult gfMult_t_00002_00045 (
                   .prdct_z(data_ggSyn_00045 ),
                   .fact_a(rsData_00045),
                   .fact_b(ggSyn_00045_00002)
                  );



 PowcrcMult gfMult_t_00002_00046 (
                   .prdct_z(data_ggSyn_00046 ),
                   .fact_a(rsData_00046),
                   .fact_b(ggSyn_00046_00002)
                  );



 PowcrcMult gfMult_t_00002_00047 (
                   .prdct_z(data_ggSyn_00047 ),
                   .fact_a(rsData_00047),
                   .fact_b(ggSyn_00047_00002)
                  );



 PowcrcMult gfMult_t_00002_00048 (
                   .prdct_z(data_ggSyn_00048 ),
                   .fact_a(rsData_00048),
                   .fact_b(ggSyn_00048_00002)
                  );



 PowcrcMult gfMult_t_00002_00049 (
                   .prdct_z(data_ggSyn_00049 ),
                   .fact_a(rsData_00049),
                   .fact_b(ggSyn_00049_00002)
                  );



 PowcrcMult gfMult_t_00002_00050 (
                   .prdct_z(data_ggSyn_00050 ),
                   .fact_a(rsData_00050),
                   .fact_b(ggSyn_00050_00002)
                  );



 PowcrcMult gfMult_t_00002_00051 (
                   .prdct_z(data_ggSyn_00051 ),
                   .fact_a(rsData_00051),
                   .fact_b(ggSyn_00051_00002)
                  );



 PowcrcMult gfMult_t_00002_00052 (
                   .prdct_z(data_ggSyn_00052 ),
                   .fact_a(rsData_00052),
                   .fact_b(ggSyn_00052_00002)
                  );



 PowcrcMult gfMult_t_00002_00053 (
                   .prdct_z(data_ggSyn_00053 ),
                   .fact_a(rsData_00053),
                   .fact_b(ggSyn_00053_00002)
                  );



 PowcrcMult gfMult_t_00002_00054 (
                   .prdct_z(data_ggSyn_00054 ),
                   .fact_a(rsData_00054),
                   .fact_b(ggSyn_00054_00002)
                  );



 PowcrcMult gfMult_t_00002_00055 (
                   .prdct_z(data_ggSyn_00055 ),
                   .fact_a(rsData_00055),
                   .fact_b(ggSyn_00055_00002)
                  );



 PowcrcMult gfMult_t_00002_00056 (
                   .prdct_z(data_ggSyn_00056 ),
                   .fact_a(rsData_00056),
                   .fact_b(ggSyn_00056_00002)
                  );



 PowcrcMult gfMult_t_00002_00057 (
                   .prdct_z(data_ggSyn_00057 ),
                   .fact_a(rsData_00057),
                   .fact_b(ggSyn_00057_00002)
                  );


//END:

assign bb0WithI_00002 = { {(2*6){1'b0}}, bb0 } + 18'd1;

assign ggSyn_00000_00002 = 6'd1;


calc_alpha_pow calc_alpha_pow_6_00002_00001_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00000_00002),
                  .calcAlphaPow(ggSyn_00001_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00002_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00001_00002),
                  .calcAlphaPow(ggSyn_00002_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00003_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00002_00002),
                  .calcAlphaPow(ggSyn_00003_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00004_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00003_00002),
                  .calcAlphaPow(ggSyn_00004_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00005_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00004_00002),
                  .calcAlphaPow(ggSyn_00005_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00006_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00005_00002),
                  .calcAlphaPow(ggSyn_00006_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00007_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00006_00002),
                  .calcAlphaPow(ggSyn_00007_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00008_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00007_00002),
                  .calcAlphaPow(ggSyn_00008_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00009_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00008_00002),
                  .calcAlphaPow(ggSyn_00009_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00010_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00009_00002),
                  .calcAlphaPow(ggSyn_00010_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00011_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00010_00002),
                  .calcAlphaPow(ggSyn_00011_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00012_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00011_00002),
                  .calcAlphaPow(ggSyn_00012_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00013_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00012_00002),
                  .calcAlphaPow(ggSyn_00013_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00014_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00013_00002),
                  .calcAlphaPow(ggSyn_00014_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00015_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00014_00002),
                  .calcAlphaPow(ggSyn_00015_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00016_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00015_00002),
                  .calcAlphaPow(ggSyn_00016_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00017_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00016_00002),
                  .calcAlphaPow(ggSyn_00017_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00018_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00017_00002),
                  .calcAlphaPow(ggSyn_00018_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00019_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00018_00002),
                  .calcAlphaPow(ggSyn_00019_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00020_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00019_00002),
                  .calcAlphaPow(ggSyn_00020_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00021_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00020_00002),
                  .calcAlphaPow(ggSyn_00021_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00022_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00021_00002),
                  .calcAlphaPow(ggSyn_00022_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00023_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00022_00002),
                  .calcAlphaPow(ggSyn_00023_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00024_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00023_00002),
                  .calcAlphaPow(ggSyn_00024_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00025_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00024_00002),
                  .calcAlphaPow(ggSyn_00025_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00026_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00025_00002),
                  .calcAlphaPow(ggSyn_00026_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00027_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00026_00002),
                  .calcAlphaPow(ggSyn_00027_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00028_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00027_00002),
                  .calcAlphaPow(ggSyn_00028_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00029_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00028_00002),
                  .calcAlphaPow(ggSyn_00029_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00030_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00029_00002),
                  .calcAlphaPow(ggSyn_00030_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00031_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00030_00002),
                  .calcAlphaPow(ggSyn_00031_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00032_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00031_00002),
                  .calcAlphaPow(ggSyn_00032_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00033_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00032_00002),
                  .calcAlphaPow(ggSyn_00033_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00034_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00033_00002),
                  .calcAlphaPow(ggSyn_00034_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00035_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00034_00002),
                  .calcAlphaPow(ggSyn_00035_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00036_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00035_00002),
                  .calcAlphaPow(ggSyn_00036_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00037_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00036_00002),
                  .calcAlphaPow(ggSyn_00037_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00038_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00037_00002),
                  .calcAlphaPow(ggSyn_00038_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00039_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00038_00002),
                  .calcAlphaPow(ggSyn_00039_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00040_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00039_00002),
                  .calcAlphaPow(ggSyn_00040_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00041_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00040_00002),
                  .calcAlphaPow(ggSyn_00041_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00042_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00041_00002),
                  .calcAlphaPow(ggSyn_00042_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00043_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00042_00002),
                  .calcAlphaPow(ggSyn_00043_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00044_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00043_00002),
                  .calcAlphaPow(ggSyn_00044_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00045_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00044_00002),
                  .calcAlphaPow(ggSyn_00045_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00046_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00045_00002),
                  .calcAlphaPow(ggSyn_00046_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00047_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00046_00002),
                  .calcAlphaPow(ggSyn_00047_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00048_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00047_00002),
                  .calcAlphaPow(ggSyn_00048_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00049_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00048_00002),
                  .calcAlphaPow(ggSyn_00049_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00050_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00049_00002),
                  .calcAlphaPow(ggSyn_00050_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00051_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00050_00002),
                  .calcAlphaPow(ggSyn_00051_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00052_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00051_00002),
                  .calcAlphaPow(ggSyn_00052_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00053_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00052_00002),
                  .calcAlphaPow(ggSyn_00053_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00054_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00053_00002),
                  .calcAlphaPow(ggSyn_00054_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00055_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00054_00002),
                  .calcAlphaPow(ggSyn_00055_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00056_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00055_00002),
                  .calcAlphaPow(ggSyn_00056_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );
calc_alpha_pow calc_alpha_pow_6_00002_00057_U (
                  .iInput(bb0WithI_00002),
                  .num1(ggSyn_00056_00002),
                  .calcAlphaPow(ggSyn_00057_00002),
                  .clk(clk),
                  .clr(clr),
                  .rstn(rstn)

                  );

endmodule
