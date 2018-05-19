`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2018 03:52:59 PM
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control(
      input clk,
      input rst_n, 
      output reg PCWrite,
      output reg Branch,
      output reg PCSrc,
      output reg [2:0]ALUControl,
      output reg [1:0]ALUSrcB,
      output reg ALUSrcA,
      output reg RegWrite,
      output reg lorD,
      output reg MemWrite,
      output reg IRWrite,
      input  [5:0]Op,
      input  [5:0]Funct,
      output reg RegDst,
      output reg MemtoReg  
    );
endmodule