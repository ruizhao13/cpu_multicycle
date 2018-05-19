// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Sun May 20 00:03:36 2018
// Host        : DESKTOP-RONFFCB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/study/COD/lab/lab6_cpu_mulcyc/project_1/project_1.srcs/sources_1/ip/memory/memory_stub.v
// Design      : memory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a75tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module memory(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[7:0],dina[31:0],clkb,enb,addrb[7:0],doutb[31:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [7:0]addra;
  input [31:0]dina;
  input clkb;
  input enb;
  input [7:0]addrb;
  output [31:0]doutb;
endmodule
