/*
###############################################################
#  Generated by:      Cadence Innovus 18.13-s088_1
#  OS:                Linux x86_64(Host ID hansolo.poly.edu)
#  Generated on:      Sat Feb 27 20:07:56 2021
#  Design:            gcd
#  Command:           saveNetlist ./out/results/gcd-post-par.v
###############################################################
*/
// Generated by Cadence Genus(TM) Synthesis Solution 18.14-s037_1
// Generated on: Feb 27 2021 20:01:48 EST (Feb 28 2021 01:01:48 UTC)
// Verification Directory fv/gcd 
module gcd (
	clk, 
	req_msg, 
	req_rdy, 
	req_val, 
	reset, 
	resp_msg, 
	resp_rdy, 
	resp_val);
   input clk;
   input [31:0] req_msg;
   output req_rdy;
   input req_val;
   input reset;
   output [15:0] resp_msg;
   input resp_rdy;
   output resp_val;

   // Internal wires
   wire [1:0] ctrl_state$out;
   wire [15:0] dpath_a_reg$out;
   wire [15:0] dpath_b_reg$out;
   wire dpath_sub_sub_752_15_n_311;
   wire dpath_sub_sub_752_15_n_313;
   wire dpath_sub_sub_752_15_n_315;
   wire dpath_sub_sub_752_15_n_317;
   wire dpath_sub_sub_752_15_n_319;
   wire dpath_sub_sub_752_15_n_321;
   wire dpath_sub_sub_752_15_n_323;
   wire dpath_sub_sub_752_15_n_325;
   wire dpath_sub_sub_752_15_n_327;
   wire dpath_sub_sub_752_15_n_329;
   wire dpath_sub_sub_752_15_n_331;
   wire dpath_sub_sub_752_15_n_333;
   wire dpath_sub_sub_752_15_n_335;
   wire dpath_sub_sub_752_15_n_337;
   wire dpath_sub_sub_752_15_n_340;
   wire dpath_sub_sub_752_15_n_341;
   wire dpath_sub_sub_752_15_n_344;
   wire dpath_sub_sub_752_15_n_346;
   wire dpath_sub_sub_752_15_n_347;
   wire dpath_sub_sub_752_15_n_348;
   wire dpath_sub_sub_752_15_n_349;
   wire dpath_sub_sub_752_15_n_350;
   wire dpath_sub_sub_752_15_n_351;
   wire dpath_sub_sub_752_15_n_352;
   wire dpath_sub_sub_752_15_n_353;
   wire dpath_sub_sub_752_15_n_354;
   wire dpath_sub_sub_752_15_n_355;
   wire dpath_sub_sub_752_15_n_356;
   wire dpath_sub_sub_752_15_n_357;
   wire dpath_sub_sub_752_15_n_358;
   wire dpath_sub_sub_752_15_n_359;
   wire n_10;
   wire n_11;
   wire n_12;
   wire n_13;
   wire n_14;
   wire n_15;
   wire n_17;
   wire n_21;
   wire n_22;
   wire n_23;
   wire n_24;
   wire n_25;
   wire n_26;
   wire n_27;
   wire n_28;
   wire n_30;
   wire n_31;
   wire n_33;
   wire n_37;
   wire n_38;
   wire n_39;
   wire n_40;
   wire n_41;
   wire n_42;
   wire n_43;
   wire n_44;
   wire n_45;
   wire n_46;
   wire n_47;
   wire n_48;
   wire n_49;
   wire n_50;
   wire n_51;
   wire n_52;
   wire n_53;
   wire n_54;
   wire n_55;
   wire n_56;
   wire n_57;
   wire n_58;
   wire n_59;
   wire n_60;
   wire n_61;
   wire n_62;
   wire n_63;
   wire n_64;
   wire n_65;
   wire n_66;
   wire n_67;
   wire n_68;
   wire n_69;
   wire n_70;
   wire n_71;
   wire n_72;
   wire n_73;
   wire n_74;
   wire n_75;
   wire n_76;
   wire n_77;
   wire n_78;
   wire n_79;
   wire n_80;
   wire n_81;
   wire n_82;
   wire n_83;
   wire n_84;
   wire n_85;
   wire n_86;
   wire n_87;
   wire n_88;
   wire n_89;
   wire n_90;
   wire n_91;
   wire n_92;
   wire n_93;
   wire n_94;
   wire n_95;
   wire n_96;
   wire n_97;
   wire n_98;
   wire n_99;
   wire n_100;
   wire n_101;
   wire n_102;
   wire n_103;
   wire n_104;
   wire n_105;
   wire n_106;
   wire n_107;
   wire n_108;
   wire n_109;
   wire n_110;
   wire n_111;
   wire n_112;
   wire n_113;
   wire n_114;
   wire n_115;
   wire n_116;
   wire n_117;
   wire n_118;
   wire n_119;
   wire n_120;
   wire n_121;
   wire n_122;
   wire n_123;
   wire n_124;
   wire n_125;
   wire n_126;
   wire n_127;
   wire n_128;
   wire n_129;
   wire n_130;
   wire n_131;
   wire n_132;
   wire n_133;
   wire n_134;
   wire n_135;
   wire n_136;
   wire n_137;
   wire n_138;
   wire n_139;
   wire n_140;
   wire n_141;
   wire n_142;
   wire n_143;
   wire n_144;
   wire n_145;
   wire n_146;
   wire n_147;
   wire n_148;
   wire n_149;
   wire n_150;
   wire n_151;
   wire n_154;

   NOR2_X1 g1436__8780 (.A1(n_151),
	.A2(ctrl_state$out[0]),
	.ZN(resp_val));
   OR2_X1 g1437__4296 (.A1(ctrl_state$out[0]),
	.A2(ctrl_state$out[1]),
	.ZN(n_154));
   DFF_X1 \ctrl_state_out_reg[0]  (.D(n_95),
	.CK(clk),
	.Q(ctrl_state$out[0]),
	.QN(n_14));
   DFF_X1 \ctrl_state_out_reg[1]  (.D(n_94),
	.CK(clk),
	.Q(ctrl_state$out[1]),
	.QN(n_151));
   DFF_X1 \dpath_a_reg_out_reg[0]  (.D(n_139),
	.CK(clk),
	.Q(dpath_a_reg$out[0]),
	.QN(dpath_sub_sub_752_15_n_344));
   DFF_X1 \dpath_a_reg_out_reg[1]  (.D(n_138),
	.CK(clk),
	.Q(dpath_a_reg$out[1]),
	.QN(n_27));
   DFF_X1 \dpath_a_reg_out_reg[2]  (.D(n_141),
	.CK(clk),
	.Q(dpath_a_reg$out[2]),
	.QN(n_21));
   DFF_X1 \dpath_a_reg_out_reg[3]  (.D(n_140),
	.CK(clk),
	.Q(dpath_a_reg$out[3]),
	.QN(n_23));
   DFF_X1 \dpath_a_reg_out_reg[4]  (.D(n_142),
	.CK(clk),
	.Q(dpath_a_reg$out[4]),
	.QN(n_26));
   DFF_X1 \dpath_a_reg_out_reg[5]  (.D(n_137),
	.CK(clk),
	.Q(dpath_a_reg$out[5]),
	.QN(n_10));
   DFF_X1 \dpath_a_reg_out_reg[6]  (.D(n_136),
	.CK(clk),
	.Q(dpath_a_reg$out[6]),
	.QN(n_31));
   DFF_X1 \dpath_a_reg_out_reg[7]  (.D(n_135),
	.CK(clk),
	.Q(dpath_a_reg$out[7]),
	.QN(n_13));
   DFF_X1 \dpath_a_reg_out_reg[8]  (.D(n_148),
	.CK(clk),
	.Q(dpath_a_reg$out[8]),
	.QN(n_11));
   DFF_X1 \dpath_a_reg_out_reg[9]  (.D(n_146),
	.CK(clk),
	.Q(dpath_a_reg$out[9]),
	.QN(n_12));
   DFF_X1 \dpath_a_reg_out_reg[10]  (.D(n_149),
	.CK(clk),
	.Q(dpath_a_reg$out[10]),
	.QN(n_22));
   DFF_X1 \dpath_a_reg_out_reg[11]  (.D(n_147),
	.CK(clk),
	.Q(dpath_a_reg$out[11]),
	.QN(n_25));
   DFF_X1 \dpath_a_reg_out_reg[12]  (.D(n_150),
	.CK(clk),
	.Q(dpath_a_reg$out[12]),
	.QN(n_24));
   DFF_X1 \dpath_a_reg_out_reg[13]  (.D(n_145),
	.CK(clk),
	.Q(dpath_a_reg$out[13]),
	.QN(n_15));
   DFF_X1 \dpath_a_reg_out_reg[14]  (.D(n_144),
	.CK(clk),
	.Q(dpath_a_reg$out[14]),
	.QN(n_30));
   DFF_X1 \dpath_a_reg_out_reg[15]  (.D(n_143),
	.CK(clk),
	.Q(dpath_a_reg$out[15]),
	.QN(n_33));
   DFF_X1 \dpath_b_reg_out_reg[0]  (.D(n_103),
	.CK(clk),
	.Q(dpath_b_reg$out[0]),
	.QN(n_28));
   DFF_X1 \dpath_b_reg_out_reg[1]  (.D(n_117),
	.CK(clk),
	.Q(dpath_b_reg$out[1]),
	.QN(dpath_sub_sub_752_15_n_347));
   DFF_X1 \dpath_b_reg_out_reg[2]  (.D(n_116),
	.CK(clk),
	.Q(dpath_b_reg$out[2]),
	.QN(dpath_sub_sub_752_15_n_346));
   DFF_X1 \dpath_b_reg_out_reg[3]  (.D(n_114),
	.CK(clk),
	.Q(dpath_b_reg$out[3]),
	.QN(dpath_sub_sub_752_15_n_357));
   DFF_X1 \dpath_b_reg_out_reg[4]  (.D(n_115),
	.CK(clk),
	.Q(dpath_b_reg$out[4]),
	.QN(dpath_sub_sub_752_15_n_348));
   DFF_X1 \dpath_b_reg_out_reg[5]  (.D(n_113),
	.CK(clk),
	.Q(dpath_b_reg$out[5]),
	.QN(dpath_sub_sub_752_15_n_354));
   DFF_X1 \dpath_b_reg_out_reg[6]  (.D(n_112),
	.CK(clk),
	.Q(dpath_b_reg$out[6]),
	.QN(dpath_sub_sub_752_15_n_355));
   DFF_X1 \dpath_b_reg_out_reg[7]  (.D(n_111),
	.CK(clk),
	.Q(dpath_b_reg$out[7]),
	.QN(dpath_sub_sub_752_15_n_356));
   DFF_X1 \dpath_b_reg_out_reg[8]  (.D(n_110),
	.CK(clk),
	.Q(dpath_b_reg$out[8]),
	.QN(dpath_sub_sub_752_15_n_350));
   DFF_X1 \dpath_b_reg_out_reg[9]  (.D(n_109),
	.CK(clk),
	.Q(dpath_b_reg$out[9]),
	.QN(dpath_sub_sub_752_15_n_359));
   DFF_X1 \dpath_b_reg_out_reg[10]  (.D(n_108),
	.CK(clk),
	.Q(dpath_b_reg$out[10]),
	.QN(dpath_sub_sub_752_15_n_353));
   DFF_X1 \dpath_b_reg_out_reg[11]  (.D(n_107),
	.CK(clk),
	.Q(dpath_b_reg$out[11]),
	.QN(dpath_sub_sub_752_15_n_349));
   DFF_X1 \dpath_b_reg_out_reg[12]  (.D(n_106),
	.CK(clk),
	.Q(dpath_b_reg$out[12]),
	.QN(dpath_sub_sub_752_15_n_358));
   DFF_X1 \dpath_b_reg_out_reg[13]  (.D(n_105),
	.CK(clk),
	.Q(dpath_b_reg$out[13]),
	.QN(dpath_sub_sub_752_15_n_351));
   DFF_X1 \dpath_b_reg_out_reg[14]  (.D(n_104),
	.CK(clk),
	.Q(dpath_b_reg$out[14]),
	.QN(dpath_sub_sub_752_15_n_352));
   DFF_X1 \dpath_b_reg_out_reg[15]  (.D(n_118),
	.CK(clk),
	.Q(dpath_b_reg$out[15]),
	.QN(n_17));
   OAI22_X1 g3629__3772 (.A1(ctrl_state$out[1]),
	.A2(n_130),
	.B1(n_24),
	.B2(n_151),
	.ZN(n_150));
   OAI22_X1 g3630__1474 (.A1(ctrl_state$out[1]),
	.A2(n_132),
	.B1(n_22),
	.B2(n_151),
	.ZN(n_149));
   OAI22_X1 g3631__4547 (.A1(ctrl_state$out[1]),
	.A2(n_119),
	.B1(n_11),
	.B2(n_151),
	.ZN(n_148));
   OAI22_X1 g3632__9682 (.A1(ctrl_state$out[1]),
	.A2(n_131),
	.B1(n_25),
	.B2(n_151),
	.ZN(n_147));
   OAI22_X1 g3633__2683 (.A1(ctrl_state$out[1]),
	.A2(n_133),
	.B1(n_12),
	.B2(n_151),
	.ZN(n_146));
   OAI22_X1 g3634__1309 (.A1(ctrl_state$out[1]),
	.A2(n_129),
	.B1(n_15),
	.B2(n_151),
	.ZN(n_145));
   OAI22_X1 g3635__6877 (.A1(ctrl_state$out[1]),
	.A2(n_128),
	.B1(n_30),
	.B2(n_151),
	.ZN(n_144));
   OAI22_X1 g3636__2900 (.A1(ctrl_state$out[1]),
	.A2(n_127),
	.B1(n_33),
	.B2(n_151),
	.ZN(n_143));
   OAI22_X1 g3637__2391 (.A1(ctrl_state$out[1]),
	.A2(n_122),
	.B1(n_26),
	.B2(n_151),
	.ZN(n_142));
   OAI22_X1 g3638__7675 (.A1(ctrl_state$out[1]),
	.A2(n_125),
	.B1(n_21),
	.B2(n_151),
	.ZN(n_141));
   OAI22_X1 g3639__7118 (.A1(ctrl_state$out[1]),
	.A2(n_124),
	.B1(n_23),
	.B2(n_151),
	.ZN(n_140));
   OAI22_X1 g3640__8757 (.A1(ctrl_state$out[1]),
	.A2(n_123),
	.B1(dpath_sub_sub_752_15_n_344),
	.B2(n_151),
	.ZN(n_139));
   OAI22_X1 g3641__1786 (.A1(ctrl_state$out[1]),
	.A2(n_126),
	.B1(n_27),
	.B2(n_151),
	.ZN(n_138));
   OAI22_X1 g3642__5953 (.A1(ctrl_state$out[1]),
	.A2(n_121),
	.B1(n_10),
	.B2(n_151),
	.ZN(n_137));
   OAI22_X1 g3643__5703 (.A1(ctrl_state$out[1]),
	.A2(n_120),
	.B1(n_31),
	.B2(n_151),
	.ZN(n_136));
   OAI22_X1 g3644__7114 (.A1(ctrl_state$out[1]),
	.A2(n_134),
	.B1(n_13),
	.B2(n_151),
	.ZN(n_135));
   AOI222_X1 g3661__5266 (.A1(n_99),
	.A2(dpath_b_reg$out[7]),
	.B1(n_100),
	.B2(resp_msg[7]),
	.C1(n_14),
	.C2(req_msg[23]),
	.ZN(n_134));
   AOI222_X1 g3662__2250 (.A1(n_99),
	.A2(dpath_b_reg$out[9]),
	.B1(n_100),
	.B2(resp_msg[9]),
	.C1(n_14),
	.C2(req_msg[25]),
	.ZN(n_133));
   AOI222_X1 g3663__6083 (.A1(n_99),
	.A2(dpath_b_reg$out[10]),
	.B1(n_100),
	.B2(resp_msg[10]),
	.C1(n_14),
	.C2(req_msg[26]),
	.ZN(n_132));
   AOI222_X1 g3664__2703 (.A1(n_99),
	.A2(dpath_b_reg$out[11]),
	.B1(n_100),
	.B2(resp_msg[11]),
	.C1(n_14),
	.C2(req_msg[27]),
	.ZN(n_131));
   AOI222_X1 g3665__5795 (.A1(n_99),
	.A2(dpath_b_reg$out[12]),
	.B1(n_100),
	.B2(resp_msg[12]),
	.C1(n_14),
	.C2(req_msg[28]),
	.ZN(n_130));
   AOI222_X1 g3666__7344 (.A1(n_99),
	.A2(dpath_b_reg$out[13]),
	.B1(n_100),
	.B2(resp_msg[13]),
	.C1(n_14),
	.C2(req_msg[29]),
	.ZN(n_129));
   AOI222_X1 g3667__1840 (.A1(n_99),
	.A2(dpath_b_reg$out[14]),
	.B1(n_100),
	.B2(resp_msg[14]),
	.C1(n_14),
	.C2(req_msg[30]),
	.ZN(n_128));
   AOI222_X1 g3668__5019 (.A1(resp_msg[15]),
	.A2(n_100),
	.B1(n_14),
	.B2(req_msg[31]),
	.C1(n_99),
	.C2(dpath_b_reg$out[15]),
	.ZN(n_127));
   AOI222_X1 g3669__1857 (.A1(n_99),
	.A2(dpath_b_reg$out[1]),
	.B1(n_100),
	.B2(resp_msg[1]),
	.C1(n_14),
	.C2(req_msg[17]),
	.ZN(n_126));
   AOI222_X1 g3670__9906 (.A1(n_99),
	.A2(dpath_b_reg$out[2]),
	.B1(n_100),
	.B2(resp_msg[2]),
	.C1(n_14),
	.C2(req_msg[18]),
	.ZN(n_125));
   AOI222_X1 g3671__8780 (.A1(n_99),
	.A2(dpath_b_reg$out[3]),
	.B1(n_100),
	.B2(resp_msg[3]),
	.C1(n_14),
	.C2(req_msg[19]),
	.ZN(n_124));
   AOI222_X1 g3672__4296 (.A1(n_99),
	.A2(dpath_b_reg$out[0]),
	.B1(n_100),
	.B2(resp_msg[0]),
	.C1(n_14),
	.C2(req_msg[16]),
	.ZN(n_123));
   AOI222_X1 g3673__3772 (.A1(n_99),
	.A2(dpath_b_reg$out[4]),
	.B1(n_100),
	.B2(resp_msg[4]),
	.C1(n_14),
	.C2(req_msg[20]),
	.ZN(n_122));
   AOI222_X1 g3674__1474 (.A1(n_99),
	.A2(dpath_b_reg$out[5]),
	.B1(n_100),
	.B2(resp_msg[5]),
	.C1(n_14),
	.C2(req_msg[21]),
	.ZN(n_121));
   AOI222_X1 g3675__4547 (.A1(n_99),
	.A2(dpath_b_reg$out[6]),
	.B1(n_100),
	.B2(resp_msg[6]),
	.C1(n_14),
	.C2(req_msg[22]),
	.ZN(n_120));
   AOI222_X1 g3676__9682 (.A1(n_99),
	.A2(dpath_b_reg$out[8]),
	.B1(n_100),
	.B2(resp_msg[8]),
	.C1(n_14),
	.C2(req_msg[24]),
	.ZN(n_119));
   OAI22_X1 g3677__2683 (.A1(n_101),
	.A2(n_60),
	.B1(n_102),
	.B2(n_17),
	.ZN(n_118));
   OAI22_X1 g3678__1309 (.A1(n_101),
	.A2(n_52),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_347),
	.ZN(n_117));
   OAI22_X1 g3679__6877 (.A1(n_101),
	.A2(n_57),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_346),
	.ZN(n_116));
   OAI22_X1 g3680__2900 (.A1(n_101),
	.A2(n_54),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_348),
	.ZN(n_115));
   OAI22_X1 g3681__2391 (.A1(n_101),
	.A2(n_56),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_357),
	.ZN(n_114));
   OAI22_X1 g3682__7675 (.A1(n_101),
	.A2(n_48),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_354),
	.ZN(n_113));
   OAI22_X1 g3683__7118 (.A1(n_101),
	.A2(n_62),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_355),
	.ZN(n_112));
   OAI22_X1 g3684__8757 (.A1(n_101),
	.A2(n_47),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_356),
	.ZN(n_111));
   OAI22_X1 g3685__1786 (.A1(n_101),
	.A2(n_53),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_350),
	.ZN(n_110));
   OAI22_X1 g3686__5953 (.A1(n_101),
	.A2(n_58),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_359),
	.ZN(n_109));
   OAI22_X1 g3687__5703 (.A1(n_101),
	.A2(n_51),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_353),
	.ZN(n_108));
   OAI22_X1 g3688__7114 (.A1(n_101),
	.A2(n_55),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_349),
	.ZN(n_107));
   OAI22_X1 g3689__5266 (.A1(n_101),
	.A2(n_50),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_358),
	.ZN(n_106));
   OAI22_X1 g3690__2250 (.A1(n_101),
	.A2(n_61),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_351),
	.ZN(n_105));
   OAI22_X1 g3691__6083 (.A1(n_101),
	.A2(n_49),
	.B1(n_102),
	.B2(dpath_sub_sub_752_15_n_352),
	.ZN(n_104));
   OAI22_X1 g3692__2703 (.A1(n_101),
	.A2(n_67),
	.B1(n_102),
	.B2(n_28),
	.ZN(n_103));
   INV_X1 g3693 (.A(n_102),
	.ZN(n_101));
   OAI21_X2 g3694__5795 (.A(n_154),
	.B1(n_98),
	.B2(ctrl_state$out[1]),
	.ZN(n_102));
   AND2_X1 g3695__7344 (.A1(n_98),
	.A2(ctrl_state$out[0]),
	.ZN(n_100));
   NOR2_X2 g3696__1840 (.A1(n_98),
	.A2(n_14),
	.ZN(n_99));
   OAI221_X1 g3697__5019 (.A(n_80),
	.B1(n_97),
	.B2(n_71),
	.C1(n_64),
	.C2(dpath_b_reg$out[14]),
	.ZN(n_98));
   OAI211_X1 g3698__1857 (.A(n_96),
	.B(n_44),
	.C1(dpath_a_reg$out[12]),
	.C2(dpath_sub_sub_752_15_n_358),
	.ZN(n_97));
   OAI221_X1 g3700__9906 (.A(n_79),
	.B1(n_92),
	.B2(n_69),
	.C1(n_59),
	.C2(dpath_b_reg$out[10]),
	.ZN(n_96));
   NOR2_X1 g3702__8780 (.A1(n_93),
	.A2(reset),
	.ZN(n_95));
   NOR2_X1 g3703__4296 (.A1(n_91),
	.A2(reset),
	.ZN(n_94));
   AOI22_X1 g3704__3772 (.A1(n_90),
	.A2(ctrl_state$out[0]),
	.B1(req_rdy),
	.B2(req_val),
	.ZN(n_93));
   OAI221_X1 g3705__1474 (.A(n_46),
	.B1(n_88),
	.B2(n_73),
	.C1(dpath_a_reg$out[8]),
	.C2(dpath_sub_sub_752_15_n_350),
	.ZN(n_92));
   AOI22_X1 g3706__4547 (.A1(n_89),
	.A2(ctrl_state$out[0]),
	.B1(ctrl_state$out[1]),
	.B2(n_43),
	.ZN(n_91));
   NAND2_X1 g3707__9682 (.A1(n_89),
	.A2(n_151),
	.ZN(n_90));
   AND4_X1 g3708__2683 (.A1(n_86),
	.A2(dpath_sub_sub_752_15_n_350),
	.A3(dpath_sub_sub_752_15_n_352),
	.A4(dpath_sub_sub_752_15_n_346),
	.ZN(n_89));
   OAI22_X1 g3709__1309 (.A1(n_87),
	.A2(n_72),
	.B1(n_13),
	.B2(dpath_b_reg$out[7]),
	.ZN(n_88));
   AOI221_X1 g3710__6877 (.A(n_85),
	.B1(dpath_sub_sub_752_15_n_348),
	.B2(dpath_a_reg$out[4]),
	.C1(dpath_sub_sub_752_15_n_354),
	.C2(dpath_a_reg$out[5]),
	.ZN(n_87));
   AND4_X1 g3711__2900 (.A1(n_84),
	.A2(dpath_sub_sub_752_15_n_358),
	.A3(dpath_sub_sub_752_15_n_359),
	.A4(dpath_sub_sub_752_15_n_349),
	.ZN(n_86));
   AOI222_X1 g3712__2391 (.A1(n_83),
	.A2(dpath_b_reg$out[3]),
	.B1(n_82),
	.B2(n_23),
	.C1(n_26),
	.C2(dpath_b_reg$out[4]),
	.ZN(n_85));
   AND4_X1 g3713__7675 (.A1(n_81),
	.A2(dpath_sub_sub_752_15_n_348),
	.A3(n_17),
	.A4(dpath_sub_sub_752_15_n_351),
	.ZN(n_84));
   OR2_X1 g3714__7118 (.A1(n_82),
	.A2(n_23),
	.ZN(n_83));
   OAI22_X1 g3715__8757 (.A1(n_78),
	.A2(dpath_sub_sub_752_15_n_346),
	.B1(n_76),
	.B2(dpath_a_reg$out[2]),
	.ZN(n_82));
   AND4_X1 g3716__1786 (.A1(n_74),
	.A2(dpath_sub_sub_752_15_n_353),
	.A3(dpath_sub_sub_752_15_n_354),
	.A4(dpath_sub_sub_752_15_n_356),
	.ZN(n_81));
   AOI22_X1 g3717__5953 (.A1(n_77),
	.A2(n_70),
	.B1(n_17),
	.B2(dpath_a_reg$out[15]),
	.ZN(n_80));
   AOI22_X1 g3718__5703 (.A1(n_75),
	.A2(n_68),
	.B1(dpath_sub_sub_752_15_n_349),
	.B2(dpath_a_reg$out[11]),
	.ZN(n_79));
   AND2_X1 g3719__7114 (.A1(n_76),
	.A2(dpath_a_reg$out[2]),
	.ZN(n_78));
   OAI22_X1 g3720__5266 (.A1(n_63),
	.A2(dpath_b_reg$out[12]),
	.B1(n_15),
	.B2(dpath_b_reg$out[13]),
	.ZN(n_77));
   OAI22_X1 g3721__2250 (.A1(n_66),
	.A2(dpath_b_reg$out[8]),
	.B1(n_12),
	.B2(dpath_b_reg$out[9]),
	.ZN(n_75));
   AOI22_X1 g3722__6083 (.A1(n_65),
	.A2(dpath_b_reg$out[1]),
	.B1(n_45),
	.B2(n_27),
	.ZN(n_76));
   NOR4_X1 g3723__2703 (.A1(dpath_b_reg$out[3]),
	.A2(dpath_b_reg$out[6]),
	.A3(dpath_b_reg$out[0]),
	.A4(dpath_b_reg$out[1]),
	.ZN(n_74));
   NOR3_X1 g3724__5795 (.A1(n_42),
	.A2(n_31),
	.A3(dpath_b_reg$out[6]),
	.ZN(n_73));
   OAI221_X1 g3725__7344 (.A(n_41),
	.B1(dpath_sub_sub_752_15_n_355),
	.B2(dpath_a_reg$out[6]),
	.C1(dpath_a_reg$out[5]),
	.C2(dpath_sub_sub_752_15_n_354),
	.ZN(n_72));
   INV_X1 g3726 (.A(n_70),
	.ZN(n_71));
   INV_X1 g3727 (.A(n_68),
	.ZN(n_69));
   AOI22_X1 g3728__1840 (.A1(req_rdy),
	.A2(req_msg[0]),
	.B1(n_154),
	.B2(dpath_a_reg$out[0]),
	.ZN(n_67));
   NAND2_X1 g3729__5019 (.A1(n_46),
	.A2(dpath_a_reg$out[8]),
	.ZN(n_66));
   OR2_X1 g3730__1857 (.A1(n_45),
	.A2(n_27),
	.ZN(n_65));
   NAND2_X1 g3731__9906 (.A1(n_40),
	.A2(dpath_a_reg$out[14]),
	.ZN(n_64));
   NAND2_X1 g3732__8780 (.A1(n_44),
	.A2(dpath_a_reg$out[12]),
	.ZN(n_63));
   AOI22_X1 g3733__4296 (.A1(req_rdy),
	.A2(req_msg[6]),
	.B1(n_154),
	.B2(dpath_a_reg$out[6]),
	.ZN(n_62));
   AOI22_X1 g3734__3772 (.A1(req_rdy),
	.A2(req_msg[13]),
	.B1(n_154),
	.B2(dpath_a_reg$out[13]),
	.ZN(n_61));
   AOI22_X1 g3735__1474 (.A1(req_rdy),
	.A2(req_msg[15]),
	.B1(n_154),
	.B2(dpath_a_reg$out[15]),
	.ZN(n_60));
   NAND2_X1 g3736__4547 (.A1(n_38),
	.A2(dpath_a_reg$out[10]),
	.ZN(n_59));
   AOI21_X1 g3737__9682 (.A(n_39),
	.B1(n_30),
	.B2(dpath_b_reg$out[14]),
	.ZN(n_70));
   AOI21_X1 g3738__2683 (.A(n_37),
	.B1(n_22),
	.B2(dpath_b_reg$out[10]),
	.ZN(n_68));
   AOI22_X1 g3739__1309 (.A1(req_rdy),
	.A2(req_msg[9]),
	.B1(n_154),
	.B2(dpath_a_reg$out[9]),
	.ZN(n_58));
   AOI22_X1 g3740__6877 (.A1(req_rdy),
	.A2(req_msg[2]),
	.B1(n_154),
	.B2(dpath_a_reg$out[2]),
	.ZN(n_57));
   AOI22_X1 g3741__2900 (.A1(req_rdy),
	.A2(req_msg[3]),
	.B1(n_154),
	.B2(dpath_a_reg$out[3]),
	.ZN(n_56));
   AOI22_X1 g3742__2391 (.A1(req_rdy),
	.A2(req_msg[11]),
	.B1(n_154),
	.B2(dpath_a_reg$out[11]),
	.ZN(n_55));
   AOI22_X1 g3743__7675 (.A1(req_rdy),
	.A2(req_msg[4]),
	.B1(n_154),
	.B2(dpath_a_reg$out[4]),
	.ZN(n_54));
   AOI22_X1 g3744__7118 (.A1(req_rdy),
	.A2(req_msg[8]),
	.B1(n_154),
	.B2(dpath_a_reg$out[8]),
	.ZN(n_53));
   AOI22_X1 g3745__8757 (.A1(req_rdy),
	.A2(req_msg[1]),
	.B1(n_154),
	.B2(dpath_a_reg$out[1]),
	.ZN(n_52));
   AOI22_X1 g3746__1786 (.A1(req_rdy),
	.A2(req_msg[10]),
	.B1(n_154),
	.B2(dpath_a_reg$out[10]),
	.ZN(n_51));
   AOI22_X1 g3747__5953 (.A1(req_rdy),
	.A2(req_msg[12]),
	.B1(n_154),
	.B2(dpath_a_reg$out[12]),
	.ZN(n_50));
   AOI22_X1 g3748__5703 (.A1(req_rdy),
	.A2(req_msg[14]),
	.B1(n_154),
	.B2(dpath_a_reg$out[14]),
	.ZN(n_49));
   AOI22_X1 g3749__7114 (.A1(req_rdy),
	.A2(req_msg[5]),
	.B1(n_154),
	.B2(dpath_a_reg$out[5]),
	.ZN(n_48));
   AOI22_X1 g3750__5266 (.A1(req_rdy),
	.A2(req_msg[7]),
	.B1(n_154),
	.B2(dpath_a_reg$out[7]),
	.ZN(n_47));
   NAND2_X1 g3751__2250 (.A1(n_14),
	.A2(resp_rdy),
	.ZN(n_43));
   NAND2_X1 g3752__6083 (.A1(n_12),
	.A2(dpath_b_reg$out[9]),
	.ZN(n_46));
   NOR2_X1 g3753__2703 (.A1(n_28),
	.A2(dpath_a_reg$out[0]),
	.ZN(n_45));
   NAND2_X1 g3754__5795 (.A1(n_15),
	.A2(dpath_b_reg$out[13]),
	.ZN(n_44));
   INV_X1 g3755 (.A(n_41),
	.ZN(n_42));
   INV_X1 g3756 (.A(n_39),
	.ZN(n_40));
   INV_X1 g3757 (.A(n_37),
	.ZN(n_38));
   NAND2_X1 g3759__7344 (.A1(n_13),
	.A2(dpath_b_reg$out[7]),
	.ZN(n_41));
   NOR2_X1 g3760__1840 (.A1(n_17),
	.A2(dpath_a_reg$out[15]),
	.ZN(n_39));
   NOR2_X1 g3761__5019 (.A1(dpath_sub_sub_752_15_n_349),
	.A2(dpath_a_reg$out[11]),
	.ZN(n_37));
   INV_X1 g3781 (.A(n_154),
	.ZN(req_rdy));
   XNOR2_X1 dpath_sub_sub_752_15_g436__1857 (.A(dpath_sub_sub_752_15_n_311),
	.B(dpath_sub_sub_752_15_n_340),
	.ZN(resp_msg[15]));
   FA_X1 dpath_sub_sub_752_15_g437__9906 (.A(dpath_sub_sub_752_15_n_352),
	.B(dpath_a_reg$out[14]),
	.CI(dpath_sub_sub_752_15_n_313),
	.CO(dpath_sub_sub_752_15_n_311),
	.S(resp_msg[14]));
   FA_X1 dpath_sub_sub_752_15_g438__8780 (.A(dpath_sub_sub_752_15_n_351),
	.B(dpath_a_reg$out[13]),
	.CI(dpath_sub_sub_752_15_n_315),
	.CO(dpath_sub_sub_752_15_n_313),
	.S(resp_msg[13]));
   FA_X1 dpath_sub_sub_752_15_g439__4296 (.A(dpath_sub_sub_752_15_n_358),
	.B(dpath_a_reg$out[12]),
	.CI(dpath_sub_sub_752_15_n_317),
	.CO(dpath_sub_sub_752_15_n_315),
	.S(resp_msg[12]));
   FA_X1 dpath_sub_sub_752_15_g440__3772 (.A(dpath_sub_sub_752_15_n_349),
	.B(dpath_a_reg$out[11]),
	.CI(dpath_sub_sub_752_15_n_319),
	.CO(dpath_sub_sub_752_15_n_317),
	.S(resp_msg[11]));
   FA_X1 dpath_sub_sub_752_15_g441__1474 (.A(dpath_sub_sub_752_15_n_353),
	.B(dpath_a_reg$out[10]),
	.CI(dpath_sub_sub_752_15_n_321),
	.CO(dpath_sub_sub_752_15_n_319),
	.S(resp_msg[10]));
   FA_X1 dpath_sub_sub_752_15_g442__4547 (.A(dpath_sub_sub_752_15_n_359),
	.B(dpath_a_reg$out[9]),
	.CI(dpath_sub_sub_752_15_n_323),
	.CO(dpath_sub_sub_752_15_n_321),
	.S(resp_msg[9]));
   FA_X1 dpath_sub_sub_752_15_g443__9682 (.A(dpath_sub_sub_752_15_n_350),
	.B(dpath_a_reg$out[8]),
	.CI(dpath_sub_sub_752_15_n_325),
	.CO(dpath_sub_sub_752_15_n_323),
	.S(resp_msg[8]));
   FA_X1 dpath_sub_sub_752_15_g444__2683 (.A(dpath_sub_sub_752_15_n_356),
	.B(dpath_a_reg$out[7]),
	.CI(dpath_sub_sub_752_15_n_327),
	.CO(dpath_sub_sub_752_15_n_325),
	.S(resp_msg[7]));
   FA_X1 dpath_sub_sub_752_15_g445__1309 (.A(dpath_sub_sub_752_15_n_355),
	.B(dpath_a_reg$out[6]),
	.CI(dpath_sub_sub_752_15_n_329),
	.CO(dpath_sub_sub_752_15_n_327),
	.S(resp_msg[6]));
   FA_X1 dpath_sub_sub_752_15_g446__6877 (.A(dpath_sub_sub_752_15_n_354),
	.B(dpath_a_reg$out[5]),
	.CI(dpath_sub_sub_752_15_n_331),
	.CO(dpath_sub_sub_752_15_n_329),
	.S(resp_msg[5]));
   FA_X1 dpath_sub_sub_752_15_g447__2900 (.A(dpath_sub_sub_752_15_n_348),
	.B(dpath_a_reg$out[4]),
	.CI(dpath_sub_sub_752_15_n_333),
	.CO(dpath_sub_sub_752_15_n_331),
	.S(resp_msg[4]));
   FA_X1 dpath_sub_sub_752_15_g448__2391 (.A(dpath_sub_sub_752_15_n_357),
	.B(dpath_a_reg$out[3]),
	.CI(dpath_sub_sub_752_15_n_335),
	.CO(dpath_sub_sub_752_15_n_333),
	.S(resp_msg[3]));
   FA_X1 dpath_sub_sub_752_15_g449__7675 (.A(dpath_sub_sub_752_15_n_346),
	.B(dpath_a_reg$out[2]),
	.CI(dpath_sub_sub_752_15_n_337),
	.CO(dpath_sub_sub_752_15_n_335),
	.S(resp_msg[2]));
   FA_X1 dpath_sub_sub_752_15_g450__7118 (.A(dpath_sub_sub_752_15_n_347),
	.B(dpath_a_reg$out[1]),
	.CI(dpath_sub_sub_752_15_n_341),
	.CO(dpath_sub_sub_752_15_n_337),
	.S(resp_msg[1]));
   OAI21_X1 dpath_sub_sub_752_15_g451__8757 (.A(dpath_sub_sub_752_15_n_341),
	.B1(dpath_sub_sub_752_15_n_344),
	.B2(dpath_b_reg$out[0]),
	.ZN(resp_msg[0]));
   XOR2_X1 dpath_sub_sub_752_15_g452__1786 (.A(dpath_b_reg$out[15]),
	.B(dpath_a_reg$out[15]),
	.Z(dpath_sub_sub_752_15_n_340));
   NAND2_X1 dpath_sub_sub_752_15_g453__5953 (.A1(dpath_sub_sub_752_15_n_344),
	.A2(dpath_b_reg$out[0]),
	.ZN(dpath_sub_sub_752_15_n_341));
endmodule

