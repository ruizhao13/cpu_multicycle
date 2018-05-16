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
    input [5:0] Op,
    input [5:0] Funct,
    output reg MemtoReg,// 1 to choose mem, 0 to choose ALUResult
    output reg MemWrite,// 1 to enwrite mem, 0 to not enwrite mem
    output reg Branch,// 
    output reg [5:0] ALUControl,
    output reg ALUSrc, // 1 to immediate, 0 to read_data2
    output reg RegDst,// 1 to 15:11, 0 to 20:16
    output reg RegWrite,
    output reg Jump
    );
endmodule
